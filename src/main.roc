# main.roc
# Direct Roc HTTP server application - no framework abstraction

app [Model, init!, respond!] {
    pf: platform "https://github.com/roc-lang/basic-webserver/releases/download/0.12.0/Q4h_In-sz1BqAvlpmCsBHhEJnn_YvfRRMiNACB_fBbk.tar.br"
}

import pf.Stdout
import pf.Http exposing [Request, Response]
import pf.Utc
import pf.File

# Your personal blog - direct Roc HTTP server application
# This is a simple, direct implementation without framework abstractions

Model : {}

init! : {} => Result Model []
init! = |{}| Ok({})

respond! : Request, Model => Result Response [ServerErr Str]_
respond! = |req, _|
    # Log request datetime, method and url
    datetime = Utc.to_iso_8601(Utc.now!({}))

    Stdout.line!("${datetime} ${Inspect.to_str(req.method)} ${req.uri}")?

    # Direct routing - no framework abstraction
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
        "/css/output.css" -> serveCssFile!({})
        "/api/hello" ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/html"}],
                    body: Str.to_utf8(htmxResponseHtml),
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

# Helper function to serve CSS file
serveCssFile! : {} => Result Response [ServerErr Str]
serveCssFile! = |_|
    cssResult = File.read_utf8!("static/css/output.css")
    
    when cssResult is
        Ok(css) ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/css"}],
                    body: Str.to_utf8(css),
                },
            )
        Err(_) ->
            Ok(
                {
                    status: 500,
                    headers: [{name: "Content-Type", value: "text/plain"}],
                    body: Str.to_utf8("Internal Server Error: Could not load CSS file"),
                },
            )

# Blog-specific HTML templates (your content)
blogHomepageHtml =
"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Tech Blog</title>
        <link rel="stylesheet" href="/css/output.css">
        <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    </head>
    <body class="bg-gray-50 min-h-screen">
        <header class="bg-white shadow-sm border-b">
            <div class="max-w-4xl mx-auto px-4 py-6">
                <h1 class="text-3xl font-bold text-gray-900 mb-4">🚀 My Tech Blog</h1>
                <nav class="space-x-4">
                    <a href="/" class="text-blue-600 hover:text-blue-800 font-medium">Home</a> 
                    <a href="/about" class="text-blue-600 hover:text-blue-800 font-medium">About</a>
                    <a href="/blog" class="text-blue-600 hover:text-blue-800 font-medium">Blog</a>
                </nav>
            </div>
        </header>
        <main class="max-w-4xl mx-auto px-4 py-8">
            <h2 class="text-2xl font-semibold text-gray-900 mb-4">Welcome to My Technical Thoughts</h2>
            <p class="text-gray-600 mb-6">This is where I share my thoughts on Roc, HTMX, and modern web development.</p>
            
            <div class="space-y-4">
                <button class="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition-colors" hx-get="/api/hello" hx-target="#message">Click me for HTMX magic!</button>
                <div id="message" class="mt-4 p-4 bg-gray-100 rounded-lg"></div>
            </div>
        </main>
    </body>
    </html>
"""

blogAboutHtml =
"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About - My Tech Blog</title>
        <link rel="stylesheet" href="/css/output.css">
        <script src="https://unpkg.com/htmx.org@1.9.10"></script>
    </head>
    <body class="bg-gray-50 min-h-screen">
        <header class="bg-white shadow-sm border-b">
            <div class="max-w-4xl mx-auto px-4 py-6">
                <h1 class="text-3xl font-bold text-gray-900 mb-4">About</h1>
                <nav class="space-x-4">
                    <a href="/" class="text-blue-600 hover:text-blue-800 font-medium">Home</a> 
                    <a href="/about" class="text-blue-600 hover:text-blue-800 font-medium">About</a>
                </nav>
            </div>
        </header>
        <main class="max-w-4xl mx-auto px-4 py-8">
            <h2 class="text-2xl font-semibold text-gray-900 mb-4">About Me</h2>
            <p class="text-gray-600">I'm a developer exploring modern web technologies like Roc and HTMX. This blog is where I share my learnings and thoughts.</p>
        </main>
    </body>
    </html>
"""

blogNotFoundHtml =
"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>404 - Not Found</title>
    </head>
    <body>
        <h1>404 - Page Not Found</h1>
        <p>The page you're looking for doesn't exist.</p>
        <a href="/">Go back home</a>
    </body>
    </html>
"""

# HTMX response template
htmxResponseHtml =
"""
    <div class="p-4 bg-green-50 border border-green-200 rounded-lg">
        <div class="flex items-center">
            <svg class="w-5 h-5 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
            <h4 class="text-green-800 font-semibold">HTMX Magic Working! ✨</h4>
        </div>
        <p class="text-green-700 mt-2">
            This content was loaded dynamically using HTMX without a page refresh. 
            The power of modern web development with Roc and HTMX!
        </p>
        <div class="mt-3 text-sm text-green-600">
            <strong>Status:</strong> Successfully loaded via HTMX
        </div>
    </div>
""" 