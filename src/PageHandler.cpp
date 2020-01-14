#include <Common.h>
#include <PageHandler.h>

#include <apache2/httpd.h>
#include <apache2/http_core.h>
#include <apache2/http_protocol.h>
#include <apache2/http_request.h>

#include <scriptstdstring/scriptstdstring.h>
#include <scriptarray/scriptarray.h>
#include <scriptbuilder/scriptbuilder.h>

PageHandler::PageHandler()
{
	m_engine = asCreateScriptEngine();
}

PageHandler::~PageHandler()
{
	m_engine->ShutDownAndRelease();
}

void PageHandler::ScriptSetContentType(const std::string &contenttype)
{
	ap_set_content_type(m_request, contenttype.c_str());
}

void PageHandler::ScriptPrint(const std::string &str)
{
	ap_rwrite(str.c_str(), str.size(), m_request);
}

void PageHandler::RegisterEngine()
{
	RegisterStdString(m_engine);
	RegisterScriptArray(m_engine, true);
	RegisterStdStringUtils(m_engine);

	int r = 0;

	r = m_engine->RegisterGlobalFunction("void set_content_type(const string &in contenttype)", asMETHOD(PageHandler, ScriptSetContentType), asCALL_THISCALL_ASGLOBAL, this); assert(r >= 0);
	r = m_engine->RegisterGlobalFunction("void print(const string &in str)", asMETHOD(PageHandler, ScriptPrint), asCALL_THISCALL_ASGLOBAL, this); assert(r >= 0);
}

int PageHandler::HandleRequest(request_rec* req)
{
	m_request = req;

	CScriptBuilder builder;
	builder.StartNewModule(m_engine, "Script");
	builder.AddSectionFromFile(req->filename);
	int r = builder.BuildModule();

	if (r < 0) {
		ap_set_content_type(m_request, "text/plain");
		ap_rprintf(m_request, "Script build error: %d\n", r);
		//TODO: Add AS debug output here (SetMessageCallback)
		return OK;
	}

	asIScriptModule* mod = builder.GetModule();
	asIScriptFunction* funcMain = mod->GetFunctionByDecl("void main()");
	if (funcMain == nullptr) {
		//TODO: More descriptive error
		ap_set_content_type(m_request, "text/plain");
		ap_rprintf(m_request, "Missing entrypoint function in script! Make a main() function.");
		return OK;
	}

	//TODO: We'll probably have to store the context somewhere for later recursive calling
	asIScriptContext* ctx = m_engine->CreateContext();
	ctx->Prepare(funcMain);
	r = ctx->Execute();
	if (r == asEXECUTION_EXCEPTION) {
		ap_rprintf(m_request, "<b>Script exception!</b>");
		//TODO: Add more information
		return OK;
	}
	ctx->Unprepare();
	ctx->Release();

	return OK;
}

