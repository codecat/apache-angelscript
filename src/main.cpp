#include <cstdio>

#include <apache2/httpd.h>
#include <apache2/http_core.h>
#include <apache2/http_protocol.h>
#include <apache2/http_request.h>

#include <PageHandler.h>

static int example_handler(request_rec* r)
{
	if (!r->handler || strcmp(r->handler, "application/x-httpd-angelscript")) {
		return DECLINED;
	}

	PageHandler ph;
	ph.HandleRequest(r);

	//ap_set_content_type(r, "text/html");
	//ap_rprintf(r, "aaa %d", 1);

	return OK;
}

static void register_hooks(apr_pool_t* pool)
{
	ap_hook_handler(example_handler, NULL, NULL, APR_HOOK_LAST);
}

module AP_MODULE_DECLARE_DATA angelscript_module =
{
	STANDARD20_MODULE_STUFF,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	register_hooks
};

