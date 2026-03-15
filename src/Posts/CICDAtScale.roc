module [
    blogPostPageHtml!,
]

import Posts.Post

# CICDAtScale.roc
# CI/CD at scale blog post content

# Blog post page content
blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "ci-cd-at-scale" -> Posts.Post.renderPostPage!("When Simple Pipelines Break Down: CI/CD at Scale - Blog", "blog", cicdAtScaleContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

# Blog post content
cicdAtScaleContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>March 12, 2026</span>
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
        <h1 class="text-4xl font-bold text-primary mb-4">When Simple Pipelines Break Down: CI/CD at Scale</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            Exploring some of the unique challenges that arise when scaling CI/CD pipelines — keeping mainline green, managing resources, and maintaining developer flow at high velocity.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">

        <p>
            For many teams, CI/CD is the core loop of both human and agentic development; you make incremental changes, push them to your CI layer, and continuously repeat until your change passes tests and receives a thumbs up from your reviewer.
            Once you merge your changes into the mainline and things look good, automated processes kick off a release pipeline and your changes are serialized in some fashion that gets treated as a "promotion" (whether your release looks like a Golang package, a microservice, or a build execution).
        </p>
        <br>
        <p>
            Whether you have slight tweaks on this or not, it tends to function well and your team is able to rapidly deliver, pushing new changes to the codebase that undergo efficient automation, testing, and promotion. In my experiences building internal platforms and infrastructure, for most organizations the typical CI/CD setup you'd find in a simple <code>.gitlab-ci.yml</code> or <code>Jenkinsfile</code> works for small, isolated teams, but does not work as you scale various parameters. These include:
        </p>

        <div class="bg-base-200 rounded-lg p-5 my-6">
            <ul class="space-y-2">
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Overall change velocity</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Test pass rate</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Build/test cache hit rate</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Pipeline duration</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Pipeline resource usage (storage, compute, licenses)</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Change "interconnectedness" (i.e. probability that two separate changes would cause a mainline break when combined)</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Number of engineers</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Codebase size</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>"Frontloadedness of testing" (In the case of the <a href="https://cacm.acm.org/magazines/2016/7/204032-why-google-stores-billions-of-lines-of-code-in-a-single-repository/fulltext" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Google3 monorepo</a>, testing is extremely frontloaded as there is no concept of versioned releases, and every SW change needs to immediately pass tests against downstream consumers)</span></li>
            </ul>
        </div>

        <p>
            In the context of CI/CD for monorepos, many of these parameters tend to be at their extremes, as a significant number of engineers are coordinating across a shared set of "input files" (I am using this term loosely since "code" may mean "SW payload" to some but may not be inclusive of build configuration files, RTL (for hardware design), etc) as quickly as possible.
        </p>
        <br>
        <p>
            Thus, in this post I want to discuss a few of the more interesting/complex problems that need to be solved for organizations working at high scale.
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Keeping Trunk Green</h2>

        <p>
            When working on a project with a high development velocity, there is a delicate balance between code change velocity (how frequently the developers' PRs are actually making it into mainline) and stability (all tests pass, releases work, etc).
        </p>
        <br>
        <p>
            If you have extremely frontloaded testing like the <a href="https://dl.acm.org/doi/pdf/10.1145/2854146" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">google3 monorepo</a>, it's likely that your mainline will be fairly stable and the change velocity will be slow. This is common in cases where the business needs emphasize system reliability and developer/customer trust over the <a href="https://hbr.org/2019/01/the-era-of-move-fast-and-break-things-is-over" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">"move fast, break things" philosophy</a>.
        </p>
        <br>
        <p>
            On the opposite end of the spectrum, if you allow for changes to rapidly flow into mainline without extensive testing, developers will be able to quickly ship code in the short-term but it will be difficult for engineers to coordinate and collaborate, especially for large monorepos that have complex intertwined relationships between source files.
        </p>
        <br>
        <p>
            The actual spectrum is much more nuanced than this, and a lot of it also depends on the nature of the domain (i.e. hardware verification has many layers that span beyond the simple "unit/integration/end-to-end testing" concepts of SW) and the other tooling (i.e. the build system / test orchestration layers).
        </p>
        <br>
        <p>
            Nonetheless, regardless of the project details, one of the most common challenges that arises when doing CI/CD at scale is setting up an effective solution to keep mainline green while minimizing developer overhead (i.e. inability to ship quickly). Let's take the most common case of semantic (non-textual) merge conflicts.
        </p>
        <br>
        <p>
            When testing change A independently and on top of mainline, both pipelines pass. The same goes for change B. However, if you were to test mainline + A + B, the tests fail.
        </p>
        <br>
        <p>Here is a simple example of this in Python:</p>

        <div class="bg-base-300 rounded-lg p-4 my-4 overflow-x-auto">
            <p class="text-xs text-base-content/50 mb-2 font-mono">mainline</p>
            <pre class="text-sm font-mono"><code>def add(a: int, b: int) -> int:
    return a + b</code></pre>
        </div>

        <div class="bg-base-300 rounded-lg p-4 my-4 overflow-x-auto">
            <p class="text-xs text-base-content/50 mb-2 font-mono">Change A</p>
            <pre class="text-sm font-mono leading-relaxed"><code><span class="block">  def add(a: int, b: int) -> int:</span><span class="block bg-red-500/20 text-red-400">-     return a + b</span><span class="block bg-green-500/20 text-green-400">+     return a + b + 1</span></code></pre>
        </div>

        <div class="bg-base-300 rounded-lg p-4 my-4 overflow-x-auto">
            <p class="text-xs text-base-content/50 mb-2 font-mono">Change B</p>
            <pre class="text-sm font-mono leading-relaxed"><code><span class="block bg-red-500/20 text-red-400">- def add(a: int, b: int) -> int:</span><span class="block bg-green-500/20 text-green-400">+ def add(a: str, b: str) -> str:</span><span class="block">      return a + b</span></code></pre>
        </div>

        <p>
            These changes textually merge but semantically, if you were to combine them on top of mainline they would break. This particular case is very obvious, but imagine if the actual "change crossing" was much more subtle and was only detectable across the serialization of 50 in-flight changes?
        </p>
        <br>
        <p>
            Thankfully, there is a prior art to change conflict detection. The most common solution popularized by the Rust project's <a href="https://bors.tech/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Bors bot</a> was to create the concept of a <a href="https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">merge queue</a>, where changes are only tested in the context of a serialized queue to ensure that if change A enters the queue and then change B, you perform testing on [mainline+A, mainline+A+B]. When performing this testing, you have the following heuristics (assuming the tests are generally not flaky):
        </p>

        <div class="bg-base-200 rounded-lg p-5 my-6 border-l-4 border-primary">
            <ul class="space-y-2">
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>If mainline+A passes, you are safe to merge A</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>If mainline+A+B passes, you are safe to merge A and then B, regardless of whether mainline+A passes</span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>If mainline+A fails, you need to kick A out of the queue and rebase all subsequent changes. I.e. cancel mainline+A+B and restart it as mainline+B</span></li>
            </ul>
        </div>

        <p>
            That "assuming the tests are generally not flaky" caveat is doing a lot of heavy lifting. Test flakiness is one of the nastiest confounding factors in a merge queue: a flaky failure on mainline+A causes A to be ejected and the entire queue to rebase, even though A was innocent. At scale, even a 1% flakiness rate across a large test suite translates into a near-constant stream of false ejections, eroding developer trust in the system and wasting significant compute in the process.
        </p>
        <br>
        <p>
            This works well if the cost of testing an individual change is relatively small in terms of time and resources and there are a small number of changes entering the queue. However, as the window of time for testing increases, the serialization of changes makes it impossible for developers to get changes into the project! For HW this is a significant issue as verification of RTL can take hours and consume significant amounts of CPU/memory/disk space. In addition, each EDA tool you run will likely require a proprietary license which the company only maintains a certain total of.
        </p>
        <br>
        <p>
            Another mechanism to detect such a crossing is to do analysis on the changes as they are flowing through the system. Rather than imposing strict control over the ordering of changes, you peer into the system as an outside observer and execute heuristics (e.g. smoke tests on individual changes/groups of changes, using language-specific semantic detection tools, or using AI to determine the probability of a break based on the combined diffs).
        </p>
        <br>
        <p>
            Such observation-based approaches are critical because they can provide a lot of information with minimal disruption to the change velocity — getting as close as we can to precision detection of poor changes while allowing developers of the passing changes to quickly see their changes landing into the project.
        </p>
        <br>
        <p>
            It is very similar to the role of a civil engineer monitoring pedestrians cross at a busy intersection, using heatmaps of movement to maximize the flow of traffic and people without anyone even noticing! (No wonder why we call this infrastructure in the first place ;))
        </p>
        <br>
        <p>
            In the case that more tight control over the flow of changes is necessary, you can still impose some form of serialization but you do it more carefully (e.g. group batches of changes together that can be submitted atomically or ejected from the queue). This works well in terms of being more robust than the observation-based approach, but
            it can be a bit complicated to understand from a user POV. There is also an inherent tradeoff: batching increases queue throughput, but when a batch fails you lose the signal of which individual change was the culprit and need to bisect. This generally requires re-running expensive tests multiple times to isolate the offender.
        </p>
        <br>
        <p>There are certainly more aspects of how we tackle such problems for HW at NVIDIA but here are some pointers (the Uber paper in particular is a great read):</p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <ul class="space-y-3">
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <a href="https://www.uber.com/blog/research/keeping-master-green-at-scale/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">Keeping Master Green at Scale</a>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <a href="https://www.chromium.org/developers/testing/commit-queue/design/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">Chromium Commit Queue</a>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <a href="https://bors.tech/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">Bors Bot</a>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <a href="https://mergify.com/blog/the-origin-story-of-merge-queues" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">The Origin of Merge Queues</a>
                </li>
            </ul>
        </div>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Resource Utilization</h2>

        <p>
            In the context of most pure SW projects such as web applications, resource utilization for testing changes in CI/CD doesn't tend to be a large issue. However, for large SW projects (e.g. Microsoft Windows codebase, google3, FB monorepo) you quickly run into the issue that the builds and tests can no longer run on
            a single machine. Build systems such as <a href="https://bazel.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Bazel</a> and <a href="https://engineering.fb.com/2023/04/06/open-source/buck2-open-source-large-scale-build-system/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Buck2</a> were designed with this concept in mind, attempting to aggressively cache builds/test results and allow for extreme horizontal scaling through distributed builds (an interesting history of this is provided <a href="https://www.youtube.com/watch?v=mEx8NWm4830" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">here</a>).
        </p>
        <br>
        <p>
            For HW, the build system is an important lever in controlling resource utilization, but there are still other nuanced aspects of it. A big example of this is randomized regressions. Many DV testbenches are designed to perform thorough randomized testing of the HW in order to have deeper confidence in the RTL (since you cannot patch HW as easily as you can SW!).
        </p>
        <br>
        <p>
            Much of this can be performed on mainline (rather than being part of the PR CI/CD) but the more of this that you can frontload, the less work you will have later on in terms of triaging regression failures. As a result, each CI/CD pipeline will still need to consume a non-trivial amount of resources for testing. Therefore, thought must be put into managing things such as the total number of inflight pipelines and prioritizing resource allocation based on "change significance".
        </p>
        <br>
        <p>
            Another big part of this is the storage cost of cloning a monorepo. If a clone of your repository takes terabytes if not petabytes on disk, fresh clones and incremental syncs can be extremely expensive, even for your CI/CD runs! <a href="https://en.wikipedia.org/wiki/Piper_(source_control_system)" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Google</a>, <a href="https://github.com/facebook/sapling" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Meta</a> and <a href="https://en.wikipedia.org/wiki/Virtual_File_System_for_Git" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Microsoft</a> all have
            custom SCM flows that rely on virtual filesystems to pretend that the local SCM client has all of the files it needs, using client specs and/or the build system to know what actual files are needed (Microsoft's approach eventually became <a href="https://devblogs.microsoft.com/devops/introducing-scalar/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Scalar</a>, which is now part of Git itself). For HW at NVIDIA we have also needed to tackle this problem so that we can easily scale developer testing and CI/CD regressions to thousands of engineers while minimizing the overall cost.
        </p>
        <br>
        <p>
            Finally, as previously mentioned HW builds/tests rely on a variety of EDA tools. Most proprietary EDA tools require checking out a license while using them, and most HW companies have a fixed-sized pool of licenses that can be shared across users and automated flows. So, a lot of thought goes into managing those licenses such that you can get the
            ideal outcome (i.e. maximizing usage) at minimal cost (minimal overall number of licenses to pay for).
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Developer Experience</h2>

        <p>
            When developers are shipping complex interdependent changes to a large monorepo, the UI/UX of both the source control tool and the CI/CD platform needs to be seamless, convenient, and fast. The goal is that the "iterate->debug->iterate" loop is fairly tight and has minimal overhead w.r.t. debugging external issues or "babysitting" CI/CD pipelines.
        </p>
        <br>
        <p>
            There should be as much automation in place as possible to facilitate this process and minimize the burden placed on engineers. Additionally, it should be simple for teams to collaborate on groups of changes that have relationships with each other in order to make larger-scale impacts (think large refactors, architectural overhauls, etc). By making the developer platform efficient, engineers can remain in a flow state and focus on shipping features rather than worrying about the infrastructure.
        </p>
        <br>
        <p>
            This is an area that I think about improving a lot because CI/CD plays an important role in how effectively teams are able to ship. The <a href="https://dora.dev/guides/dora-metrics-four-keys/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">DORA metrics</a> (deployment frequency, lead time for changes, change failure rate, and time to restore) provide a useful vocabulary for reasoning with these facets of developer productivity. A few areas that I think are exciting in improving this are:
        </p>

        <div class="bg-base-200 rounded-lg p-5 my-6">
            <ul class="space-y-2">
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Using AI to help with <a href="https://arxiv.org/abs/2603.03823" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">CI/CD pipeline management and repository maintenance</a></span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Using AI to help with <a href="https://about.gitlab.com/blog/developing-gitlab-duo-blending-ai-and-root-cause-analysis-to-fix-ci-cd/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">triaging build/test failures through log analysis</a></span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>Creating powerful command-line tools, APIs, and GUIs for reasoning about change management. This applies at the level of individual developers shipping features as well as PMs/team leads who want to monitor and control the flow of changes at a larger scale</span></li>
            </ul>
        </div>

        <p>
            These three areas of keeping trunk green, managing resources, and developer experience are deeply interconnected. A slow or unreliable merge queue creates resource pressure as pipelines pile up, which in turn degrades the developer experience as engineers wait longer for feedback and lose confidence in the system. Conversely, investing in better DevEx tooling (cleaner failure summaries, smarter scheduling) reduces the cognitive load of managing in-flight changes, which makes it easier to catch problems earlier.

            Improving on each dimension holistically allows for faster development, more seamless code maintenance, and happier developers. I hope to write more about these topics in the future, as monorepo change management poses many interesting challenges to solve!
        </p>

    </article>
</div>
"""
