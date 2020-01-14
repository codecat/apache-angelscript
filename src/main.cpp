#include <cstdio>

#include <apache2/httpd.h>
#include <apache2/http_core.h>
#include <apache2/http_protocol.h>
#include <apache2/http_request.h>

class Foo
{
private:
	request_rec* m_req;

public:
	Foo(request_rec* r)
	{
		m_req = r;
		ap_rprintf(m_req, "It works from <b>C++</b>!");
	}

	void Thing()
	{
		ap_rprintf(m_req, "<br>The URL is: <code>%s</code>", m_req->filename);
	}
};

static int example_handler(request_rec* r)
{
	if (!r->handler || strcmp(r->handler, "application/x-httpd-angelscript")) {
		return DECLINED;
	}

	ap_set_content_type(r, "text/html");

	Foo f(r);
	f.Thing();

	return OK;
}

static void register_hooks(apr_pool_t* pool)
{
	ap_hook_handler(example_handler, NULL, NULL, APR_HOOK_LAST);
}

module AP_MODULE_DECLARE_DATA atest2_module =
{
	STANDARD20_MODULE_STUFF,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	register_hooks
};

