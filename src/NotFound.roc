module [
    notFoundPageHtml!,
    notFoundPageContentHtml,
    notFoundPostContentHtml,
]

import Shared

notFoundPageHtml! : {} => Str
notFoundPageHtml! = |_| Shared.baseLayoutHtml!("404 - Not Found", "home", notFoundPageContentHtml)
notFoundPageContentHtml =
"""
<div class="hero bg-base-200 rounded-lg p-8">
    <div class="hero-content text-center">
        <div class="max-w-md">
            <h1 class="text-5xl font-bold text-error">404</h1>
            <p class="py-6 text-base-content">The page you're looking for doesn't exist.</p>
            <a href="/" class="btn btn-primary">Go back home</a>
        </div>
    </div>
</div>
"""
notFoundPostContentHtml =
"""
<div class="max-w-4xl mx-auto text-center py-16">
    <h1 class="text-4xl font-bold text-primary mb-4">Post Not Found</h1>
    <p class="text-xl text-base-content/80 mb-8">The blog post you're looking for doesn't exist.</p>
    <a href="/blog" class="btn btn-primary">← Back to Blog</a>
</div>
"""
