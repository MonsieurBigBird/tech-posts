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
        "the-mythical-infrastructure-metrics" -> Posts.Post.renderPostPage!("The Mythical Infrastructure Metrics - Blog", "blog", taxonomizeInfrastructureContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

# Blog post content
taxonomizeInfrastructureContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>November 16, 2025</span>
            <span>•</span>
            <span>10 min read</span>
            <span>•</span>
            <span>by Matt Boisvert</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">infrastructure</span>
                <span class="badge badge-accent badge-sm">metrics</span>
                <span class="badge badge-secondary badge-sm">devops</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">The Mythical Infrastructure Metrics</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            Exploring the diverse ways of quantifying infrastructure improvements and the complex relationship between management needs and developer experience.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">
        
        <!-- Introduction -->
        <p>
            Something that I've thinking about a lot this year is the strange relationship between infrastructure/tooling improvements and the metrics developed around them.
            There are always fundamental KPIs that need to be tracked and why they matter which everyone agree with -- things like usage of a service or storage demands over time.
            But oftentimes there are also KPIs which *seem* and are harder to track, so they get negletcted -- think developer satisfaction scores or "technical debt".

            Why is this? In some sense, "infrastructure" means different things to different stakeholders in an organization. To developers, underlying platforms are perceived by their ergonomics
            and availability, so the goal is that they are relatively seamless and invisible. To other stakeholders, they might be judged by other markers such as cost or efficiency.
            All of these perspectives are important to keep in mind, but they are certainly not exhaustive.            

            In practice, I find that the "hidden" nature of infrastructure and the varying perspectives of what should be optimized for can often create a significant amount of
            misdirection in priorities. And I think the metrics we focus on serve as our best canary in the coal mine for this phenomenom. 
        </p>

        <!-- Metrics Diagram -->
        <div class="my-8">
            <div class="bg-base-200 rounded-lg p-6 text-center">
                <div class="flex justify-center">
                    <img 
                        src="/static/images/metrics_diagram.png" 
                        alt="Infrastructure metrics diagram showing different stakeholder perspectives"
                        class="max-w-full h-auto rounded-lg shadow-lg border border-base-300"
                        style="max-height: 600px;"
                    />
                </div>
                <p class="text-sm text-base-content/60 mt-4 italic">
                    The spectrum of infrastructure metrics
                </p>
            </div>
        </div>

        <!-- Example Scenario -->
        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">A Hyperexaggerated Example</h2>
        <p>
            To illustrate this point, here is a hyperexaggerated example. Let's say that 100 users message an infrastructure engineer saying 
            "I really wish we had feature X! If I had feature X, I would be so much more productive!" Eager to have such consistent and clear feedback, the engineer begins investigating what it would take to support that feature.
            All of a sudden, it becomes clear that it's possible to implement the feature, but architecturally it is sufficiently complex that it would require someone to work on it full time for a quarter.
            Undeterred, they press on. Surely, management would agree that feature X is a high priority focus! It turns out, unknown to the users, that the existing platforms have licensing costs that now cost 3 engineers worth of headcount for the next quarter.
        </p>
        <p>
            Well, great. Clearly there is a tradeoff which makes a strong case for focusing on the backend change, even if it doesn't have a direct impact on improving the developer experience, because of the clear business impact.
            The thing is, while this example makes a bold distinction between the qualitative demands of users and management-facing business decisions, the relationship between the two is generally much more complex.
        </p>

        <!-- Key Points Section -->
        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">The Complex Relationship</h2>

        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">1. Management needs are not completely distinct from developer needs and vice versa</h3>
        <p>
            On one end of the spectrum there lies clear, management-facing business metrics such as cost, engineering time, and time to market.
            On the other end there rests an ambiguous blob of "positive vibes" that the tooling and infrastructure is robust, easy to use, and gives users small moments of joy when they use it.
            This goes beyond the cliche of hyper-custom emacs-plugin ergonomics and pristine websites. It encompasses a breadth of experiences from well-written documentation to clean tool integrations to programmatic customization.
            The depth and nuance of this goes on and on, especially if you are building things in the realm of developer platforms or SDKs.
        </p>
        <p>
            Why do these experiences matter? It seems trivial to ask, but we must make it explicit. The experiences that users have with tools and infrastructure play a critical role in their productivity and effectiveness, regardless of how well they achieve the "objective" business justification.
            Let's take the OSS tools built by <a href="https://astral.sh/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">astral.sh</a> for example. <code>uv</code> achieves similar "overall" goals of Poetry and Pip in terms of being package managers. So why was it suddenly embraced by the Python community
            after over a decade of existing tools trying to solve similar problems? It's because uv lowers the barrier for entry to new Python developers (giving them one central command as a gateway to their Python projects), has a great developer UX,
            and addressed very big holes left in the ecosystem (slow package management, unwieldy management of platform-specific packages). If we were only accounting for the written spec of what uv is supposed to do on paper, it wouldn't be necessary. And yet to the average Python developer today, it is a beloved tool in their toolbox.
        </p>
        <p>
            Hence, in some sense I do think it's true that there is some separation of concerns between users and management when it comes to infrastructure and tools. That being said, there is still a strong relationship between the two.
            If your tools make engineers substantially happier, they will be more effective at their life's best work, plain and simple.
            If your management is satisfied by your tools' ability to serve organizational goals, then the business as a whole will continue to scale and reward the infrastructure with more demand.
        </p>
        <p>
            Both fronts indirectly support each other, and the failure to address one will slowly degrade an organization's productivity in the long run.
        </p>

        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">2. Developer needs will catch up to an organization if left neglected</h3>
        <p>
            In most cases, minor developer UX issues are not sufficient to make or break the overall ability to use a given tool or platform (especially if use of said tool is mandatory for a given task or role). However, over time leaving these needs unaddressed can snowball until a crisis emerges.
            Maybe the old system finally tips over due to performance issues, or it is so hard to use over time that developers are not able to meet growing business objectives. This would be a rare ocurrence but it is certainly not unheard of in the industry. I think that the more pressing/realistic
            version of this problem is that it slows down an organization such that it's more difficult to tackle difficult problems quickly. That is why we ultimately want to understand and pay attention to the nature of these problems, finding ways to track them via metrics.


        </p>

        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">3. Developer needs are often obfuscated from management and vice versa</h3>
        <p>
            The example I gave at the beginning of a group of passionate users brigading for a straightforward feature is fairly unrealistic for a number of reasons.
            One example of a more realistic scenario is when new hires are confused with the bizarre nuances of tooling at company X while experienced developers are unaware either due to their tenure or have themselves learned to work around the inefficiencies.
            This is a fairly insidious problem because you will only ever see a small fraction of engineers who are deeply impacted by specific tooling issues while everyone else is potentially unaware or have chosen to turn a blind eye.
            By definition, such issues will rarely surface to management unless a new hire is particularly vocal and influential in the organization.
            It is likely that it will manifest most clearly through long onboarding times, but even then you may not see the issue appear in developer happiness surveys.
        </p>
        <p>
            Now, I don't mean to say that this particular example constitutes a large crisis. Instead, what I want to emphasize is that there are often structural differences in priorities that can subversively promote developer issues that go overlooked.
        </p>

        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">4. Some infrastructure metrics are much easier to quantify than others</h3>
        <p>
            It is surprising the number of times I've seen critical metrics such as build times, cache hit rates, and service health go untracked.
        </p>
        <p>
            Knowing this, it's far more unsurprising that more qualitative metrics such as developer happiness, onboarding time, and support availability are far less likely to be measured. These realities make sense given the "hidden" nature of infrastructure and tooling.
        </p>

        <!-- Solution Section -->
        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">What Do We Do?</h2>
        <p>
            Here are the broad categories of "value add" that I think are important to quantify:
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <ol class="space-y-3">
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">1.</span>
                    <div>
                        <span class="font-semibold">Upfront development cost</span>
                        <p class="text-sm text-base-content/70 mt-1"><!-- TODO: Add description --></p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">2.</span>
                    <div>
                        <span class="font-semibold">Maintenance cost</span>
                        <p class="text-sm text-base-content/70 mt-1"><!-- TODO: Add description --></p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">3.</span>
                    <div>
                        <span class="font-semibold">User satisfaction</span>
                        <p class="text-sm text-base-content/70 mt-1"><!-- TODO: Add description --></p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">4.</span>
                    <div>
                        <span class="font-semibold">System complexity</span>
                        <p class="text-sm text-base-content/70 mt-1"><!-- TODO: Add description --></p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">5.</span>
                    <div>
                        <span class="font-semibold">"Proprietariness"</span>
                        <p class="text-sm text-base-content/70 mt-1"><!-- TODO: Add description --></p>
                    </div>
                </li>
            </ol>
        </div>

        <p>
            None of these things are easy to measure, but they are important!
        </p>

        

        <!-- TODO: Add conclusion and any additional sections -->
        
    </article>
</div>
"""

