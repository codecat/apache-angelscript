#pragma once

#include <angelscript.h>

#include <apache2/httpd.h>

class PageHandler
{
private:
	asIScriptEngine* m_engine;
	asIScriptContext* m_ctx;

public:
	PageHandler();
	~PageHandler();

	void HandleRequest(request_rec* r);
};

