module [
    homePageHtml!,
]

import Shared

homePageHtml! : {} => Str
homePageHtml! = |_| Shared.baseLayoutHtml!("Home - Matt Boisvert", "home", homeContentHtml)

homeContentHtml =
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
            <h1 class="text-3xl sm:text-4xl lg:text-5xl font-bold text-primary">Exploring engineering acceleration</h1>
            <p class="py-4 sm:py-6 text-base-content text-sm sm:text-base">Building robust, scalable platforms for developers</p>
        </div>
    </div>
</div>

<div class="mb-8">
    <div class="card bg-base-100 shadow-xl">
        <div class="card-body">
            <h2 class="card-title text-primary">Recent Posts</h2>
            <p class="text-base-content">Latest thoughts and experiments from my software engineering journey.</p>
            <div class="space-y-6">
                <div class="border-l-4 border-accent pl-6 py-4">
                    <h3 class="text-xl font-semibold mb-2">Post on the way</h3>
                    <p class="text-base-content/70 mb-4">Working on some exciting content about software engineering and infrastructure. Stay tuned for updates!</p>
                    <div class="flex items-center justify-between">
                        <span class="text-sm text-base-content/50">Coming soon</span>
                        <span class="text-sm text-base-content/50">—</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

            <!-- Infrastructure Visualization Section -->
            <div class="mt-12">
                <div class="card bg-base-100 shadow-xl">
                    <div class="card-body">
                        <h2 class="card-title text-primary">Infrastructure Lifecycle Sandbox</h2>
                        <p class="text-base-content font-medium text-secondary">From commit to production, with style</p>
                        <p class="text-base-content/70 text-sm mt-2">Every component in a system has a journey. This dashboard visualizes that journey as changes are made and different pieces interact.</p>
                        <p class="text-base-content/50 text-xs mt-1 italic">Note: This is a simple simulation that will evolve over time</p>
            
            <!-- System Visualization -->
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 mt-8">
                <!-- Cluster Visualization -->
                <div class="bg-base-200 rounded-lg p-4 sm:p-6">
                    <h3 class="font-semibold text-primary mb-4 sm:mb-6">Cluster Status</h3>
                    <div class="relative h-48 sm:h-64 bg-base-300 rounded-lg overflow-hidden">
                        <!-- Dynamic nodes with realistic scaling and health indicators -->
                        <!-- Web node - top left -->
                        <div class="cluster-node absolute top-3 sm:top-6 left-3 sm:left-6 w-16 h-16 sm:w-20 sm:h-20 bg-primary/20 rounded-lg border-2 border-primary/40 transition-all duration-2000 ease-in-out hover:scale-110 shadow-lg" id="web-node">
                            <div class="text-xs text-center mt-1 font-mono font-semibold">web-01</div>
                            <div class="flex justify-center mt-1 space-x-1" id="web-pods">
                                <div class="w-2 h-2 sm:w-3 sm:h-3 bg-success rounded-full data-pulse border border-success-content/30"></div>
                                <div class="w-2 h-2 sm:w-3 sm:h-3 bg-success rounded-full data-pulse border border-success-content/30" style="animation-delay: 0.2s;"></div>
                                <div class="w-2 h-2 sm:w-3 sm:h-3 bg-success rounded-full data-pulse border border-success-content/30" style="animation-delay: 0.4s;"></div>
                            </div>
                            <div class="text-xs text-center mt-1 text-success font-medium" id="web-health">Healthy</div>
                        </div>
                        
                        <!-- API node - top right -->
                        <div class="cluster-node absolute top-3 sm:top-6 right-3 sm:right-6 w-16 h-16 sm:w-20 sm:h-20 bg-secondary/20 rounded-lg border-2 border-secondary/40 transition-all duration-2000 ease-in-out hover:scale-110 shadow-lg" id="api-node">
                            <div class="text-xs text-center mt-1 font-mono font-semibold">api-01</div>
                            <div class="flex justify-center mt-1 space-x-1" id="api-pods">
                                <div class="w-2 h-2 sm:w-3 sm:h-3 bg-warning rounded-full data-pulse border border-warning-content/30"></div>
                                <div class="w-2 h-2 sm:w-3 sm:h-3 bg-warning rounded-full data-pulse border border-warning-content/30" style="animation-delay: 0.3s;"></div>
                            </div>
                            <div class="text-xs text-center mt-1 text-warning-content font-medium" id="api-health">Scaling</div>
                        </div>
                        
                        <!-- DB node - centered at bottom for proper triangle -->
                        <div class="cluster-node absolute bottom-3 sm:bottom-6 w-16 h-16 sm:w-20 sm:h-20 bg-accent/20 rounded-lg border-2 border-accent/40 transition-all duration-2000 ease-in-out hover:scale-110 shadow-lg" id="db-node" style="left: 50%; transform: translateX(-50%);">
                            <div class="text-xs text-center mt-1 font-mono font-semibold">db-01</div>
                            <div class="flex justify-center mt-1 space-x-1" id="db-pods">
                                <div class="w-2 h-2 sm:w-3 sm:h-3 bg-info rounded-full data-pulse border border-info-content/30"></div>
                            </div>
                            <div class="text-xs text-center mt-1 text-info font-medium" id="db-health">Stable</div>
                        </div>
                        
                        <!-- Connection lines connecting to box edges, not through the middle -->
                        <svg class="absolute inset-0 w-full h-full" viewBox="0 0 100 100" preserveAspectRatio="none">
                            <!-- Web to DB connection (from web node bottom to db node top) - responsive positioning -->
                            <line x1="15" y1="30" x2="50" y2="60" stroke="currentColor" stroke-width="0.5" opacity="0.4" class="connection-line"/>
                            <!-- API to DB connection (from api node bottom to db node top) - responsive positioning -->
                            <line x1="85" y1="30" x2="50" y2="60" stroke="currentColor" stroke-width="0.5" opacity="0.4" class="connection-line" style="animation-delay: 1s;"/>
                            <!-- Web to API connection (from web node right to api node left) - responsive positioning -->
                            <line x1="15" y1="15" x2="85" y2="15" stroke="currentColor" stroke-width="0.5" opacity="0.4" class="connection-line"/>
                        </svg>
                    </div>
                </div>
                
                <!-- Pipeline Visualization -->
                <div class="bg-base-200 rounded-lg p-4 sm:p-6">
                    <h3 class="font-semibold text-secondary mb-4 sm:mb-6">Deployment Status</h3>
                    <div class="space-y-3" id="pipeline-stages">
                        <!-- Pipeline stages -->
                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-success rounded-full flex items-center justify-center">
                                <svg class="w-4 h-4 text-success-content" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="flex-1">
                                <div class="text-sm font-medium">Code Commit</div>
                                <div class="text-xs text-success">Completed</div>
                            </div>
                        </div>
                        
                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-warning rounded-full flex items-center justify-center animate-pulse">
                                <svg class="w-4 h-4 text-warning-content" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="flex-1">
                                <div class="text-sm font-medium">Build & Test</div>
                                <div class="text-xs text-warning">In progress</div>
                            </div>
                        </div>
                        
                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-base-300 rounded-full flex items-center justify-center">
                                <svg class="w-4 h-4 text-base-content/50" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="flex-1">
                                <div class="text-sm font-medium text-base-content/50">Deploy to Staging</div>
                                <div class="text-xs text-base-content/50">Pending</div>
                            </div>
                        </div>
                        
                        <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 bg-base-300 rounded-full flex items-center justify-center">
                                <svg class="w-4 h-4 text-base-content/50" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                </svg>
                            </div>
                            <div class="flex-1">
                                <div class="text-sm font-medium text-base-content/50">Deploy to Production</div>
                                <div class="text-xs text-base-content/50">Pending</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Real-time Metrics with Dynamic Updates -->
            <div class="mt-6">
                <h3 class="font-semibold mb-4">Real-time Metrics</h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div class="stat bg-base-200 rounded-lg">
                        <div class="stat-figure text-primary animate-pulse">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                            </svg>
                        </div>
                        <div class="stat-title">CPU Usage</div>
                        <div class="stat-value text-primary animate-counter" data-target="67" id="cpu-usage">67%</div>
                        <div class="stat-desc" id="cpu-trend">↗︎ 12% from last hour</div>
                    </div>
                    
                    <div class="stat bg-base-200 rounded-lg">
                        <div class="stat-figure text-secondary animate-pulse">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 100 4m0-4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 100 4m0-4v2m0-6V4"/>
                            </svg>
                        </div>
                        <div class="stat-title">Memory</div>
                        <div class="stat-value text-secondary animate-counter" data-target="82" id="memory-usage">82%</div>
                        <div class="stat-desc" id="memory-trend">↘︎ 8% from last hour</div>
                    </div>
                    
                    <div class="stat bg-base-200 rounded-lg">
                        <div class="stat-figure text-accent animate-pulse">
                            <svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                            </svg>
                        </div>
                        <div class="stat-title">Network</div>
                        <div class="stat-value text-accent animate-counter" data-target="45" id="network-usage">45%</div>
                        <div class="stat-desc" id="network-trend">↗︎ 5% from last hour</div>
                    </div>
                </div>
            </div>
            
            <!-- Live Activity Feed with Dynamic Updates -->
            <div class="mt-6">
                <h3 class="font-semibold mb-3">Live Activity Feed</h3>
                <div class="bg-base-200 rounded-lg p-4 max-h-32 overflow-y-auto" id="activity-feed">
                    <div class="space-y-2 text-sm">
                        <div class="flex items-center space-x-2">
                            <div class="w-2 h-2 bg-success rounded-full animate-ping"></div>
                            <span class="font-mono">Pod web-app-7d8f9 scaled to 3 replicas</span>
                            <span class="text-xs text-base-content/50 animate-counter" data-target="0">just now</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-2 h-2 bg-info rounded-full animate-pulse"></div>
                            <span class="font-mono">New deployment v2.1.4 rolled out</span>
                            <span class="text-xs text-base-content/50 animate-counter" data-target="2">2m ago</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-2 h-2 bg-warning rounded-full animate-pulse"></div>
                            <span class="font-mono">High CPU usage detected on node-2</span>
                            <span class="text-xs text-base-content/50 animate-counter" data-target="5">5m ago</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-2 h-2 bg-success rounded-full animate-pulse"></div>
                            <span class="font-mono">Service discovery updated</span>
                            <span class="text-xs text-base-content/50 animate-counter" data-target="8">8m ago</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-2 h-2 bg-accent rounded-full animate-pulse"></div>
                            <span class="font-mono">Database connection pool optimized</span>
                            <span class="text-xs text-base-content/50 animate-counter" data-target="12">12m ago</span>
                        </div>
                    </div>
                </div>
            </div>
                    </div>
                </div>
            </div>
"""
