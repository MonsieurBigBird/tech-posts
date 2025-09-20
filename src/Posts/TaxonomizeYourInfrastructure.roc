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
            <span>September 19, 2025</span>
            <span>•</span>
            <span>8 min read</span>
            <span>•</span>
            <span>by Matt Boisvert</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">infrastructure</span>
                <span class="badge badge-accent badge-sm">devops</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">Taxonomize Your Infrastructure</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            A systematic approach to thinking about infrastructure categorization for better design, maintainability, and longevity.
        </p>
    </div>

    <!-- Infrastructure Diagram -->
    <div class="my-8">
        <div class="bg-base-200 rounded-lg p-6 text-center">
            <div class="flex justify-center">
                <img 
                    src="/static/images/mock_diagram.png" 
                    alt="High-level infrastructure taxonomy diagram showing 'the CI', 'the build', and other infrastructure components"
                    class="max-w-full h-auto rounded-lg shadow-lg border border-base-300"
                    style="max-height: 700px;"
                />
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic">
                World's most detailed system diagram, rivaling <a href="https://www.youtube.com/watch?v=y8OnoxKotPQ&pp=ygUUa3JhemFtIG1pY3Jvc2VydmljZXM%3D" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Omega Star</a>
            </p>
        </div>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">
        <p>
            Having spent some time across quite distinct infrastructure codebases and developer environments, from isolated,
            simple platforms to large monolithic behemoths, I have seen a common pattern to solving new infrastructure problems. First, an engineer performs effective discovery
            to decide if someone else has solved the same problem that you are facing. Next, if the organization
            requires a domain-specific solution, they create an MVP that demonstrates the merits of the new system.
        </p>
        <br>
        <p>
            Ideally this would be delivered hand-in-hand with metrics that can show business alignment with said merits, but
            this is not always easy at first glance (quantifying developer productivity and happiness is a topic for another post :)). Finally,
            if the engineer is able to gain buy-in in this general direction, the team iterates!
        </p>
        <br>
        <p>
            It's a tale as old as time as teams ship to meet the needs of their developers and customers. However, there is a thematic
            problem that tends to crop up in this process -- technical debt. In a vacuum, it's easy to accumulate more and more complex tools and services to meet business objectives.
            After all, product roadmaps are ever-growing at a faster and faster pace. Those AI-generated shell scripts and one-off microservices made developers more productive at a given moment of time, but improving them was never in the product roadmap! To keep this complexity managed, I want
            to emphasize these words of the first step in the process: "effective discovery".
        </p>
        <br>
        <p>
            Far too often, engineers are not aware of the tools and systems that are outside of their domain. There
            is seldom time to research unique solutions, pour over technical blogs, and network with colleagues throughout
            the industry to understand how their challenges map to potential solutions. Aside from the time constraint,
            there are additional confounding incentives which limit the discovery process. These include promotion (as building
            something new is often perceived as more impressive than leveraging an existing solution; see the chat apps at <a href="https://killedbygoogle.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">killedbygoogle.com</a>),
            management pressure to ship ever-quicker, and the bias towards leaning on a technology that one already knows -- using
            the same hammer on any nail in the nearby vicinity.
        </p>
        <br>
        <p>
            In the semiconductor industry, this notion of accumulating custom infrastructure is
            further exacerbated by a lack of OSS software (which is <a href="https://github.com/aolofsson/awesome-opensource-hardware" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">getting better!</a> But is still extremely rampant; another topic for its own post) and a lack of internal
            experience to apply SWE development practices internally (which could be attributed to "hardware engineers
            using software in a brute force way?" Perhaps this is a bit of an unfair assessment).
        </p>
        <br>
        <p>
            However, I strongly believe that spending the time to learn, explore, and exercise the creative muscle can be the most powerful
            tool for an infrastructure organization -- problems once thought of as entirely unique and challenging
            are if not isomorphic, at least similar to problems that others have solved. If a problem seems
            completely unsolved, I'm inclined to believe that I just wasn't being creative enough.

            I'm very fortunate to have witnessed this story play out across organizations with a variety of sizes
            and degrees of existing infrastructure depth. From Google to Tenstorrent to NVIDIA, each company's history has played a major role in the way I've seen developer tools/infrastructure be designed and perceived.

            And so I want to focus on bringing attention to this growing field of study: what I will refer to as
            <strong>taxonomies of infrastructure</strong>.
        </p>

        <!-- Simple Taxonomy Diagram -->
        <div class="my-6">
            <div class="flex justify-center">
                <img 
                    src="/static/images/simple_taxonomy.png" 
                    alt="Simple taxonomy diagram showing infrastructure categorization"
                    class="max-w-full h-auto rounded-lg shadow-lg border border-base-300"
                    style="max-height: 400px;"
                />
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic text-center">
                Mock system taxonomy
            </p>
        </div>

        <br>
        <p>
            When I use the word "taxonomy", I just mean hierarchical categorization based on different properties that a system could provide, and the tradeoffs entailed by those properties. Think of it similar to fault tolerance models in distributed systems, where you can show the relationship between <a href="https://jepsen.io/consistency/models" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">different properties for replicated systems</a> based on <a href="https://en.wikipedia.org/wiki/CAP_theorem" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">CAP</a>.
        </p>

        <p>
            Beyond an individual system, I also think it's useful to see the macro-lense of the types of systems that can exist and the overall function that they serve within a larger organizational context.
        </p>
        <br>
        <p>
            A great example of this framing is the book <a href="https://www.oreilly.com/library/view/designing-data-intensive-applications/9781491903063/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors"><em>Designing Data-Intensive Applications</em></a>. It provides a pedagogical framework for comparing and contrasting components for data-intensive systems across a broad range of data ingestion and sharing use cases: ETL pipelines, traditional SQL databases, messaging technologies, etc. Along with each type of technology, it provides a group of relevant case studies and diagrams mapping out the connections between each type of technology. Any time I want to brainstorm ideas on how to orchestrate data flows between components, I reference it to get inspiration and share ideas with my teammates.
        </p>
        <br>
        <p>
            However, in terms of "infrastructure systems", I have yet* to find a general equivalent. There are, of course,
            fragments of this story across infrastructure blogs and software engineering methodology books that help
            weave this story together. Honorable mentions in this regard are:
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <ul class="space-y-3">
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://www.uber.com/blog/engineering/backend/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">
                            Uber backend engineering blog
                        </a>
                        <p class="text-sm text-base-content/70 mt-1">Comprehensive insights into large-scale infrastructure challenges</p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://signalsandthreads.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">
                            Signals and Threads Podcast by Jane Street
                        </a>
                        <p class="text-sm text-base-content/70 mt-1">Deep technical discussions on Jane Street's internal projects, many of which relate to solving distinct challenges to make traders more effective</p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://www.oreilly.com/library/view/software-engineering-at/9781492082781/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">
                            Software Engineering at Google: Lessons Learned from Programming Over Time
                        </a>
                        <p class="text-sm text-base-content/70 mt-1">Institutional knowledge and best practices from Google's engineering culture</p>
                    </div>
                </li>
            </ul>
        </div>

        <p>
            All of these resources provide significant depth and context behind infrastructure engineering challenges and approaches to software methodology. But in terms of having a concrete breakdown of the differences and hierarchies of different types of infrastructure systems, I'm not sure that the broader DevOps ecosystem has one.
        </p>
        <br>
        <p>
            One resource that does do this in the realm of infrastructure is the classic paper, <a href="https://www.cambridge.org/core/journals/journal-of-functional-programming/article/build-systems-a-la-carte-theory-and-practice/097CE52C750E69BD16B78C318539B6B4" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">Build Systems à La Carte</a>. Its organized approach to categorizing build systems and showing their trade offs makes it easier for build enthusiasts to speak the same language when referring to builds -- without such language, I've found that build systems discussions are often drastically simplified to "is it <a href="https://www.gnu.org/software/make/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">make-like</a>" or "is it <a href="https://bazel.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Bazel-like</a>". With the depth provided by this paper, we can examine both the holistic functionality that a build system provides and the nuances of its properties to make educated tooling decisions. I'll admit that having a Haskell representation of the design space might not be feasible for all such areas of infrastructure, but I greatly appreciate the formalism in their approach.
        </p>
        <br>
        <p>
            Going beyond build systems though, I think that there are many other areas of infrastructure from which we could construct useful groupings and breakdowns of distinct properties that could be optimized based on tradeoffs. These include:
        </p>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 my-6">
            <div class="bg-gradient-to-br from-primary/10 to-primary/5 rounded-lg p-4 border border-primary/20">
                <h4 class="font-semibold text-primary mb-3 flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                    </svg>
                    Development & Build
                </h4>
                <ul class="space-y-2 text-sm">
                    <li class="flex items-center"><span class="w-2 h-2 bg-primary rounded-full mr-3"></span>Developer environments</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-primary rounded-full mr-3"></span>Build systems</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-primary rounded-full mr-3"></span>Developer tools</li>
                </ul>
            </div>
            
            <div class="bg-gradient-to-br from-secondary/10 to-secondary/5 rounded-lg p-4 border border-secondary/20">
                <h4 class="font-semibold text-secondary mb-3 flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                    </svg>
                    CI/CD & Deployment
                </h4>
                <ul class="space-y-2 text-sm">
                    <li class="flex items-center"><span class="w-2 h-2 bg-secondary rounded-full mr-3"></span>CI systems</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-secondary rounded-full mr-3"></span>CD systems</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-secondary rounded-full mr-3"></span>Releases / deployments</li>
                </ul>
            </div>
            
            <div class="bg-gradient-to-br from-accent/10 to-accent/5 rounded-lg p-4 border border-accent/20">
                <h4 class="font-semibold text-accent mb-3 flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                    </svg>
                    Monitoring & Data
                </h4>
                <ul class="space-y-2 text-sm">
                    <li class="flex items-center"><span class="w-2 h-2 bg-accent rounded-full mr-3"></span>Telemetry systems</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-accent rounded-full mr-3"></span>Alerting systems</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-accent rounded-full mr-3"></span>Metrics collection / analysis</li>
                    <li class="flex items-center"><span class="w-2 h-2 bg-accent rounded-full mr-3"></span>Data streaming</li>
                </ul>
            </div>
            
            <div class="bg-gradient-to-br from-info/10 to-info/5 rounded-lg p-4 border border-info/20">
                <h4 class="font-semibold text-info mb-3 flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"/>
                    </svg>
                    Collaboration
                </h4>
                <ul class="space-y-2 text-sm">
                    <li class="flex items-center"><span class="w-2 h-2 bg-info rounded-full mr-3"></span>Version control</li>
                </ul>
            </div>
        </div>

        <p>
            On top of covering the nuances of each type of these components in isolation, I think it would be invaluable to see how they connect with each other to build larger
            developer flows across an organization, from the start of a project through the development process to each release -- a cycle which you could then examine more carefully to have
            an understanding of what the org needs to prioritize. When one component is lacking in capability, the classic temptation is to build features into one of the other
            components within the larger picture or to pin up a new service. I've seen it happen many times, accelerating the process of accruing technical debt. So by having a common framing and language to talk about this domain, it makes it much easier to make calculated
            decisions which span the test of time with:
        </p>

        <div class="bg-base-200 rounded-lg p-4 my-4">
            <ul class="space-y-2">
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <span>explicit awareness of the tradeoffs involved</span>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <span>intentional engagement with the pedagogy</span>
                </li>
            </ul>
        </div>

        <p>
            With these aspirations in mind, I'm quite aware of the practical limitations of this potentially verbose analysis -- whether it's time to market, size of the
            development team, or infrastructure expertise. But I think that for a sufficiently sized organization invested in building tools and platforms that serve them for the long run,
            exploring infrastructure taxonomization is critical. It will improve the quality of infrastructure being built to best serve the needs of the team
            and reduce technical debt, as there was research and planning that went into the careful organization of tools and services (rather than a scrappy collection of scripts and monolithic services).
        </p>

        <div class="bg-gradient-to-r from-primary/5 to-secondary/5 rounded-lg p-6 my-8 border-l-4 border-primary">
            <h3 class="text-xl font-bold text-primary mb-4 flex items-center">
                <svg class="w-6 h-6 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"/>
                </svg>
                Actionable Recommendations
            </h3>
            <p class="text-base-content/80 mb-6">Two practices that could provide relatively impact for low cost:</p>
            
            <div class="space-y-6">
                <div class="bg-base-100 rounded-lg p-5 border border-primary/20">
                    <div class="flex items-start">
                        <div class="flex-shrink-0 w-8 h-8 bg-primary text-primary-content rounded-full flex items-center justify-center font-bold text-sm mr-4">1</div>
                        <div>
                            <h4 class="font-semibold text-primary mb-2">Taxonomize your own internal infrastructure</h4>
                            <p class="text-base-content/80">
                                By mapping the high-level goals of each system onto a broad category of infrastructure (e.g. "the build tool", "the common developer scripts", "the CI/CD system")
                                it should become rapidly apparent whether there are these clear boundaries to begin with. The harder it is to draw these lines and isolate the modular behavior of each component, the more
                                difficult it will be to maintain and integrate with OSS tools/platforms.
                            </p>
                        </div>
                    </div>
                </div>
                
                <div class="bg-base-100 rounded-lg p-5 border border-secondary/20">
                    <div class="flex items-start">
                        <div class="flex-shrink-0 w-8 h-8 bg-secondary text-secondary-content rounded-full flex items-center justify-center font-bold text-sm mr-4">2</div>
                        <div>
                            <h4 class="font-semibold text-secondary mb-2">Prioritize creativity and learning</h4>
                            <p class="text-base-content/80">
                                Whenever you see a large gap between what your infrastructure provides today (slow builds, flakey CI, inaccurate alerts), developers seldom have time
                                to dig beyond a "quick fix" solution. Sometimes the hot patch is what will provide the most value. Sometimes, taking a fresh look at the broader horizon of how others have solved such challenges will
                                reveal a glaring bias in the design. Being eager to think about developer productivity/ops critically and patient in the design process will make it easier to build infrastructure that is enjoyable (not "what are all these random Jenkins jobs/bash scripts") 
                                and long-lasting. Even if you don't have problems with your tools and infrastructure today, bias towards going against the grain and brainstorming the issues of today's systems, thinking about the technical and business needs of the future, and learning outside of a narrow focus.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Caveat Section -->
        <div class="bg-gradient-to-r from-warning/10 to-info/10 rounded-lg p-6 my-8 border border-warning/20">
            <div class="flex items-start">
                <div class="flex-shrink-0 w-8 h-8 bg-warning text-warning-content rounded-full flex items-center justify-center font-bold text-sm mr-4">*</div>
                <div>
                    <h4 class="font-semibold text-warning mb-2">A Note on Completeness</h4>
                    <p class="text-base-content/80">
                        It's perfectly possible I'm missing existing comprehensive resources in this space. For example, I'm looking forward to reading 
                        <a href="https://www.amazon.com/Continuous-Delivery-Deployment-Automation-Addison-Wesley/dp/0321601912" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">"Continuous Delivery"</a> by Jez Humble and David Farley, which may provide the kind of systematic approach to deployment and release infrastructure that I'm advocating for here. If you know of other resources that provide this kind of infrastructure taxonomy, I'd love to hear about them!
                    </p>
                </div>
            </div>
        </div>
        
    </article>
</div>
"""

