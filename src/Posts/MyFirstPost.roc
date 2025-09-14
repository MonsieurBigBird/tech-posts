module [
    blogPostPageHtml!,
]

import Posts.Post

# MyFirstPost.roc
# First blog post content

# Blog post page content
blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "my-first-post" -> Posts.Post.renderPostPage!("My First Post - Blog", "blog", myFirstPostContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

# Blog post content
myFirstPostContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>July 10, 2025</span>
            <span>•</span>
            <span>5 min read</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">roc</span>
                <span class="badge badge-secondary badge-sm">diagrams</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">Building Interactive Blog Posts with Roc</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            Exploring how to create engaging, interactive content in a server-side rendered blog using Roc, HTMX, and modern web techniques.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">
        <h2>Why This Approach?</h2>
        <p>
            When building a blog with Roc, you have several options for content management. 
            The key is finding the right balance between <strong>content authoring ease</strong> and 
            <strong>interactive capabilities</strong>.
        </p>

        <h3>Option 1: Pure Markdown</h3>
        <p>
            Great for content-heavy posts, but limited for interactive elements. 
            You'd need to process markdown and inject HTML components.
        </p>

        <h3>Option 2: Structured HTML Functions</h3>
        <p>
            Maximum control and type safety, but requires writing HTML in Roc strings. 
            Perfect for posts that need custom layouts or interactions.
        </p>

        <h3>Option 3: Hybrid Approach (Recommended)</h3>
        <p>
            Use markdown for content, but create HTML components for interactive sections. 
            This gives you the best of both worlds.
        </p>

        <!-- Interactive Demo Section -->
        <div class="my-8 p-6 bg-base-200 rounded-lg">
            <h3>Interactive Demo: HTMX in Action</h3>
            <p class="mb-4">Here's a live example of HTMX working in your blog post:</p>
            
            <div class="space-y-4">
                <button 
                    class="btn btn-primary"
                    hx-get="/api/hello"
                    hx-target="#demo-content"
                    hx-swap="innerHTML">
                    Click me for HTMX magic! ✨
                </button>
                
                <div id="demo-content" class="p-4 bg-base-100 rounded border-2 border-dashed border-base-300">
                    <p class="text-base-content/60">Click the button above to see HTMX in action!</p>
                </div>
            </div>
        </div>

        <!-- Code Example -->
        <h3>Implementation Example</h3>
        <p>Here's how you can structure a blog post in Roc:</p>
        
        <div class="mockup-code">
            <pre><code># Blog post content
myFirstPostContentHtml =
"<div class=\"max-w-4xl mx-auto\">
    <h1>My Post Title</h1>
    <p>Content goes here...</p>
    
    <!-- Interactive section -->
    <div hx-get=\"/api/demo\" hx-trigger=\"click\">
        Click me!
    </div>
</div>"</code></pre>
        </div>

        <!-- Mermaid Diagram -->
        <h3>Architecture Flow</h3>
        <p>Here's how the blog post system works:</p>
        
        <div class="mermaid">
            graph TD
                A[Markdown File] --> B[Roc Function]
                B --> C[HTML Generation]
                C --> D[HTMX Enhancement]
                D --> E[Interactive Blog Post]
                
                F[Content] --> G[Structure]
                G --> H[Styling]
                H --> I[Interactions]
        </div>

        <!-- Call to Action -->
        <div class="my-8 p-6 bg-primary/10 rounded-lg border border-primary/20">
            <h3>What's Next?</h3>
            <p class="mb-4">
                This approach gives you the flexibility to create rich, interactive blog posts 
                while maintaining the simplicity of markdown for content creation.
            </p>
            <div class="flex space-x-4">
                <a href="/blog" class="btn btn-primary">← Back to Blog</a>
                <a href="/about" class="btn btn-outline">Learn More About Me</a>
            </div>
        </div>
    </article>
</div>
"""

