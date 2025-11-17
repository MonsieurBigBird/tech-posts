module [
    blogPostPageHtml!,
]

import Posts.Post

# TheElusiveInfrastructureMetrics.roc
# Infrastructure metrics blog post content

# Blog post page content
blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "the-elusive-infrastructure-metrics" -> Posts.Post.renderPostPage!("The Elusive Infrastructure Metrics - Blog", "blog", elusiveInfrastructureContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

# Blog post content
elusiveInfrastructureContentHtml =
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
                <span class="badge badge-accent badge-sm">devops</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">The Elusive Infrastructure Metrics</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            Exploring the diverse ways of quantifying infrastructure improvements and the complex relationship between management needs and developer experience.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">
        
        <!-- Introduction -->
        <!-- Introductory Note -->
        <div class="bg-gradient-to-r from-info/10 to-primary/10 rounded-lg p-6 my-6 border-l-4 border-info">
            <div class="flex items-start">
                <div class="flex-shrink-0 mr-4">
                    <svg class="w-6 h-6 text-info" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <div>
                    <h4 class="font-semibold text-info mb-2">Note</h4>
                    <p class="text-base-content/80">
                        The focus of this post is less about concrete ways to build metrics and more about how we think about prioritization
                        in infrastructure / the downstream impact this has on the metrics we collect and optimize around.
                    </p>
                </div>
            </div>
        </div>

        <p>
            Something I've been thinking about a lot this year is the strange relationship between infrastructure improvements and the metrics we develop around them.
            There are fundamental KPIs that everyone agrees need to be tracked such as service usage patterns or storage demands over time.
            But there are also metrics that seem harder to quantify, and so they get neglected (e.g. developer satisfaction scores).
        </p>
        <br>
        <p>
            Why is this? In some sense, "infrastructure" means different things to different stakeholders in an organization. To developers, underlying platforms are judged by their ergonomics
            and availability; they are desired to be relatively seamless and "invisible". To other stakeholders, these same systems might be evaluated by cost, efficiency, or time to market.
            All of these perspectives are important, but they are certainly not exhaustive.
        </p>
        <br>
        <p>
            In practice, I find that the elusive nature of infrastructure, combined with varying perspectives on what should be optimized, often can cause a
            <b>misdirection in priorities</b> for engineers. And I believe that the availability and prioritization of infrastructure metrics can help us better understand/mitigate this phenomenon.
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
                    The average search for infrastructure metrics
            </p>
        </div>
    </div>

        <!-- Example Scenario -->
        <p>
            To illustrate this tension, consider a hyperexaggerated scenario: 100 developers message an infrastructure engineer saying, 
            "I really wish we had feature X! If I had feature X, I would be so much more productive!" Excited by such consistent and clear feedback, the engineer begins investigating what it would take to support this feature.
        </p>
        <br>
        <p>
            After digging further, it becomes clear that the feature is possible, but architecturally complex enough to require someone working on it full-time for an entire quarter.
            Undeterred, the engineer makes the case to management. Surely they'll agree that feature X is a high priority! But it turns out that, unknown to the developers, the existing platform's licensing costs just spiked, costing the equivalent of 3 engineers.
        </p>
        <br>
        <p>
            Well then. There's clearly a tradeoff here. It is obvious that qualitative developer demands and management-facing business decisions matter in terms of empowering an organization to achieve its goals. But how can the sentiments of the users be preserved in a way that it is still measurable and communicable to other stakeholders? How does the impact of the service's
            usability actually manifest in practice? And does this lengthy analysis of this feature's decision-making scale to everything that could / should be improved?
        </p>
        <br>
        <p>
            In this example, it's not too difficult to reason through the answers. But as you start to unwind more realistic aspects, it becomes clear that:
        </p>

        <div class="bg-base-200 rounded-lg p-5 my-6 border-l-4 border-secondary">
            <ul class="space-y-3">
                <li class="flex items-start">
                    <span class="text-secondary mr-3 mt-1">•</span>
                    <span>There is a complex relationship between the fine-grained priorities of different stakeholders in an organization</span>
                </li>
                <li class="flex items-start">
                    <span class="text-secondary mr-3 mt-1">•</span>
                    <span>Infrastructure metrics become increasingly important for capturing the essence of what different stakeholders prioritize for the business</span>
                </li>
            </ul>
        </div>

        <!-- Key Points Section -->
        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Why does the developer experience matter? Why not always optimize for backend cost and efficiency?</h2>
        <p>
            It seems trivial to ask, but we need to be explicit: the experiences developers have with tools play a critical role in their productivity and effectiveness, regardless of how well those tools achieve "objective" business metrics on paper.
        </p>
        <br>
        <p>
            Consider <a href="https://astral.sh/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">astral.sh</a>'s <code>uv</code> as an example. It achieves similar high-level goals as Poetry and Pip, which are all fundamentally package managers. So why was <code>uv</code> suddenly embraced by the Python community
            after over a decade of existing tools? Because it lowered the barrier to entry for new Python developers (one central command as a gateway to projects), delivered great developer UX,
            and addressed critical pain points in the ecosystem (slow package management, unwieldy platform-specific packages). If we only looked at the written spec of what <code>uv</code> does on paper, it wouldn't seem necessary. But to the average Python developer today, it's a beloved tool.
        </p>
        <br>
        <p>
            So yes, there is some separation of concerns between developers and management when it comes to infrastructure priorities. But there's also a strong, often underappreciated relationship between the two.
            If your tools make engineers substantially happier, they'll be more effective—plain and simple.
            If management is satisfied by your tools' ability to serve organizational goals, the business will continue to scale and reward the infrastructure with more resources.
        </p>
        <p>
            Both fronts indirectly support each other. Neglecting one will slowly degrade an organization's productivity over time.
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Creating metrics around different types of organizational goals</h2>
        <p>
            On one end of the spectrum lie clear, management-facing business metrics (e.g. cost, engineering time, and time to market).
            On the other end rests a more ambiguous collection of metrics that are more qualitative in nature—the sense that tooling and infrastructure is robust, easy to use, and occasionally even enjoyable.
            The depth and nuance in this domain is especially pronounced when you're building developer platforms or SDKs. Suddenly the quality of your self-starter documentation, the cleanliness of tooling integrations,
            and thoughtful programmatic customization become increasingly important to prioritize. Generally, the more "objective" metrics that show direct/immediate business impact are the ones that serve more utility to
            prioritize. But there is some more thought that should go into the priorities (and surrounding metrics) of other stakeholders. These are some thoughts I have in this regard:
        </p>

        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">1.  Neglected developer needs eventually catch up to organizations</h3>
        <p>
            In most cases, minor developer UX issues aren't sufficient to make or break the ability to use a tool or platform—especially if that tool is mandatory for product developers. But over time, leaving these needs unaddressed can snowball into a crisis.
        </p>
        <p>
            Perhaps the aging system finally collapses under performance issues. Or perhaps it becomes so cumbersome that developers can no longer meet growing business objectives. These are rare occurrences, but not unheard of in the industry.
        </p>
        <p>
            The more pressing and realistic version of this problem is more subtle: neglected infrastructure gradually slows down an organization, making it harder to tackle difficult problems quickly. This is precisely why we need to understand and measure these issues before they become critical.
        </p>


        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">2. Developer needs are often invisible to management (and vice versa)</h3>
        
        <!-- Angry Devs Image -->
        <div class="my-6">
            <div class="bg-base-200 rounded-lg p-6 text-center">
                <div class="flex justify-center">
                    <img 
                        src="/static/images/angry_devs.png" 
                        alt="Developers expressing frustration with infrastructure tooling"
                        class="max-w-full h-auto rounded-lg shadow-lg border border-base-300"
                        style="max-height: 500px;"
                    />
                </div>
            </div>
        </div>

        <p>
            In the exaggerated hypothetical scenario provided earlier, management might be able to see 100 developers holding pitchforks demanding a feature. Unsurprisingly, this tends to be <b>slightly</b> different from reality. One example that comes to mind is having bespoke tooling.
        </p>
        <br>
        <p>
           In such a scenario, new hires will struggle to develop a deep understanding of the tooling nuances while experienced developers remain blissfully unaware—either due to their tenure or because they've learned workarounds around the UX issues. This is an insidious problem. You'll only ever see a small fraction of engineers deeply impacted by specific tooling issues, while everyone else is either unaware or has chosen to turn a blind eye to the inefficiencies.
        </p>
        <br>
        <p>
            By definition, such issues rarely surface to management unless a new hire is particularly vocal and influential. These problems might manifest most clearly through long onboarding times, but even then they may not appear in developer happiness surveys. I don't mean to suggest this is necessarily a crisis. Rather, I want to emphasize that structural differences in priorities can subversively allow developer issues to go unnoticed and unaddressed.
        </p>
        <br>
        <p>
        On the flip side, there are sometimes infrastructure needs that promote management objectives without an obvious selling point to users. My colleague Jagdish would describe these as "medicine". Maybe the user wants infinite allocations of compute and storage for their
        personal regressions. Maybe they want to ensure that their batch jobs are always scheduled immediately at the front of the queue. In any case, infrastructure engineers obviously can't satisfy the extremities of such requests, and instead are focused on delivering high value to the organization as a whole. The user may not perceive
        that this is the optimal decision, but it will end up benefitting them and speeding up the organization.

        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">3. Finding ways to connect different types of stakeholders can be extremely powerful</h3>
        <p>
            Oftentimes, the most rapid progress I see towards organizational goals happens when a project or plan connects stakeholders together. A little bit of thoughtfulness goes a long way in snowballing the impact of an investment.
            Instead of thinking "if I just had N more engineers / management signoff to make it happen," I've found it more productive to think, "how can we unite people around a common goal"? When people are passionate about an idea and see
            that it connects to their goals, they naturally bring it into fruition.

            Of course, not every project embodies an idea that seems intrinsically perfect for every stakeholder. But by thinking about these different priorities and how to build metrics around them, the friction to make something happen
            will decrease significantly.
        </p>


        <h3 class="text-xl font-semibold text-secondary mt-6 mb-3">4. Some infrastructure metrics are (substantially) easier to quantify than others</h3>
        <p>
            It's surprising how often I've seen even straightforward, critical metrics such as service health or response throughput be under-quantified in organizations.
        </p>
        <br>
        <p>
            Given this reality, it's hardly surprising that more qualitative metrics like developer happiness, onboarding friction, and support responsiveness are measured even less frequently. This makes sense when you consider the "hidden" nature of infrastructure work: if it's working well, it's invisible. If it's not, the symptoms are diffuse and hard to pin down.
        </p>
        <br>
        <p>
            For the most part, the quantitative metrics are far easier to collect because they can simply be automated. Even if it requires more thoughtfulness to curate a special mechanism that can track information in a distributed environment, it is still a direct, tractable engineering problem.
        </p>
        <br>
        <p>
            Qualitative metrics I find to be extremely rare, partially because they are difficult to collect, and partially because they can sometimes be hard to define. Some may not even agree on the importance of qualitative metrics. And certainly, the goal is not to invest time in an area that doesn't provide direct benefit.
            Instead it's just to give thought to finding ways to concretely track progress towards meaningful goals.
        </p>


        <!-- Solution Section -->
        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">So what goes under-measured?</h2>
        <p>
           These are a few areas where I've found myself wanting a way to show measurable comparisons to help add weight behind engineering proposals or initiatives.
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <ol class="space-y-3">
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">1.</span>
                    <div>
                        <span class="font-semibold">Maintenance cost</span>
                        <p class="text-sm text-base-content/70 mt-1">
                        Now more than ever it's easy to <a href="https://www.kuow.org/stories/the-human-coders-hired-to-mop-up-ai-slop" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">ship something quickly that will not scale or not be maintainable in the long term</a>. This is related to complexity but I think it also encompasses things like "TCO" (total cost of ownership) in terms of engineers adding features, fixing bugs, and responding to incidents.
                        </p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">2.</span>
                    <div>
                        <span class="font-semibold">User satisfaction</span>
                        <p class="text-sm text-base-content/70 mt-1">
                        Developer surveys and A/B testing to understand user preferences can go a long way in helping folks speed up their daily development; And, it helps to spread the awareness of issues to management.
                        </p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">3.</span>
                    <div>
                        <span class="font-semibold">System complexity</span>
                        <p class="text-sm text-base-content/70 mt-1">
                        Software complexity is something that has been studied for a <a href="https://learn.microsoft.com/en-us/visualstudio/code-quality/code-metrics-maintainability-index-range-and-meaning?view=visualstudio" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">long</a> time! I think today, the more we can reason about this on a more distributed level, the more we can sustain our services for the long term.
                        </p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary font-bold mr-3">5.</span>
                    <div>
                        <span class="font-semibold">"Proprietariness"</span>
                        <p class="text-sm text-base-content/70 mt-1">
                        The semiconductor industry certainly has no shortage of internal development practices. Quantifying the amount of internal SW in a given system
                        helps to understand the internal maintenance cost (especially if the benefits of similar OSS are missed!).
                        </p>
                    </div>
                </li>
            </ol>
        </div>
        
        <p>
            I hope to share this as a way of promoting mindfulness towards infrastructure metrics and thinking more critically about prioritization for different stakeholders. We may not always have time to implement these ideas, but thinking about them can help us be more cognizant of our blindspots and inform our decision-making.
        </p>
    </article>
</div>
"""

