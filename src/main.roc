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
        "/static/css/output.css" -> serveCssFile!({})
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
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tech Blog</title>
    <link rel="stylesheet" href="/static/css/output.css">
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
</head>
<body class="min-h-screen bg-base-100">
    <div class="navbar bg-base-200 shadow-lg">
        <div class="navbar-start">
            <a href="/" class="btn btn-ghost text-xl">🚀 My Tech Blog</a>
        </div>
        <div class="navbar-center">
            <ul class="menu menu-horizontal px-1">
                <li><a href="/" class="text-primary">Home</a></li>
                <li><a href="/about" class="text-primary">About</a></li>
                <li><a href="/blog" class="text-primary">Blog</a></li>
            </ul>
        </div>
        <div class="navbar-end">
            <label class="swap swap-rotate">
                <input type="checkbox" class="theme-controller" value="dark" />
                <svg class="swap-on fill-current w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M5.64,17l-.71.71a1,1,0,0,0,0,1.41,1,1,0,0,0,1.41,0l.71-.71A1,1,0,0,0,5.64,17ZM5,12a1,1,0,0,0-1-1H3a1,1,0,0,0,0,2H4A1,1,0,0,0,5,12Zm7-7a1,1,0,0,0,1-1V3a1,1,0,0,0-2,0V4A1,1,0,0,0,12,5ZM5.64,7.05a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.41l-.71-.71A1,1,0,0,0,4.93,6.34Zm12,.29a1,1,0,0,0,.7-.29l.71-.71a1,1,0,1,0-1.41-1.41L17,5.64a1,1,0,0,0,0,1.41A1,1,0,0,0,17.66,7.34ZM21,11H20a1,1,0,0,0,0,2h1a1,0,0,0,0-2Zm-9,8a1,1,0,0,0-1,1v1a1,1,0,0,0,2,0V20A1,1,0,0,0,12,19ZM18.36,17A1,1,0,0,0,17,18.36l.71.71a1,1,0,0,0,1.41,0,1,1,0,0,0,0-1.41ZM12,6.5A5.5,5.5,0,1,0,17.5,12,5.51,5.51,0,0,0,12,6.5Zm0,9A3.5,3.5,0,1,1,15.5,12,3.5,3.5,0,0,1,12,15.5Z"/>
                </svg>
                <svg class="swap-off fill-current w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M21.64,13a1,1,0,0,0-1.05-.14,8.05,8.05,0,0,1-3.37.73A8.15,8.15,0,0,1,9.08,5.49a8.59,8.59,0,0,1,.25-2A1,1,0,0,0,8,2.36,10.14,10.14,0,1,0,22,14.05,1,1,0,0,0,21.64,13Zm-9.5,6.69A8.14,8.14,0,0,1,7.08,5.22v.27A10.15,10.15,0,0,0,17.22,15.63a9.79,9.79,0,0,0,2.1-.22A8.11,8.11,0,0,1,12.14,19.73Z"/>
                </svg>
            </label>
        </div>
    </div>
    
    <main class="container mx-auto px-4 py-8">
        <div class="hero bg-base-200 rounded-lg p-8 mb-8">
            <div class="hero-content text-center">
                <div class="max-w-md">
                    <h1 class="text-5xl font-bold text-primary">Welcome!</h1>
                    <p class="py-6 text-base-content">This is where I share my thoughts on Roc, HTMX, and modern web development with DaisyUI theming.</p>
                    <button class="btn btn-primary" hx-get="/api/hello" hx-target="#message">Click me for HTMX magic!</button>
                </div>
            </div>
        </div>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                    <h2 class="card-title text-primary">🚀 Roc Language</h2>
                    <p class="text-base-content">Exploring the functional programming language Roc for web development.</p>
                    <div class="card-actions justify-end">
                        <button class="btn btn-primary">Learn More</button>
                    </div>
                </div>
            </div>
            
            <div class="card bg-base-100 shadow-xl">
                <div class="card-body">
                    <h2 class="card-title text-secondary">⚡ HTMX</h2>
                    <p class="text-base-content">Dynamic web interactions without complex JavaScript frameworks.</p>
                    <div class="card-actions justify-end">
                        <button class="btn btn-secondary">Explore</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="message" class="mt-8"></div>
    </main>
    
    <footer class="footer footer-center p-10 bg-base-200 text-base-content">
        <div>
            <p>Copyright © 2025 - All rights reserved by Roc Tech Blog</p>
        </div>
    </footer>

    <script>
        // Theme persistence with localStorage
        const themeController = document.querySelector('.theme-controller');
        
        // Load saved theme on page load
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme) {
            document.documentElement.setAttribute('data-theme', savedTheme);
            if (savedTheme === 'dark') {
                themeController.checked = true;
            }
        }
        
        // Save theme preference when changed
        themeController.addEventListener('change', function() {
            const theme = this.checked ? 'dark' : 'light';
            document.documentElement.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);
        });
    </script>
</body>
</html>
"""

blogAboutHtml =
"""
<!DOCTYPE html>
<html lang="en" data-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About - My Tech Blog</title>
    <link rel="stylesheet" href="/static/css/output.css">
    <script src="https://unpkg.com/htmx.org@1.9.10"></script>
</head>
<body class="min-h-screen bg-base-100">
    <div class="navbar bg-base-200 shadow-lg">
        <div class="navbar-start">
            <a href="/" class="btn btn-ghost text-xl">🚀 My Tech Blog</a>
        </div>
        <div class="navbar-center">
            <ul class="menu menu-horizontal px-1">
                <li><a href="/" class="text-primary">Home</a></li>
                <li><a href="/about" class="text-primary">About</a></li>
                <li><a href="/blog" class="text-primary">Blog</a></li>
            </ul>
        </div>
        <div class="navbar-end">
            <label class="swap swap-rotate">
                <input type="checkbox" class="theme-controller" value="dark" />
                <svg class="swap-on fill-current w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M5.64,17l-.71.71a1,1,0,0,0,0,1.41,1,1,0,0,0,1.41,0l.71-.71A1,1,0,0,0,5.64,17ZM5,12a1,1,0,0,0-1-1H3a1,1,0,0,0,0,2H4A1,1,0,0,0,5,12Zm7-7a1,1,0,0,0,1-1V3a1,1,0,0,0-2,0V4A1,1,0,0,0,12,5ZM5.64,7.05a1,1,0,0,0,.7.29,1,1,0,0,0,.71-.29,1,1,0,0,0,0-1.41l-.71-.71A1,1,0,0,0,4.93,6.34Zm12,.29a1,1,0,0,0,.7-.29l.71-.71a1,1,0,1,0-1.41-1.41L17,5.64a1,1,0,0,0,0,1.41A1,1,0,0,0,17.66,7.34ZM21,11H20a1,1,0,0,0,0,2h1a1,0,0,0,0-2Zm-9,8a1,1,0,0,0-1,1v1a1,1,0,0,0,2,0V20A1,1,0,0,0,12,19ZM18.36,17A1,1,0,0,0,17,18.36l.71.71a1,1,0,0,0,1.41,0,1,1,0,0,0,0-1.41ZM12,6.5A5.5,5.5,0,1,0,17.5,12,5.51,5.51,0,0,0,12,6.5Zm0,9A3.5,3.5,0,1,1,15.5,12,3.5,3.5,0,0,1,12,15.5Z"/>
                </svg>
                <svg class="swap-off fill-current w-6 h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                    <path d="M21.64,13a1,1,0,0,0-1.05-.14,8.05,8.05,0,0,1-3.37.73A8.15,8.15,0,0,1,9.08,5.49a8.59,8.59,0,0,1,.25-2A1,1,0,0,0,8,2.36,10.14,10.14,0,1,0,22,14.05,1,1,0,0,0,21.64,13Zm-9.5,6.69A8.14,8.14,0,0,1,7.08,5.22v.27A10.15,10.15,0,0,0,17.22,15.63a9.79,9.79,0,0,0,2.1-.22A8.11,8.11,0,0,1,12.14,19.73Z"/>
                </svg>
            </label>
        </div>
    </div>
    
    <main class="container mx-auto px-4 py-8">
        <div class="hero bg-base-200 rounded-lg p-8 mb-8">
            <div class="hero-content text-center">
                <div class="max-w-md">
                    <h1 class="text-5xl font-bold text-primary">About Me</h1>
                    <p class="py-6 text-base-content">I'm a developer exploring modern web technologies like Roc and HTMX. This blog is where I share my learnings and thoughts.</p>
                </div>
            </div>
        </div>
        
        <div class="card bg-base-100 shadow-xl">
            <div class="card-body">
                <h2 class="card-title text-primary">My Journey</h2>
                <p class="text-base-content">Exploring functional programming with Roc, modern web development with HTMX, and creating beautiful UIs with DaisyUI and Tailwind CSS.</p>
                <div class="stats shadow mt-4">
                    <div class="stat">
                        <div class="stat-title">Technologies</div>
                        <div class="stat-value text-primary">Roc + HTMX</div>
                        <div class="stat-desc">Functional Web Development</div>
                    </div>
                    <div class="stat">
                        <div class="stat-title">Styling</div>
                        <div class="stat-value text-secondary">DaisyUI</div>
                        <div class="stat-desc">Beautiful Components</div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <footer class="footer footer-center p-10 bg-base-200 text-base-content">
        <div>
            <p>Copyright © 2025 - All rights reserved by Roc Tech Blog</p>
        </div>
    </footer>

    <script>
        // Theme persistence with localStorage
        const themeController = document.querySelector('.theme-controller');
        
        // Load saved theme on page load
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme) {
            document.documentElement.setAttribute('data-theme', savedTheme);
            if (savedTheme === 'dark') {
                themeController.checked = true;
            }
        }
        
        // Save theme preference when changed
        themeController.addEventListener('change', function() {
            const theme = this.checked ? 'dark' : 'light';
            document.documentElement.setAttribute('data-theme', theme);
            localStorage.setItem('theme', theme);
        });
    </script>
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
    <div class="alert alert-success shadow-lg">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
        </svg>
        <div>
            <h3 class="font-bold">HTMX Magic Working! ✨</h3>
            <div class="text-xs">This content was loaded dynamically using HTMX without a page refresh. The power of modern web development with Roc and HTMX!</div>
        </div>
    </div>
""" 