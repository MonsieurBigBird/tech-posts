# main.roc
# Direct Roc HTTP server application - no framework abstraction
# 
# File Organization:
# 1. Imports and Platform
# 2. Model and Core Functions
# 3. Routing
# 4. Imported Modules

app [Model, init!, respond!] {
    pf: platform "https://github.com/roc-lang/basic-webserver/releases/download/0.12.0/Q4h_In-sz1BqAvlpmCsBHhEJnn_YvfRRMiNACB_fBbk.tar.br"
}

import pf.Stdout
import pf.Http exposing [Request, Response]
import pf.Utc

# Import modular components
import Home
import About
import Blog
import Posts.TaxonomizeYourInfrastructure
import Posts.TheElusiveInfrastructureMetrics
import Api
import NotFound
import Files

# =============================================================================
# 2. MODEL AND CORE FUNCTIONS
# =============================================================================

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
                    headers: [
                        {name: "Content-Type", value: "text/html; charset=utf-8"},
                        {name: "Cache-Control", value: "public, max-age=3600, s-maxage=86400"},
                        {name: "ETag", value: "\"home-v3\""}
                    ],
                    body: Str.to_utf8(Home.homePageHtml!({})),
                },
            )
        "/about" ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: "text/html; charset=utf-8"},
                        {name: "Cache-Control", value: "public, max-age=3600, s-maxage=86400"},
                        {name: "ETag", value: "\"about-v1\""}
                    ],
                    body: Str.to_utf8(About.aboutPageHtml!({})),
                },
            )
        "/blog" ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: "text/html; charset=utf-8"},
                        {name: "Cache-Control", value: "public, max-age=1800, s-maxage=3600"},
                        {name: "ETag", value: "\"blog-v4\""}
                    ],
                    body: Str.to_utf8(Blog.blogPageHtml!({})),
                },
            )
        "/blog/taxonomize-your-infrastructure" ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: "text/html; charset=utf-8"},
                        {name: "Cache-Control", value: "public, max-age=7200, s-maxage=86400"},
                        {name: "ETag", value: "\"post-taxonomize-v1\""}
                    ],
                    body: Str.to_utf8(Posts.TaxonomizeYourInfrastructure.blogPostPageHtml!("taxonomize-your-infrastructure")),
                },
            )
        "/blog/the-elusive-infrastructure-metrics" ->
            Ok(
                {
                    status: 200,
                    headers: [
                        {name: "Content-Type", value: "text/html; charset=utf-8"},
                        {name: "Cache-Control", value: "public, max-age=7200, s-maxage=86400"},
                        {name: "ETag", value: "\"post-metrics-v1\""}
                    ],
                    body: Str.to_utf8(Posts.TheElusiveInfrastructureMetrics.blogPostPageHtml!("the-elusive-infrastructure-metrics")),
                },
            )
        "/static/css/output.css" -> Files.serveCssFile!({})
        "/static/css/icons.css" -> Files.serveIconsCssFile!({})
        "/static/images/beach.jpg" -> Files.serveImageFile!("static/images/beach.jpg", "image/jpeg")
        "/static/images/developers.gif" -> Files.serveImageFile!("static/images/developers.gif", "image/gif")
        "/static/icons/bazel.png" -> Files.serveImageFile!("static/icons/bazel.png", "image/png")
        "/static/icons/opentelemetry.png" -> Files.serveImageFile!("static/icons/opentelemetry.png", "image/png")
        "/static/icons/grafana.png" -> Files.serveImageFile!("static/icons/grafana.png", "image/png")
        "/static/icons/elasticsearch.jpg" -> Files.serveImageFile!("static/icons/elasticsearch.jpg", "image/jpeg")
        "/static/icons/perforce.jpg" -> Files.serveImageFile!("static/icons/perforce.jpg", "image/jpeg")
        "/static/icons/jenkins.png" -> Files.serveImageFile!("static/icons/jenkins.png", "image/png")
        "/static/icons/gitlab.png" -> Files.serveImageFile!("static/icons/gitlab.png", "image/png")
        "/static/icons/git.png" -> Files.serveImageFile!("static/icons/git.png", "image/png")
        "/static/images/mock_diagram.png" -> Files.serveImageFile!("static/images/mock_diagram.png", "image/png")
        "/static/images/simple_taxonomy.png" -> Files.serveImageFile!("static/images/simple_taxonomy.png", "image/png")
        "/static/images/metrics_diagram.png" -> Files.serveImageFile!("static/images/metrics_diagram.png", "image/png")
        "/static/images/angry_devs.png" -> Files.serveImageFile!("static/images/angry_devs.png", "image/png")
        "/api/hello" ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/html"}],
                    body: Str.to_utf8(Api.htmxResponseHtml),
                },
            )
        "/api/infrastructure-demo" ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/html"}],
                    body: Str.to_utf8(Api.infrastructureDemoHtml),
                },
            )
        "/api/beach-image" -> Files.serveImageFile!("static/images/beach.jpg", "image/jpeg")
        "/api/k8s-demo" ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/html"}],
                    body: Str.to_utf8(Api.k8sDemoHtml),
                },
            )
        "/api/pipeline-demo" ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/html"}],
                    body: Str.to_utf8(Api.pipelineDemoHtml),
                },
            )
        "/api/node-status" ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: "text/html"}],
                    body: Str.to_utf8(Api.nodeStatusHtml),
                },
            )
        _ ->
            Ok(
                {
                    status: 404,
                    headers: [],
                    body: Str.to_utf8(NotFound.notFoundPageHtml!({})),
                },
            )

# All page content and helper functions have been moved to their respective modules:
# - Home.roc: Home page content
# - About.roc: About page content and image serving
# - Blog.roc: Blog listing page
# - TaxonomizeYourInfrastructure.roc: Individual blog post content
# - Shared.roc: Base layout, navbar, footer, and shared utilities
# - Api.roc: HTMX responses and API endpoints
# - NotFound.roc: 404 page content
# - Files.roc: Static file serving functions