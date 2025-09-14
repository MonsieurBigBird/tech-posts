module [
    renderPostPage!,
    notFoundPostContentHtml,
]

import Shared

# Post.roc
# Base post functionality and common utilities

# Generic post page renderer
renderPostPage! : Str, Str, Str => Str
renderPostPage! = |title, activeNav, content|
    Shared.baseLayoutHtml!(title, activeNav, content)

# Common 404 content for posts
notFoundPostContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <div class="hero bg-base-200 rounded-lg p-8 mb-8">
        <div class="hero-content text-center">
            <div class="max-w-md">
                <h1 class="text-5xl font-bold text-error">404</h1>
                <p class="py-6 text-base-content">Post not found</p>
                <a href="/blog" class="btn btn-primary">Back to Blog</a>
            </div>
        </div>
    </div>
</div>
"""
