#pragma once

#include <Common.h>

#include <angelscript.h>
#include <apache2/httpd.h>

class PageHandler
{
private:
	asIScriptEngine* m_engine;

	request_rec* m_request;

public:
	PageHandler();
	~PageHandler();

	void ScriptSetContentType(const std::string &contenttype);
	void ScriptPrint(const std::string &str);

	void RegisterEngine();

	int HandleRequest(request_rec* req);
};

