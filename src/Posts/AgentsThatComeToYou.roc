module [
    blogPostPageHtml!,
]

import Posts.Post

blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "agents-that-come-to-you" -> Posts.Post.renderPostPage!("Agents That Come to You - Blog", "blog", agentsContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

agentsContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>November 26, 2026</span>
            <span>•</span>
            <span>5 min read</span>
            <span>•</span>
            <span>by Matt Boisvert</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">agents</span>
                <span class="badge badge-accent badge-sm">infrastructure</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">Agents That Come to You</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            Moving past a blurry, non-deterministic line of Level 2 LLM lane assist and Level 3 agent driving.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">

        <!-- Introductory Note -->
        <div class="bg-gradient-to-r from-info/10 to-primary/10 rounded-lg px-4 py-3 my-4 border-l-4 border-info">
            <div class="flex items-start">
                <div class="flex-shrink-0 mr-3 mt-0.5">
                    <svg class="w-4 h-4 text-info" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                </div>
                <div>
                    <h4 class="text-sm font-semibold text-info mb-0.5">Note</h4>
                    <p class="text-sm text-base-content/80">
                        This is an observational post that will likely be outdated in the next few months as technology continues to rapidly advance :).
                    </p>
                </div>
            </div>
        </div>

        <p>
            Over the last year, AI coding evolved into a fundamentally new way of developing. Everyone has a powerful flow for planning, executing, and perfecting every stage in between,
            built around harnesses like <a href="https://www.anthropic.com/claude-code" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Claude Code</a>, <a href="https://github.com/openai/codex" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Codex</a>, <a href="https://github.com/google-gemini/gemini-cli" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Gemini CLI</a> (or whatever iteration we are on now), and <a href="https://opencode.ai" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">OpenCode</a>, or (insert 50 thousand products here).
            Of course, people have been rolling their own harnesses from scratch or using tools like <a href="https://www.langchain.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">LangChain</a> and <a href="https://www.langchain.com/langgraph" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">LangGraph</a> for a while now.
            But I think the primary use case has been to home in on integrating with one particular workflow or one particular platform, providing human intelligence on top of a deterministic flow.
            And outside the AI labs, where agents apparently already run the world (granted, with proofs of <a href="https://www.math.uwaterloo.ca/~mrubinst/alpoge_claude_grh/zeta-paper.pdf" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">the Riemann Hypothesis</a> and of <a href="https://www.alphaxiv.org/pdf/2611.matrix-multiplication-exponent-lower-bound" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">an &Omega;(n<sup>9/4</sup>) lower bound for matrix multiplication</a>, maybe they do), most of us are still living in "human-driving-agent" flows.
        </p>
        <br>
        <p>
            The challenge we have all felt, even as we level up to focus on architecture and business needs, is upleveling productivity without paying for it in context-switching, technical debt, and <a href="https://www.youtube.com/watch?v=MhEL9cvLxQE" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">"LLM drudgery"</a>.
            Every tab takes time away from <a href="https://www.goodreads.com/en/book/show/25744928-deep-work" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">deep work</a> and from working closely with colleagues, when that is ultimately what we want to be doing!
            With everyone trying to do everything, it feels like the brain is spinning up a process for every tab and OOMkilling on each, and we end up busier than ever while telling ourselves we've "moved to a higher level of the stack."
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <div class="flex justify-center">
                <img src="/static/images/agent_windows.png" alt="A hand-drawn collage of many windows (code snippets, charts, and LLM output) surrounding a stick figure who says 'Must press enter!'" class="rounded-lg max-w-full h-auto" />
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic text-center">
                <a href="https://www.youtube.com/watch?v=WV6A1Zf3F2Q" target="_blank" class="underline">Average 10x engineer</a>
            </p>
        </div>
        <br>
        <p>
            The shift that I am interested in seeing is moving from agents as coding harnesses/AI-integrated platforms (humans driving many wheels) towards agent pseudoautonomy (don't we call them agents for a reason?).
        </p>


        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Toward Autonomous Flows</h2>

        <p>
            When I say autonomous I don't mean it takes actions without any human involvement at all. What I mean is more akin to running specific agent workflows on a cron job with the ability for the user to approve actions — sort of like having daemon harnesses with a specific "flavor" of what that agent needs to do.
        </p>
        <br>
        <p>
            This is the vision many of us have for these tools, especially for developer productivity as we integrate agents into our tooling and build truly agentic infrastructure.
            Ideal developer platforms not only facilitate the flows engineers are used to doing on a daily basis, but they also multiply the effectiveness of their time and expertise.
            So why not make them even more powerful and rich?
            I think this exists in some niche domains today, but it is far less common than the coding harnesses we all know well.
        </p>
        <br>
        <p>
            The closest thing I've seen to this is the individual harnesses teams have built to hyper-solve for a specific problem and integrate into a platform, such as <a href="https://www.glean.com/ai-agents" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Glean agents</a> that provide support for a particular platform. Nobody drives them, and with decent context and evals, they are surprisingly smart!
        </p>
        <br>
        <p>
            But the step I find more interesting is chaining. Noticing an issue independently and then, with high accuracy and speed, working out why and proposing a config update for a human to approve.
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <div class="flex justify-center">
                <img src="/static/images/agent_flow.png" alt="A hand-drawn sketch of a stick figure saying 'Wow, that is a nuanced point!' next to an LLM message about a race condition, a status panel listing a review bot, a customer support bot, and an observability bot, and a code snippet" class="rounded-lg max-w-full h-auto" />
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic text-center">
                Less context switching (note: code still existing is intentional)
            </p>
        </div>

        <p>
            Today's coding harnesses are a sort of "least common denominator" of task execution. But what if you had background agents triaging support requests, reviewing code, and monitoring your observability stack, taking end-to-end flows all the way to completion with occasional interrupts for guidance?
            What if you could have it constantly self-learn and do a better job of triaging incidents more intelligently over the days and months that you use it?
        </p>
        <br>
        <p>
            Individual startups promise these capabilities, selling agents that can do these things in order to sell their product or collect data on your usage. And I think some teams have made a lot of progress in this direction with well-designed harnesses and evals. In aggregate, though, I think
            most end-to-end agentic engineering flows are still initiated and controlled by humans, introducing a significant "everything doing everything" context-switch problem.
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Going in this Direction</h2>

        <p>
            As has been drilled into us in the last few years, agents work best in environments built for them: structured data (<a href="https://protobuf.dev/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">schemas in APIs</a>, <a href="https://modelcontextprotocol.io/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">MCPs</a>),
            fast ways to act (<a href="https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">skills</a>, CLIs), and instructions that enshrine actionable goals.
        </p>
        <br>
        <p>
            The foundation models will keep evolving, but structuring environments for agents makes those models perform more effectively
            (especially the low-cost, fast ones!) and makes the same environment easier for humans to reason about.
        </p>

        <aside class="border-l-4 border-accent bg-base-200 rounded-r-lg px-5 py-4 my-6">
            <p class="text-xs font-semibold uppercase tracking-wide text-accent mb-1">Side note</p>
            <p class="text-sm text-base-content/80">
                It's interesting how AI somehow became a Trojan horse for <a href="/blog/taxonomize-your-infrastructure" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">reducing technical debt</a> by making agents more powerful!
            </p>
        </aside>
        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Humans Instructing, Agents Driving</h2>

        <p>
            In the hands-on model, attention is the thing agents consume. You are multiplexing your brain against a sea of terminal windows.
            In an autonomous flow, attention becomes something we spend deliberately, on the few moments that actually need human expertise, design, creativity, and passion.
        </p>
        <br>
        <p>
            That changes what "instructing" means. Instead of prompting turn by turn, we write down the goals, constraints, and "flavor" once, and let the agent run against them.
            We get intelligent outcomes and have fewer LLM-isms to trudge through (verbose code, poorly understood intentions, and severely non-deterministic actions).
        </p>
        <br>
        <p>
            As tokens get cheaper and harnesses improve, I think we will move from "humans with hands on 5 wheels, instructing agents" to "agents driving 5 wheels, humans instructing."
            Doing our life's work probably doesn't mean simply controlling more steering wheels. By making fewer decisions that matter more, we can focus on deep work, collaboration, and empowering our end users with the same capabilities!
        </p>

    </article>
</div>
"""
