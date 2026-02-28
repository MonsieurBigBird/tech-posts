module [
    blogPostPageHtml!,
]

import Posts.Post

# ProprietaryEdaSoftware.roc
# Proprietary EDA software blog post content

# Blog post page content
blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "proprietary-eda-software-is-dead-long-live-proprietary-eda-software" -> Posts.Post.renderPostPage!("Proprietary EDA Software is Dead, Long Live Proprietary EDA Software! - Blog", "blog", proprietaryEdaContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

# Blog post content
proprietaryEdaContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>February 28, 2026</span>
            <span>•</span>
            <span>7 min read</span>
            <span>•</span>
            <span>by Matt Boisvert</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">EDA</span>
                <span class="badge badge-accent badge-sm">infrastructure</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">Proprietary EDA Software is Dead, Long Live Proprietary EDA Software!</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            A look at how the semiconductor industry arrived at hyper-specialized proprietary tooling, and why the AI era may finally be changing that.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">

        <p>
            The year is 2026. You, a passionate hardware engineer, sit down at your desk and open up your laptop to start work. First, you open up a remote SSH VNC session displaying a laggy Linux desktop from 2005. Then, you open up a proprietary set of domain-specific software tools to begin your work, whether it is writing RTL (e.g. running sims), performing design verification (e.g. debugging waves), or creating the physical design (e.g. placing and routing).
        </p>
        <br>
        <p>
            For most semiconductor companies working at scale, such bespoke proprietary flows are entrenched. There are some notable exceptions — especially for companies which have sprung up relatively recently and/or are working at a lower scale — but they are far from being the default today. Thus, for software engineers used to modern OSS tooling, even something as basic as the version control system (Git is not as ubiquitous as you might think!) would be taken for granted as an "assumed tool".
        </p>
        <br>
        <p>
            So, why is this the case? And how did we get here?
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">A Brief History of EDA</h2>
        <p>
            Before diving into the history, I want to first emphasize that SW flows for HW are rapidly evolving, as more and more HW development relies on scalable SW infrastructure (e.g. large-scale build systems, CI/CD, storage systems, cloud-based compute farms, etc.). That being said, this change needs to be taken in the context of the semiconductor industry's long history, which differs quite significantly from that of pure SW companies.
        </p>
        <br>
        <p>
            Historically, the semiconductor industry has relied on <a href="https://en.wikipedia.org/wiki/Electronic_design_automation" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">EDA (electronic design automation)</a> and <a href="https://en.wikipedia.org/wiki/Computer-aided_design" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">CAD (computer-aided design)</a> tools to help with each portion of the chip development lifecycle. These tools encompass everything from GUI-based visualizations of layouts to CLI tools and libraries for logic synthesis. I find it helpful to think of this process as not unlike a scientist who interacts with domain-specific software as part of their job (even if their core expertise is not necessarily in SW itself).
        </p>
        <br>
        <p>
            There is a growing movement within the HW industry to promote OSS trends, and it is exciting to watch:
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <ul class="space-y-3">
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://riscv.org/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">RISC-V</a>
                        <p class="text-sm text-base-content/70 mt-1">An open ISA avoiding ARM/x86 license costs, gaining significant industry traction</p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://github.com/aolofsson/awesome-opensource-hardware" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">OSS alternatives to common proprietary tools</a>
                        <p class="text-sm text-base-content/70 mt-1">A growing collection of open-source replacements across the EDA toolchain</p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://tinytapeout.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">Tiny Tapeout</a>
                        <p class="text-sm text-base-content/70 mt-1">Improving education and expertise in EE by making chip design accessible</p>
                    </div>
                </li>
                <li class="flex items-start">
                    <span class="text-primary mr-3 mt-1">•</span>
                    <div>
                        <a href="https://www.siliconcompiler.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium">Silicon Compiler</a>
                        <p class="text-sm text-base-content/70 mt-1">Creating new SW products specifically designed for HW development workflows</p>
                    </div>
                </li>
            </ul>
        </div>

        <p>
            However, there is still a significant gap between the large ecosystem of advanced tools and processes required to produce chips at scale and what is achievable today with purely OSS tools.
        </p>
        <br>
        <p>
            While a SW engineer may have some concept of using familiar tools that they can easily look up online or contribute to (e.g. a web framework such as React or Angular), HW engineers are often using in-house or third-party proprietary tools which are specifically designed to push Moore's Law to its limits. An exaggerated version of this would be to imagine if Meta and Google never open-sourced React or Angular, choosing instead to double-down on the view that their frontend frameworks captured trade secrets which gave them an edge over the competition.
        </p>
        <br>
        <p>
            Obviously, this is not a fair comparison — there are very fundamental differences between HW and SW development. HW development has significant upfront costs, export control restrictions (on designs and EDA tools), and a fine line between common methodologies and trade secrets. Additionally, the complex supply chain of semiconductors has given a significant concentration of control over advanced EDA tools to a few companies (Cadence, Synopsys, and Siemens). As a result, the daily tools that HW engineers use are conformed to fit the mold of the industry: hyper-specialized and proprietary. A lot of this is reflected throughout <a href="https://www.amazon.com/Chip-War-Worlds-Critical-Technology/dp/1982172002" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors font-medium"><em>Chip War: The Fight for the World's Most Critical Technology</em></a> by Chris Miller, which goes further into the deep history of semiconductor manufacturing as well as its relationship with geopolitics.
        </p>
        <br>
        <p>
            For many, this might seem like an obvious fact of life for a high-scale advanced manufacturing industry. (And conversely, for my OSS HW colleagues, this reality may seem more of a myth — many pieces of new HW do not rely on it at all.) I would generally agree, but with two nuanced claims:
        </p>

        <div class="bg-gradient-to-r from-primary/5 to-secondary/5 rounded-lg p-6 my-8 border-l-4 border-primary">
            <h3 class="text-xl font-bold text-primary mb-6">Two Claims About the Future</h3>
            <div class="space-y-6">
                <div class="bg-base-100 rounded-lg p-5 border border-primary/20">
                    <div class="flex items-start">
                        <div class="flex-shrink-0 w-8 h-8 bg-primary text-primary-content rounded-full flex items-center justify-center font-bold text-sm mr-4">1</div>
                        <div>
                            <h4 class="font-semibold text-primary mb-2">Proprietary solutions may continue to persist at the bleeding edge, but AI complicates this picture</h4>
                            <p class="text-base-content/80">
                                Regardless of the proliferation of OSS HW tools, the supply chain of the semiconductor industry may still trend towards favoring proprietary solutions for the most advanced nodes. Given the extraordinary difficulty of increasing transistor density while minimizing power consumption today, it makes sense that EDA vendors and chip designers are investing herculean efforts towards advancing their tools. Because of the cost of these efforts, it will be hard for OSS equivalents to keep pace at the frontier.
                            </p>
                            <br>
                            <p class="text-base-content/80">
                                That being said, AI is actively reshaping this process. We are already seeing it applied to some of the <a href="https://deepmind.google/blog/how-alphachip-transformed-computer-chip-design/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">hardest problems in chip design</a>. Notably, the <a href="https://www.theregister.com/2026/02/10/cadences_agentic_chip_design_tool/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">major EDA vendors themselves are racing to integrate AI into their own toolchains</a>, which cuts both ways: it accelerates proprietary capabilities, but also signals that the underlying design intelligence may become more democratizable over time, potentially eroding the moat that proprietary tools have historically enjoyed.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="bg-base-100 rounded-lg p-5 border border-secondary/20">
                    <div class="flex items-start">
                        <div class="flex-shrink-0 w-8 h-8 bg-secondary text-secondary-content rounded-full flex items-center justify-center font-bold text-sm mr-4">2</div>
                        <div>
                            <h4 class="font-semibold text-secondary mb-2">HW companies will increasingly map their methodologies to OSS flows as they scale</h4>
                            <p class="text-base-content/80">
                                Many methodology and workload scalability challenges faced by HW companies map to some version of a common SW problem. With enough creativity, it is possible to map OSS SW tools to these flows, meaning that we can solve the problem while improving the longevity of those flows by keeping them in line with SW industry trends and practices. This is one of my favorite parts of my role in architecting and implementing such systems, since they balance the boundary of solving real-world business issues and staying connected to the OSS community. I hope to publish more on my work in these areas soon w.r.t. build systems, CI/CD, and version control.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">A Golden Age of Innovation</h2>
        <p>
            With both of these claims in mind, I think this is a golden age of innovation for HW companies. AI is making it significantly easier to advance HW design flows and mitigate the moats created by third-party software. I highly recommend a related post by Chris Lattner on this subject: <a href="https://www.modular.com/blog/the-claude-c-compiler-what-it-reveals-about-the-future-of-software" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">The Claude C Compiler: What it Reveals About the Future of Software</a>. AI may not be capable of writing a production-worthy C compiler today, but we can see the groundwork being laid for rapid changes in large-systems engineering. Additionally, AI significantly reduces the cost of migrating flows to new methodologies and integrating OSS tools with specific business needs. If a company needs to create a piece of HW infrastructure, why not figure out how to map that onto a large OSS project that our models can understand deeply?
        </p>
        <br>
        <p>
            So then, while there are many hurdles and challenges we will encounter in pushing semiconductors to the bleeding edge, I hope to convey a feeling of being at an inflection point — the past of silicon development still lays its shadows, but we will press on in advancing to the future.
        </p>
        <br>
        <p>
            And who knows, maybe soon I will be able to get out of using Perforce ;).
        </p>

    </article>
</div>
"""

