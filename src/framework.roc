# framework.roc
# Core framework functionality that can be extracted to separate repo

app [Model, init!, respond!] {
    pf: platform "https://github.com/roc-lang/basic-webserver/releases/download/0.12.0/Q4h_In-sz1BqAvlpmCsBHhEJnn_YvfRRMiNACB_fBbk.tar.br"
}

import pf.Stdout
import pf.Http exposing [Request, Response]
import pf.Utc

# Roc SSR Blog Framework
# This module provides the core framework functionality

Model : {}

init! : {} => Result Model []
init! = |{}| Ok({})

# Core framework functions
respond! : Request, Model => Result Response [ServerErr Str]_
respond! = |req, _|
    # Log request datetime, method and url
    datetime = Utc.to_iso_8601(Utc.now!({}))

    Stdout.line!("${datetime} ${Inspect.to_str(req.method)} ${req.uri}")?

    # Route to appropriate handler
    routeRequest req

# Framework routing logic
routeRequest : Request -> Result Response [ServerErr Str]_
routeRequest = \req ->
    when req.uri is
        "/" -> 
            Ok(
                {
                    status: 200,
                    headers: [],
                    body: Str.to_utf8(homepageHtml),
                },
            )
        "/about" ->
            Ok(
                {
                    status: 200,
                    headers: [],
                    body: Str.to_utf8(aboutHtml),
                },
            )
        _ ->
            Ok(
                {
                    status: 404,
                    headers: [],
                    body: Str.to_utf8(notFoundHtml),
                },
            )

# Framework HTML templates
homepageHtml = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>Roc SSR Blog</title><script src=\"https://unpkg.com/htmx.org@1.9.10\"></script></head><body><header><h1>🎉 Roc SSR Blog Framework</h1><nav><a href=\"/\">Home</a> <a href=\"/about\">About</a></nav></header><main><h2>Welcome to the Roc SSR Blog Framework!</h2><p>This is a framework for building blogs with Roc, HTMX, and modern web technologies.</p><div><button hx-get=\"/api/hello\" hx-target=\"#message\">Test HTMX</button><div id=\"message\"></div></div></main></body></html>"

aboutHtml = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>About - Roc SSR Blog</title><script src=\"https://unpkg.com/htmx.org@1.9.10\"></script></head><body><header><h1>About</h1><nav><a href=\"/\">Home</a> <a href=\"/about\">About</a></nav></header><main><h2>About This Framework</h2><p>This is a modern blog framework built with Roc and HTMX, demonstrating server-side rendering with dynamic interactions.</p></main></body></html>"

notFoundHtml = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>404 - Not Found</title></head><body><h1>404 - Page Not Found</h1><p>The page you're looking for doesn't exist.</p><a href=\"/\">Go back home</a></body></html>" 