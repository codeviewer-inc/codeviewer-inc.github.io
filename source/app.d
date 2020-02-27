import vibe.d;

void displayError(HTTPServerRequest req, HTTPServerResponse res, HTTPServerErrorInfo error)
{
	string errorDebug = "";
	debug errorDebug = error.debugMessage;
	
	res.render!("error.dt", error, errorDebug);
}

public void main()
{
	import pastemyst.web : WebInterface;
	import pastemyst.rest : APIPaste;
	import pastemyst.db : connect;

	URLRouter router = new URLRouter();
	router.get("*", serveStaticFiles("public"));
	router.registerWebInterface(new WebInterface());
	router.registerRestInterface(new APIPaste());

	HTTPServerSettings serverSettings = new HTTPServerSettings();
	serverSettings.bindAddresses = ["127.0.0.1"];
	serverSettings.port = 5000;
	serverSettings.errorPageHandler = toDelegate(&displayError);

	listenHTTP(serverSettings, router);

	connect();

	runApplication();
}
