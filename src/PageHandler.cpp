#include <PageHandler.h>

PageHandler::PageHandler()
{
	m_engine = asCreateScriptEngine();
	m_ctx = nullptr;
}

PageHandler::~PageHandler()
{
}

void PageHandler::HandleRequest(request_rec* r)
{
	//todo
}

