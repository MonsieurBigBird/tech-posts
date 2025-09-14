module [
    blogPostPageHtml!,
]

import Posts.Post

# TaxonomizeYourInfrastructure.roc
# Infrastructure taxonomy blog post content

# Blog post page content
blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "taxonomize-your-infrastructure" -> Posts.Post.renderPostPage!("Taxonomize Your Infrastructure - Blog", "blog", taxonomizeInfrastructureContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

# Blog post content
taxonomizeInfrastructureContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>January 15, 2025</span>
            <span>•</span>
            <span>8 min read</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">infrastructure</span>
                <span class="badge badge-secondary badge-sm">organization</span>
                <span class="badge badge-accent badge-sm">devops</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">Taxonomize Your Infrastructure</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            A systematic approach to organizing and categorizing your infrastructure components for better management, documentation, and team understanding.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">
        <p>
            Having spent a lot of time in a variety of infrastructure codebases, from isolated tried-and-true
            projects to large monolithic behemoths, I have seen a common pattern to solving new problems. First, perform effective discovery
            to decide if someone else has solved the same problem that you are facing. Next, if your organization
            requires a domain-specific solution, create an MVP that demonstrates the merits of the new system.
        </p>

        <p>
            Ideally this would be delivered hand-in-hand with metrics that can show business alignment with said merits, but
            this is not always easy at first glance (quantifying developer productivity and happiness is a topic for another post :)). Finally,
            if you are able to gain buy-in in this general direction, iterate!
        </p>

        <p>
            It's a tale as old as time as teams ship to meet the needs of their developers and customers. However, there is a thematic
            problem that tends to crop up in this process -- technical debt. In a vacuum, it's easy to accumulate more and more complex tools and services to meet business objectives.
            After all, product roadmaps are ever-growing at a faster and faster pace. But, to keep this complexity managed, I want
            to emphasize these words of the first step in the process: "effective discovery".
        </p>

        <p>
            Far too often, engineers are not aware of the tools and systems that are outside of their domain. There
            is seldom time to research unique solutions, pour over technical blogs, and network with colleagues throughout
            the industry to understand how their challenges map to potential solutions. Aside from the time constraint,
            there are additional confounding incentives which limit the discovery process. These include promotion (as building
            something new is often perceived as more impressive than leveraging an existing solution; see Google chat apps),
            management pressure to ship ever-quicker, and the bias towards leaning on a technology that one already knows -- using
            the same hammer on any nail in the nearby vicinity.
        </p>

        <p>
            In the hardware development industry, this notion of accumulating custom infrastructure is
            further exacerbated by a lack of OSS software (which is getting better!) and a lack of internal
            experience to apply external development practices internally (which could be attributed to "hardware engineers
            using software in a brute force way?" Perhaps this is a bit of an unfair assessment).
        </p>

        <p>
            However, I strongly believe that spending the time to learn, explore, and exercise the creative muscle can be the most powerful
            tool for an infrastructure organization -- problems once thought of as entirely unique and challenging
            are if not isomorphic, at least similar to problems that others have solved. If a problem seems
            completely unsolved, I'm inclined to believe that I just wasn't being creative enough.
        </p>

        <p>
            I'm very fortunate to have witnessed this story play out across organizations with a variety of sizes
            and degrees of existing infrastructure depth. It has shaped my experiences and the way that I approach new problems.
        </p>

        <p>
            And so I want to focus on bringing attention to this growing field of study: what I will refer to as
            <strong>taxonomies of infrastructure</strong>.
        </p>

        <h2>The Data-Intensive Systems Model</h2>
        <p>
            <em>Designing Data-Intensive Applications</em> is my go-to reference for an encyclopedia of system design knowledge
            for different data ingestion, retrieval, and sharing requirements. It provides a pedagogical framework
            for comparing and contrasting components for data-intensive systems across a broad range of use cases:
            ETL pipelines, traditional SQL databases, messaging technologies, etc. Along with each type of technology,
            it provides a group of relevant case studies and diagrams mapping out the connections between each type of technology.
        </p>

        <p>
            Any time I want to brainstorm ideas on how to orchestrate data flows between components, I reference it to
            get inspiration and share ideas with my teammates.
        </p>

        <p>
            However, in terms of "infrastructure systems", I have yet* to find a general equivalent. There are, of course,
            fragments of this story across infrastructure blogs and software engineering methodology books that help
            weave this story together.
        </p>

        <!-- Interactive Demo Section -->
        <div class="my-8 p-6 bg-base-200 rounded-lg">
            <h3>Interactive Demo: Infrastructure Explorer</h3>
            <p class="mb-4">Explore how a well-organized infrastructure taxonomy works:</p>
            
            <div class="space-y-4">
                <button 
                    class="btn btn-primary"
                    hx-get="/api/infrastructure-demo"
                    hx-target="#demo-content"
                    hx-swap="innerHTML">
                    Explore Infrastructure Components 🏗️
                </button>
                
                <div id="demo-content" class="p-4 bg-base-100 rounded border-2 border-dashed border-base-300">
                    <p class="text-base-content/60">Click the button above to see how infrastructure components are organized!</p>
                </div>
            </div>
        </div>

        <!-- Code Example -->
        <h3>Taxonomy Implementation Example</h3>
        <p>Here's how you can structure your infrastructure taxonomy:</p>
        
        <div class="mockup-code">
            <pre><code># Infrastructure Taxonomy Structure
# Environment: prod, staging, dev
# Service: web, api, db, cache
# Component: server, load-balancer, database
# Region: us-east-1, us-west-2, eu-west-1

# Example naming convention:
# {environment}-{service}-{component}-{region}-{instance}
# prod-web-server-us-east-1-01
# staging-api-db-us-west-2-01
# dev-cache-redis-eu-west-1-01

# Tagging strategy:
# Environment: production, staging, development
# Service: web-frontend, api-backend, database
# Owner: team-name
# Cost-Center: department-code</code></pre>
        </div>

        <!-- Mermaid Diagram -->
        <h3>Infrastructure Taxonomy Flow</h3>
        <p>Here's how a well-organized infrastructure taxonomy works:</p>
        
        <div class="mermaid">
            graph TD
                A[Infrastructure Components] --> B[Taxonomy Classification]
                B --> C[Consistent Naming]
                C --> D[Automated Management]
                D --> E[Cost Optimization]
                
                F[Environment] --> G[Service Type]
                G --> H[Component Role]
                H --> I[Geographic Region]
                I --> J[Instance Number]
        </div>

        <!-- Call to Action -->
        <div class="my-8 p-6 bg-primary/10 rounded-lg border border-primary/20">
            <h3>Ready to Get Started?</h3>
            <p class="mb-4">
                Start by auditing your current infrastructure and identifying patterns. 
                Create a simple taxonomy that works for your team and gradually expand it 
                as your infrastructure grows.
            </p>
            <div class="flex space-x-4">
                <a href="/blog" class="btn btn-primary">← Back to Blog</a>
                <a href="/about" class="btn btn-outline">Learn More About Me</a>
            </div>
        </div>
    </article>
</div>
"""

