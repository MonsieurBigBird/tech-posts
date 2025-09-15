module [
    aboutPageHtml!,
    serveImageFile!,
]

import pf.Http exposing [Response]
import pf.File
import Shared

aboutPageHtml! : {} => Str
aboutPageHtml! = |_| Shared.baseLayoutHtml!("About - Software Engineer", "about", aboutContentHtml)
aboutContentHtml =
"""
<div class="hero bg-base-200 rounded-lg p-8 mb-8 relative overflow-hidden">
    <!-- Animated Infrastructure Background -->
    <div class="infrastructure-bg">
        <!-- Floating servers with labels -->
        <div class="floating-server-container">
            <svg class="floating-server w-12 h-12" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5.25 14.25H18.75M5.25 14.25C3.59315 14.25 2.25 12.9069 2.25 11.25M5.25 14.25C3.59315 14.25 2.25 15.5931 2.25 17.25C2.25 18.9069 3.59315 20.25 5.25 20.25H18.75C20.4069 20.25 21.75 18.9069 21.75 17.25C21.75 15.5931 20.4069 14.25 18.75 14.25M2.25 11.25C2.25 9.59315 3.59315 8.25 5.25 8.25H18.75C20.4069 8.25 21.75 9.59315 21.75 11.25M2.25 11.25C2.25 10.2763 2.5658 9.32893 3.15 8.55L5.7375 5.1C6.37488 4.25016 7.37519 3.75 8.4375 3.75H15.5625C16.6248 3.75 17.6251 4.25016 18.2625 5.1L20.85 8.55C21.4342 9.32893 21.75 10.2763 21.75 11.25M21.75 11.25C21.75 12.9069 20.4069 14.25 18.75 14.25M18.75 17.25H18.7575V17.2575H18.75V17.25ZM18.75 11.25H18.7575V11.2575H18.75V11.25ZM15.75 17.25H15.7575V17.2575H15.75V17.25ZM15.75 11.25H15.7575V11.2575H15.75V11.25Z"/>
            </svg>
            <div class="server-label">web-01</div>
        </div>
        <div class="floating-server-container">
            <svg class="floating-server w-8 h-8" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5.25 14.25H18.75M5.25 14.25C3.59315 14.25 2.25 12.9069 2.25 11.25M5.25 14.25C3.59315 14.25 2.25 15.5931 2.25 17.25C2.25 18.9069 3.59315 20.25 5.25 20.25H18.75C20.4069 20.25 21.75 18.9069 21.75 17.25C21.75 15.5931 20.4069 14.25 18.75 14.25M2.25 11.25C2.25 9.59315 3.59315 8.25 5.25 8.25H18.75C20.4069 8.25 21.75 9.59315 21.75 11.25M2.25 11.25C2.25 10.2763 2.5658 9.32893 3.15 8.55L5.7375 5.1C6.37488 4.25016 7.37519 3.75 8.4375 3.75H15.5625C16.6248 3.75 17.6251 4.25016 18.2625 5.1L20.85 8.55C21.4342 9.32893 21.75 10.2763 21.75 11.25M21.75 11.25C21.75 12.9069 20.4069 14.25 18.75 14.25M18.75 17.25H18.7575V17.2575H18.75V17.25ZM18.75 11.25H18.7575V11.2575H18.75V11.25ZM15.75 17.25H15.7575V17.2575H15.75V17.25ZM15.75 11.25H15.7575V11.2575H15.75V11.25Z"/>
            </svg>
            <div class="server-label">api-01</div>
        </div>
        <div class="floating-server-container">
            <svg class="floating-server w-10 h-10" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5.25 14.25H18.75M5.25 14.25C3.59315 14.25 2.25 12.9069 2.25 11.25M5.25 14.25C3.59315 14.25 2.25 15.5931 2.25 17.25C2.25 18.9069 3.59315 20.25 5.25 20.25H18.75C20.4069 20.25 21.75 18.9069 21.75 17.25C21.75 15.5931 20.4069 14.25 18.75 14.25M2.25 11.25C2.25 9.59315 3.59315 8.25 5.25 8.25H18.75C20.4069 8.25 21.75 9.59315 21.75 11.25M2.25 11.25C2.25 10.2763 2.5658 9.32893 3.15 8.55L5.7375 5.1C6.37488 4.25016 7.37519 3.75 8.4375 3.75H15.5625C16.6248 3.75 17.6251 4.25016 18.2625 5.1L20.85 8.55C21.4342 9.32893 21.75 10.2763 21.75 11.25M21.75 11.25C21.75 12.9069 20.4069 14.25 18.75 14.25M18.75 17.25H18.7575V17.2575H18.75V17.25ZM18.75 11.25H18.7575V11.2575H18.75V11.25ZM15.75 17.25H15.7575V17.2575H15.75V17.25ZM15.75 11.25H15.7575V11.2575H15.75V11.25Z"/>
            </svg>
            <div class="server-label">db-01</div>
        </div>
        <div class="floating-server-container">
            <svg class="floating-server w-6 h-6" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5.25 14.25H18.75M5.25 14.25C3.59315 14.25 2.25 12.9069 2.25 11.25M5.25 14.25C3.59315 14.25 2.25 15.5931 2.25 17.25C2.25 18.9069 3.59315 20.25 5.25 20.25H18.75C20.4069 20.25 21.75 18.9069 21.75 17.25C21.75 15.5931 20.4069 14.25 18.75 14.25M2.25 11.25C2.25 9.59315 3.59315 8.25 5.25 8.25H18.75C20.4069 8.25 21.75 9.59315 21.75 11.25M2.25 11.25C2.25 10.2763 2.5658 9.32893 3.15 8.55L5.7375 5.1C6.37488 4.25016 7.37519 3.75 8.4375 3.75H15.5625C16.6248 3.75 17.6251 4.25016 18.2625 5.1L20.85 8.55C21.4342 9.32893 21.75 10.2763 21.75 11.25M21.75 11.25C21.75 12.9069 20.4069 14.25 18.75 14.25M18.75 17.25H18.7575V17.2575H18.75V17.25ZM18.75 11.25H18.7575V11.2575H18.75V11.25ZM15.75 17.25H15.7575V17.2575H15.75V17.25ZM15.75 11.25H15.7575V11.2575H15.75V11.25Z"/>
            </svg>
            <div class="server-label">cache-01</div>
        </div>
        <div class="floating-server-container">
            <svg class="floating-server w-14 h-14" fill="currentColor" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5.25 14.25H18.75M5.25 14.25C3.59315 14.25 2.25 12.9069 2.25 11.25M5.25 14.25C3.59315 14.25 2.25 15.5931 2.25 17.25C2.25 18.9069 3.59315 20.25 5.25 20.25H18.75C20.4069 20.25 21.75 18.9069 21.75 17.25C21.75 15.5931 20.4069 14.25 18.75 14.25M2.25 11.25C2.25 9.59315 3.59315 8.25 5.25 8.25H18.75C20.4069 8.25 21.75 9.59315 21.75 11.25M2.25 11.25C2.25 10.2763 2.5658 9.32893 3.15 8.55L5.7375 5.1C6.37488 4.25016 7.37519 3.75 8.4375 3.75H15.5625C16.6248 3.75 17.6251 4.25016 18.2625 5.1L20.85 8.55C21.4342 9.32893 21.75 10.2763 21.75 11.25M21.75 11.25C21.75 12.9069 20.4069 14.25 18.75 14.25M18.75 17.25H18.7575V17.2575H18.75V17.25ZM18.75 11.25H18.7575V11.2575H18.75V11.25ZM15.75 17.25H15.7575V17.2575H15.75V17.25ZM15.75 11.25H15.7575V11.2575H15.75V11.25Z"/>
            </svg>
            <div class="server-label">lb-01</div>
        </div>
        
        <!-- Network connections -->
        <svg class="absolute inset-0 w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none">
            <line class="network-line" x1="20" y1="30" x2="80" y2="40"/>
            <line class="network-line" x1="15" y1="70" x2="85" y2="60"/>
            <line class="network-line" x1="40" y1="20" x2="60" y2="80"/>
            <path class="data-flow" d="M10,50 Q50,20 90,50"/>
            <path class="data-flow" d="M10,30 Q50,80 90,30"/>
        </svg>
        
        <!-- Pulsing nodes -->
        <svg class="absolute inset-0 w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none">
            <circle class="node" cx="25" cy="25" r="2"/>
            <circle class="node" cx="75" cy="35" r="2"/>
            <circle class="node" cx="35" cy="75" r="2"/>
            <circle class="node" cx="85" cy="65" r="2"/>
            <circle class="node" cx="50" cy="50" r="1.5"/>
        </svg>
    </div>
    
    <div class="hero-content text-center">
        <div class="max-w-md">
            <h1 class="text-3xl sm:text-4xl lg:text-5xl font-bold text-primary">About Me</h1>
            <p class="py-4 sm:py-6 text-base-content text-sm sm:text-base">Passionate about building robust, scalable software systems.</p>
            <div class="flex justify-center gap-2">
                <a href="https://github.com/MonsieurBigBird" target="_blank" rel="noopener noreferrer" class="btn btn-ghost btn-circle">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                    </svg>
                </a>
                <a href="https://linkedin.com/in/matt-boisvert" target="_blank" rel="noopener noreferrer" class="btn btn-ghost btn-circle">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                    </svg>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Main Content Section with Photo and About -->
<div class="grid grid-cols-1 lg:grid-cols-2 gap-6 sm:gap-8 mb-8">
    <!-- Photo Column -->
    <div class="card bg-base-100 shadow-xl">
        <div class="card-body flex items-center justify-center">
            <div class="relative">
                <img src="/static/images/beach.jpg" alt="Matt at the beach" class="w-full h-68 object-cover object-top rounded-lg">
                <div class="absolute bottom-4 left-4 bg-black/50 text-white px-3 py-1 rounded-lg text-sm">
                    Santa Cruz, CA
                </div>
            </div>
        </div>
    </div>
    
    <!-- About My Work Column -->
    <div class="card bg-base-100 shadow-xl">
        <div class="card-body">
            <h2 class="card-title text-2xl font-bold text-primary mb-4">Building and maintaining large-scale software systems with a focus on performance, reliability, and user experience.</h2>
            
            <div class="space-y-4">
                <div class="career-section">
                    <p class="text-base-content leading-relaxed">
                        My background is in building developer tools and infrastructure for large-scale organizations, primarily in the semiconductor industry.
                        Chip development poses many challenges, especially as rapid innovation is required to push Moore's Law past its limits. EDA tool licenses are
                        expensive, workloads for simulating chip designs are computationally-demanding, and storage needs are constantly growing. Not to mention, manufacturing
                        a physical device is costly, requiring the coordination of massive codebases across distributed teams for years, and issues cannot be patched with an ephemeral software release!
                    </p>
                    <p class="text-base-content leading-relaxed mt-4">
                        Regardless of the particular domain, I want to dive deep into technical problems and provide creative solutions that make it easier for developers to ship quickly and effectively.
                    </p>
                    <p class="text-base-content leading-relaxed mt-4">
                        Currently, I'm a Senior Software Engineer at NVIDIA where I work on CI/CD platforms and build systems for engineers across the company.
                    </p>
                </div>
                
                <div class="card bg-base-200/50 border border-base-300 shadow-sm mb-4">
                    <div class="card-body p-6">
                        <h3 class="text-lg font-semibold text-secondary mb-3">My Passion</h3>
                        <ul class="space-y-2 text-base-content">
                            <li class="flex items-center">
                                <span class="text-primary mr-3 text-lg">•</span>
                                <span>Tackling problems to accelerate the product lifecycle</span>
                            </li>
                            <li class="flex items-center">
                                <span class="text-primary mr-3 text-lg">•</span>
                                <span>Scaling infrastructure to meet growing demands</span>
                            </li>
                            <li class="flex items-center">
                                <span class="text-primary mr-3 text-lg">•</span>
                                <span>Making developers love the tools at their disposal</span>
                            </li>
                        </ul>
                    </div>
                </div>
                
                <div class="infrastructure-areas">
                    <h3 class="text-lg font-semibold text-secondary mb-3">Infrastructure Focus</h3>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-4">
                        <div class="infrastructure-card build-systems">
                            <div class="card-front">
                                <h4 class="font-semibold text-primary text-sm sm:text-base">Build Systems</h4>
                                <p class="text-xs sm:text-sm text-gray-600">Scalable infrastructure for complex toolchains</p>
                            </div>
                            <div class="card-back" style="display: flex; align-items: center; justify-content: center;">
                                <img src="/static/icons/bazel.png" class="w-12 h-12 sm:w-16 sm:h-16 object-contain" alt="">
                            </div>
                        </div>
                        <div class="infrastructure-card ci-cd">
                            <div class="card-front">
                                <h4 class="font-semibold text-primary text-sm sm:text-base">CI/CD Pipelines</h4>
                                <p class="text-xs sm:text-sm text-gray-600">Robust automation for engineering workflows</p>
                            </div>
                            <div class="card-back" style="display: flex; align-items: center; justify-content: center; gap: 2px; flex-direction: row;">
                                <img src="/static/icons/jenkins.png" class="w-8 h-8 sm:w-12 sm:h-12 object-contain" alt="">
                                <img src="/static/icons/gitlab.png" class="w-8 h-8 sm:w-12 sm:h-12 object-contain" alt="">
                            </div>
                        </div>
                        <div class="infrastructure-card developer-productivity">
                            <div class="card-front">
                                <h4 class="font-semibold text-primary text-sm sm:text-base">Developer Productivity</h4>
                                <p class="text-xs sm:text-sm text-gray-600">Dashboards, CLI tools, and APIs that engineers love</p>
                            </div>
                            <div class="card-back" style="display: flex; align-items: center; justify-content: center; gap: 1px; flex-direction: row;">
                                <img src="/static/icons/opentelemetry.png" class="w-6 h-6 sm:w-10 sm:h-10 object-contain" alt="">
                                <img src="/static/icons/grafana.png" class="w-6 h-6 sm:w-10 sm:h-10 object-contain" alt="">
                                <img src="/static/icons/elasticsearch.jpg" class="w-6 h-6 sm:w-10 sm:h-10 object-contain" alt="">
                            </div>
                        </div>
                        <div class="infrastructure-card version-control">
                            <div class="card-front">
                                <h4 class="font-semibold text-primary text-sm sm:text-base">Version Control</h4>
                                <p class="text-xs sm:text-sm text-gray-600">Scalable workflow patterns for distributed teams</p>
                            </div>
                            <div class="card-back" style="display: flex; align-items: center; justify-content: center; gap: 2px; flex-direction: row;">
                                <img src="/static/icons/git.png" class="w-8 h-8 sm:w-12 sm:h-12 object-contain" alt="">
                                <img src="/static/icons/perforce.jpg" class="w-8 h-8 sm:w-12 sm:h-12 object-contain" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Steve Ballmer 3D Sphere Section -->
<div class="w-full mb-8">
    <div class="card bg-base-100 shadow-xl">
        <div class="card-body">
            <h2 class="card-title text-secondary mb-4">Developers, Developers, Developers!</h2>
            <p class="text-base-content text-sm mb-8">Building infrastructure that scales for your rapidly-scaling demands and developer needs is key for accelerating productivity. Or as Steve eloquently puts it...</p>
            
            <!-- 3D Sphere Container -->
            <div class="sphere-container">
                <div class="sphere" id="developers-sphere">
                    <!-- Original 6 faces -->
                    <div class="sphere-face sphere-front">
                        <img src="/static/images/developers.gif" alt="Steve Ballmer" class="sphere-texture">
                    </div>
                    <div class="sphere-face sphere-back">
                        <img src="/static/images/developers.gif" alt="Steve Ballmer" class="sphere-texture">
                    </div>
                    <div class="sphere-face sphere-right">
                        <img src="/static/images/developers.gif" alt="Steve Ballmer" class="sphere-texture">
                    </div>
                    <div class="sphere-face sphere-left">
                        <img src="/static/images/developers.gif" alt="Steve Ballmer" class="sphere-texture">
                    </div>
                    <div class="sphere-face sphere-top">
                        <img src="/static/images/developers.gif" alt="Steve Ballmer" class="sphere-texture">
                    </div>
                    <div class="sphere-face sphere-bottom">
                        <img src="/static/images/developers.gif" alt="Steve Ballmer" class="sphere-texture">
                    </div>
                </div>
            </div>
            
            <!-- Click hint bubble -->
            <div class="text-center mt-4">
                <span class="badge badge-primary badge-outline">Click the cube to watch the original</span>
            </div>
        </div>
    </div>
</div>
"""

# Helper function to serve image files as binary data
serveImageFile! : Str, Str => Result Response [ServerErr Str]
serveImageFile! = |filePath, mimeType|
    # Read the image file as binary data
    imageResult = File.read_bytes!(filePath)

    when imageResult is
        Ok(imageBytes) ->
            Ok(
                {
                    status: 200,
                    headers: [{name: "Content-Type", value: mimeType}],
                    body: imageBytes,
                },
            )
        Err(_) ->
            Ok(
                {
                    status: 404,
                    headers: [],
                    body: Str.to_utf8("Image not found"),
                },
            )
