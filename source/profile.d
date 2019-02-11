module profile;

import vibe.http.server : HTTPServerRequest, HTTPServerResponse;

interface IProfileInterface
{
    /++
        GET /me
    +/
    void getMe (HTTPServerRequest req, HTTPServerResponse);

    /++
        GET /logout
    +/
    void getLogout (HTTPServerRequest req, HTTPServerResponse);
}

class ProfileInterface : IProfileInterface
{
    /++
        GET /me
    +/
    void getMe (HTTPServerRequest req, HTTPServerResponse)
    {
        import vibe.web.web : render;
        import web : getWebInfo, WebInfo;
        import github : getCurrentUser, User;

        const WebInfo webInfo = getWebInfo (req);

        const User user = getCurrentUser (req);

        render!("profile.dt", webInfo, user);
    }

    /++
        GET /logout
    +/
    void getLogout (HTTPServerRequest, HTTPServerResponse res)
    {
        import github : logout;

        logout (res);
    }
}