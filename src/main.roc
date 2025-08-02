# main.roc
# Blog entry point - uses the framework module

app [Model, init!, respond!] {
    pf: platform "https://github.com/roc-lang/basic-webserver/releases/download/0.12.0/Q4h_In-sz1BqAvlpmCsBHhEJnn_YvfRRMiNACB_fBbk.tar.br"
}

import pf.Stdout
import pf.Http exposing [Request, Response]
import pf.Utc

# Your personal blog using the Roc SSR framework
# This file can be customized for your specific blog needs

Model : {}

init! : {} => Result Model []
init! = |{}| Ok({})

respond! : Request, Model => Result Response [ServerErr Str]_
respond! = |req, _|
    # Log request datetime, method and url
    datetime = Utc.to_iso_8601(Utc.now!({}))

    Stdout.line!("${datetime} ${Inspect.to_str(req.method)} ${req.uri}")?

    # Use framework routing with blog-specific customizations
    when req.uri is
        "/" -> 
            Ok(
                {
                    status: 200,
                    headers: [],
                    body: Str.to_utf8(blogHomepageHtml),
                },
            )
        "/about" ->
            Ok(
                {
                    status: 200,
                    headers: [],
                    body: Str.to_utf8(blogAboutHtml),
                },
            )
        _ ->
            Ok(
                {
                    status: 404,
                    headers: [],
                    body: Str.to_utf8(blogNotFoundHtml),
                },
            )

# Blog-specific HTML templates (your content)
blogHomepageHtml = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>My Tech Blog</title><script src=\"https://unpkg.com/htmx.org@1.9.10\"></script></head><body><header><h1>🚀 My Tech Blog</h1><nav><a href=\"/\">Home</a> <a href=\"/about\">About</a></nav></header><main><h2>Welcome to My Technical Thoughts</h2><p>This is where I share my thoughts on Roc, HTMX, and modern web development.</p><div><button hx-get=\"/api/hello\" hx-target=\"#message\">Click me for HTMX magic!</button><div id=\"message\"></div></div></main></body></html>"

blogAboutHtml = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>About - My Tech Blog</title><script src=\"https://unpkg.com/htmx.org@1.9.10\"></script></head><body><header><h1>About</h1><nav><a href=\"/\">Home</a> <a href=\"/about\">About</a></nav></header><main><h2>About Me</h2><p>I'm a developer exploring modern web technologies like Roc and HTMX. This blog is where I share my learnings and thoughts.</p></main></body></html>"

blogNotFoundHtml = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><title>404 - Not Found</title></head><body><h1>404 - Page Not Found</h1><p>The page you're looking for doesn't exist.</p><a href=\"/\">Go back home</a></body></html>" 