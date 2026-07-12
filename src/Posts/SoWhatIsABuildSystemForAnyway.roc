module [
    blogPostPageHtml!,
]

import Posts.Post

blogPostPageHtml! : Str => Str
blogPostPageHtml! = |postSlug|
    when postSlug is
        "so-what-is-a-build-system-for-anyway" -> Posts.Post.renderPostPage!("So, What is a Build System Anyway? - Blog", "blog", buildSystemContentHtml)
        _ -> Posts.Post.renderPostPage!("Post Not Found - Blog", "blog", Posts.Post.notFoundPostContentHtml)

buildSystemContentHtml =
"""
<div class="max-w-4xl mx-auto">
    <!-- Post Header -->
    <div class="mb-8">
        <div class="flex items-center space-x-2 text-sm text-base-content/60 mb-4">
            <span>July 11, 2026</span>
            <span>•</span>
            <span>10 min read</span>
            <span>•</span>
            <span>by Matt Boisvert</span>
            <span>•</span>
            <div class="flex space-x-1">
                <span class="badge badge-primary badge-sm">build systems</span>
                <span class="badge badge-accent badge-sm">hardware</span>
            </div>
        </div>
        <h1 class="text-4xl font-bold text-primary mb-4">So, What is a Build System Anyway?</h1>
        <p class="text-xl text-base-content/80 leading-relaxed">
            An abridged history of build technologies and some interesting challenges in the realm of build systems for hardware design.
        </p>
    </div>

    <!-- Post Content -->
    <article class="prose prose-lg max-w-none">

        <p>
            For several years, I have seen build and language ecosystem tools being misused to create haphazardly-maintained builds,
            deployments, and interfaces between projects. Across projects I have seen drastically different approaches to this
            (<a href="https://abseil.io/resources/swe-book/html/ch18.html" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">google3</a>,
            Google's internal monorepo, is notoriously biased toward "philosophically maintained" builds, while small projects tend to
            be much scrappier and rely on shell scripts and duct tape). I want to describe some of the background for what build tools
            are used for and how they apply to hardware infrastructure. Going back several decades, the canonical starting point for
            most engineers is the venerable
            <a href="https://en.wikipedia.org/wiki/Make_(software)" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">GNU Make</a>,
            whose purpose is to orchestrate the execution of language toolchains as part of a larger engineering workflow.
        </p>
        <br>
        <p>
            For those who have learned this in the context of C or C++ development, you might recall Makefile boilerplate files which look like:
        </p>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <div class="flex flex-col md:flex-row gap-6 items-start">
                <div class="flex-1 overflow-x-auto">
                    <p class="text-xs text-base-content/50 mb-2 font-mono">Makefile</p>
                    <pre class="text-sm font-mono"><code># Source: https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
CC=gcc
CFLAGS=-I.
DEPS = hellomake.h
OBJ = hellomake.o hellofunc.o

# pattern rule: compile any .o from its matching .c file, and re-run if any header in DEPS changes
%.o: %.c \$(DEPS)
	\$(CC) -c -o $@ $< \$(CFLAGS)

# link all object files into the final binary
hellomake: \$(OBJ)
	\$(CC) -o $@ $^ \$(CFLAGS)</code></pre>
                </div>
                <div class="flex justify-center md:justify-start">
                    <img src="/static/images/hellomake.png" alt="Dependency graph for the hellomake project" class="rounded-lg max-w-xs w-full h-auto" />
                </div>
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic">
                Simple Make example for C code (<a href="https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/" target="_blank" class="underline">source</a>). For the opinionated Make users, I apologize for my sins.
            </p>
        </div>
        <br>
        <p>
            The named <code>hellomake</code> target expresses both a set of dependencies that need to be built before it and a
            list of shell commands that need to run in order to actually build it. With the top-level target that the user intends to
            <code>make</code>, we are able to easily express a declarative directed acyclic graph (DAG) of tasks which all contribute to a common end product
            (e.g. binary executables, container images, software artifacts). Its design will feel natural to anyone steeped in Unix's
            philosophy of composition, and its pattern-action style will feel familiar to those who have spent time with older
            Unix text-processing tools like <a href="https://en.wikipedia.org/wiki/AWK" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors"><code>awk</code></a> or <a href="https://en.wikipedia.org/wiki/Sed" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors"><code>sed</code></a> (which makes sense given that the original version is from 1976!).
        </p>
        <br>
        <p>
            I tend to think of build systems for large projects as <em>workflow compilers</em>. Instead of optimizing the compilation
            of source files into executables, they orchestrate the execution of language-specific compilers as part of a higher-level
            software development flow. This becomes more necessary as individual shell scripts or Makefiles fail to form the cohesive
            glue connecting polyglot components to each other.
        </p>
        <br>
        <p>
            If your project lives in a single language with its own toolchain (e.g. <a href="https://doc.rust-lang.org/cargo/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Cargo</a> for Rust, <a href="https://docs.astral.sh/uv/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">uv</a> for Python, <a href="https://www.npmjs.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">npm</a> for JavaScript), this might seem like a solved
            problem. However, as projects grow in size, scope, and heterogeneity, they become hard to manage both organizationally and at scale for a few reasons.
        </p>
        <br>


        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">1. Large Polyglot Projects</h2>

        <div class="bg-base-200 rounded-lg p-6 my-6">
            <div class="flex justify-center">
                <img src="/static/images/polyglot_problem.png" alt="A polyglot project depending on a C component built with Make and a Rust component built with Cargo, with no shared way to express the cross-project dependency" class="rounded-lg max-w-full h-auto" />
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic text-center">
                Contrived example of complex dependencies across different projects in an organization. A strong build system serves to provide the orchestration layer of complex workflows across dependent projects.
            </p>
        </div>

        <p>
            I think the polyglot scenario is often underrated when thinking about build systems. If you have a large software project
            composed of many smaller projects, you end up needing an intermediate layer of "this is how you consume
            project B from project A". You could choose to do this at the network layer (e.g. each project is a microservice that talks
            to the others), the version control layer ("I pinned this vendored submodule at commit xyz"), or the artifact layer
            ("my OCI container sits on top of this versioned release of another image"). In practice, you will often find these
            mechanisms break down as not all components use the same interface to express versioned, testable dependencies.
        </p>
        <br>
        <p>
            Build systems such as Make express these dependencies at the level of an individual directory of code, but they don't
            prescribe a systematic recipe for:
        </p>

        <div class="bg-base-200 rounded-lg p-5 my-6">
            <ul class="space-y-3">
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                     How to scale this across a large contributor base spanning one or many repositories — as a consumer of a package, how do you know how to build it? How do contributors reuse build steps across different languages?
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    How to ensure that the "targets are written well" — similar to how you want static analysis for your compiler to
                    catch bugs in your program, you want some mechanism to know that when you are building a piece of software, you
                    can do it in a reproducible and secure way. Makefiles are notorious for being written poorly because they are
                    essentially arbitrary shell code (particularly with chained <code>.PHONY</code> tasks).
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    How to provide a consistent developer experience regardless of language or toolchain (i.e. a first-class build, test, and run interface that works the same across languages)
                </span></li>
            </ul>
        </div>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">2. The Reason We Typically Think of</h2>

        <p>
            Build system enthusiasts are always eager to discuss how Makefiles break down at scale, but I think the history of how we got to the point of
            improvement is interesting. In
            <a href="https://www.youtube.com/watch?v=mEx8NWm4830&pp=ygUTcGFudHMgYmF6ZWwgaGlzdG9yeQ%3D%3D" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">a talk on the history of Pants and Bazel</a>,
            Benjy Weinberger mentions that at Google, Make was the default build tool until it was effectively unusable. This makes
            sense as the size of the graph starts to grow — it's harder to build all of the dependencies, let alone calculate the changes
            to the dependency graph, on a single machine. You can imagine a monorepo with thousands of source files, each being
            <code>stat</code>-ed at <code>make</code>-time to determine what needed to be rebuilt, only to slow the developer's
            workstation to a grinding halt.
        </p>
        <br>
        <p>
            This assumes that you even have the storage to fit all of the relevant source files on the developer's workstation. For
            hardware development (and as Google later developed with their
            <a href="https://dl.acm.org/doi/10.1145/2854146" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">virtual filesystem</a>),
            this expectation breaks down due to the cumulative volume of the sources in the project.
        </p>
        <br>
        <p>
            But I want to take this a step further: distributed execution of the graph is not the only problem that
            would need to be solved. In fact, there are numerous implementations of
            <a href="https://distcc.github.io/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">"distributed Make"</a>
            concepts that attempt to resolve this issue. The problem with this approach is that yes, you are able to get your build system to actually handle
            the size of your graph. However, you haven't solved the problem of caching in a meaningful way. You will still have long
            cold-build times and frustrating incremental builds. And, if someone else has already built the same exact content before,
            you shouldn't have to re-pay the cost of doing it again. A true and meaningful improvement over what Make provides is one
            that supports distributed execution <strong>and</strong> content-addressable caching of build artifacts and actions.
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Where We Are Now: REv2 and the Modern Build Ecosystem</h2>

        <p>
            Today there are several build systems that solve these problems systematically. After Google open-sourced
            their internal build system, Blaze, as
            <a href="https://bazel.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Bazel</a>
            in 2015, one of the most significant contributions wasn't the tool itself but the protocol it brought with it: the <a href="https://github.com/bazelbuild/remote-apis" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Remote
            Build Execution API</a> (REv2, also known as REAPI). This API standardizes the way in which any build system client can
            integrate with a remote backend that can execute build actions on distributed workers and cache actions and build artifacts.
            Now, nearly every modern build system integrates with REv2. Besides Google's Bazel, we also have Meta's
            <a href="https://buck2.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Buck2</a>
            and the community-driven <a href="https://www.pantsbuild.org/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Pants</a>.
            The theoretical underpinning of what distinguishes these systems from each other is laid out well in
            <a href="https://dl.acm.org/doi/10.1145/3236774" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors"><em>Build Systems à la Carte</em></a>
            (Mokhov et al., ICFP 2018), if you want to go deeper.
        </p>
        <br>
        <div class="bg-base-200 rounded-lg p-6 my-6">
            <div class="flex justify-center">
                <img src="/static/images/buildbarn_architecture.png" alt="BuildBarn architecture diagram showing a Bazel client connecting through RPC demultiplexing to a content-addressable storage and action cache, a scheduler, and worker nodes" class="rounded-lg max-w-full h-auto" />
            </div>
            <p class="text-sm text-base-content/60 mt-4 italic text-center">
                Architecture of REv2 service <a href="https://github.com/buildbarn/bb-remote-execution" target="_blank" class="underline">BuildBarn</a> (<a href="https://github.com/buildbarn/bb-deployments" target="_blank" class="underline">source</a>), illustrating how a build client interacts with a REv2-compliant backend.
            </p>
        </div>

        <p>
            What REv2 actually decouples is the build client from the execution backend. A client submits an <em>Action</em> —
            a content-addressed description of inputs and the command to run — to a remote service. The service checks whether
            that exact action has been executed before, using the <a href="https://en.wikipedia.org/wiki/Content-addressable_storage" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">content-addressable store</a> (CAS) as a lookup key. If it has,
            the cached result is returned immediately. If not, the action is dispatched to a worker, run in an isolated sandbox,
            and the outputs are stored in the CAS before being returned to the client. The result is that any two builds sharing
            the same inputs and commands, regardless of who ran them or when, automatically share their outputs.
        </p>
        <br>
        <p>
            Distributed make just gives us parallelism, but this gives us memoization at the action level, allowing us to share incremental build results across all users and CI jobs simultaneously!
        </p> 

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Builds for Hardware</h2>

        <p>
            So REv2 solves the build-at-scale problem for software, but there are some interesting challenges that you have to solve for separately for hardware flows (see <a href="https://mattboisvert.net/blog/proprietary-eda-software-is-dead-long-live-proprietary-eda-software" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">this post</a> for a background of EDA flows and tooling).
        </p>

        <h3 class="text-xl font-semibold text-primary mt-6 mb-3">Scheduling Requirements</h3>

        <p>
            For the vast majority of pure-software projects, the resources required to build, run, and test an individual
            component are not typically extreme. With EDA tools, there is a wide range of resource requirements you could have
            (e.g. running an RTL linter such as Spyglass might be much "cheaper" than running a simulator such as VCS).
        </p>
        <br>
        <p>
            This is what drove the adoption of batch schedulers for hardware development (and other resource-intensive domains like
            HPC), especially <a href="https://www.ibm.com/products/hpc-workload-management" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">LSF</a> and <a href="https://slurm.schedmd.com/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Slurm</a>. These schedulers treat resource requirements (including EDA tool licenses!) as first-class citizens in a job's definition,
            which lets you manage compute pools effectively. In pure software, this kind of job with complex resource requirements has
            only come up in the last few years with the rise of LLM training — which seems to be one of the core reasons Kubernetes
            introduced <a href="https://kueue.sigs.k8s.io/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Kueue</a> for workload-based batch scheduling in late 2022.
        </p>
        <br>
        <p>
            What this means for hardware workflows is that most builds which involve orchestrating the invocation of EDA tools rely on an
            HPC batch scheduler as the mechanism to do the scheduling. Attempting to map this onto RBE is possible, but it's not
            provided out-of-the-box with most REv2 services. <a href="https://github.com/buildbarn/bb-remote-execution" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">BuildBarn</a>, for example, has its own scheduler which relies on tags to
            distribute the jobs to independent worker pools (where workers in a given pool share the same platform properties). These
            workers are expected to be long-lived daemon processes — more like persistent K8s pods than pre-scheduled batch executors.
        </p>

        <h3 class="text-xl font-semibold text-primary mt-6 mb-3">Large Binary Sizes</h3>

        <p>
            Artifacts produced by running EDA tools such as the <code>simv</code> executables produced by VCS are notoriously large,
            especially when working with a complex hardware design.
        </p>
        <br>
        <p>
            If you don't have CAS, this problem doesn't exist in the sense that you never had to worry
            about storing large quantities of iterative output. You could simply have a basic storage architecture with golden
            outputs being released, and something even as simple as NFS could store these (even though it pains me deeply to promote NFS).
        </p>
        <br>
        <p>
            But with CAS, in a hardware context you need to think much more carefully about storage consumption and cache management
            in order to only keep content that is likely to be re-used across someone else's build. These large binaries
            are a forcing function for ensuring data locality. If you have one action dispatched to a node that produces a
            <code>simv</code> target and another action dispatched to a separate node to run it, you have to pay the cost of waiting
            for the first executor to upload the content to the CAS and then the second executor downloading it from the CAS.
        </p>
        <br>
        <p>
            For software builds, this is still an issue but it is mitigated by the fact that incremental artifacts tend to be manageable
            in size. For hardware, this becomes a hard constraint if your goal is to minimize end-to-end build latency — the data
            movement cost alone can dominate the savings from remote execution.
        </p>

        <h3 class="text-xl font-semibold text-primary mt-6 mb-3">Absolute Paths + Multiple Layers of Caching</h3>

        <p>
            Complex EDA tools are typically vertically-integrated, meaning that they attempt to provide many features to make
            the development workflow of a hardware engineer more efficient (and presumably to justify their high cost). One of these
            features is caching for the purpose of incremental compilation. This is somewhat analogous to a Python development
            workspace where each execution leaves around <code>.pyc</code> files that speed up subsequent runs.
        </p>
        <br>
        <p>
            The problem is that this tool-internal state is fundamentally at odds with the CAS model. REv2 actions are supposed
            to be hermetic: they run in a clean sandbox with only their declared inputs, and the same inputs always produce the same
            outputs. But EDA tool caches encode the history of previous runs on a particular machine — they're stateful, often embed
            absolute paths, and aren't portable across workers. If you try to include the tool cache as part of an action's declared
            inputs (making it part of the content hash), you still have to upload and download it from the CAS on every invocation,
            which can easily cost more than the compilation time it was meant to save. And if you leave it out, the tool starts cold
            on every action, defeating the purpose of the cache entirely. The two layers of caching — CAS-level action memoization
            and tool-level incremental state — operate on incompatible assumptions about what it means to "reuse prior work."
        </p>

        <h3 class="text-xl font-semibold text-primary mt-6 mb-3">Debuggability of Remote Builds</h3>

        <p>
            When you are going to make a change which impacts the developer flow for engineers (especially those whose primary expertise is in hardware rather than software), you have to think carefully
            about the UI/UX for end-users. Bazel provides a <a href="https://bazel.build/remote/bep" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Build Event Protocol</a> (BEP) that streams structured build
            events (e.g. actions dispatched, cache hits, test results) to a result store, which helps significantly for CI observability.
            However, this doesn't solve the deeper problem of interactive debugging.
        </p>
        <br>
        <p>
            Hardware engineers are accustomed to running EDA tools interactively: SSHing into the same machine the tool ran on,
            opening the tool's own GUI (DVE for VCS waveform debugging, for instance), and inspecting intermediate files left on
            disk. Remote builds are somewhat incompatible with this concept since the hermetic sandboxes are intended to be ephemeral in nature.
            This of course, is not a nonstarter for adoption for RBE (especially if you customize your RBE or build on top of the BEP). It's more that concepts such as "hermeticity" need to demonstrate
            clear benefits in terms of cache reuse to sell the vision of adopting a system with such a model.
        </p>

        <h2 class="text-2xl font-bold text-primary mt-8 mb-4">Worth Exploring</h2>

        <p>
            This is an area I work in and plan to keep writing about — the build ecosystem is moving fast, and there are a lot
            of interesting problems still being worked out in the open. If any of this was interesting, here are some things worth
            poking around in:
        </p>
        <br>

        <div class="bg-base-200 rounded-lg p-5 my-6">
            <ul class="space-y-3">
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://bazel.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Bazel</a>
                    — Google's open-source build system and the origin of the REv2 protocol
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://buck2.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Buck2</a>
                    — Meta's build system, rebuilt from scratch in Rust with first-class remote execution support
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://www.pantsbuild.org/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Pants</a>
                    — an open-source polyglot build system with strong Python and Go support
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://github.com/buildbarn/bb-remote-execution" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">BuildBarn</a>
                    — an open-source REAPI server with a focus on scalability and worker pool management
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://www.buildbuddy.io/blog/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">BuildBuddy blog</a>
                    — another managed RBE + result store service; good writing on RBE internals, including a deep dive on
                    <a href="https://www.buildbuddy.io/blog/content-defined-chunking/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">content-defined chunking</a>
                    for CAS
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://aspect.build/blog" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Aspect Build blog</a>
                    — Bazel consultancy and tooling company; consistently good writing on Bazel internals and the RBE ecosystem
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://blog.bazel.build/" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Bazel blog</a>
                    — official release notes and engineering posts from the Bazel team
                </span></li>
                <li class="flex items-start"><span class="text-primary mr-3 mt-1">•</span><span>
                    <a href="https://dvcon-proceedings.org/wp-content/uploads/1132-Using-a-modern-software-build-system-to-speed-up-complex-hardware-design.pdf" target="_blank" class="text-primary hover:text-primary-focus underline decoration-2 underline-offset-2 transition-colors">Using a Modern Software Build System to Speed Up Complex Hardware Design</a>
                    (DVCon) — one of the few published pieces specifically on applying modern build tooling to EDA workflows, written by a colleague at Tenstorrent
                </span></li>
            </ul>
        </div>

    </article>
</div>
"""
