module [
    baseLayoutHtml!,
    navbarHtml!,
    footerHtml,
]

# Shared.roc
# Shared utilities and base layout

# Base layout HTML template
baseLayoutHtml! : Str, Str, Str => Str
baseLayoutHtml! = |title, activeNav, content|
    """
    <!DOCTYPE html>
    <html lang="en" data-theme="light">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title}</title>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.12.10/dist/full.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="/static/css/output.css">
        <link rel="stylesheet" href="/static/css/icons.css">
        <script src="https://unpkg.com/mermaid@10.9.1/dist/mermaid.min.js"></script>
        <script src="https://unpkg.com/htmx.org@1.9.10"></script>
        <style>
            /* Custom styles */
            .prose {
                max-width: none;
            }
            
            .prose h1, .prose h2, .prose h3, .prose h4, .prose h5, .prose h6 {
                color: #1e40af;
            }
            
            .prose a {
                color: #7c3aed;
                text-decoration: none;
            }
            
            .prose a:hover {
                color: #5b21b6;
                text-decoration: underline;
            }
            
            .prose code {
                background-color: #f3f4f6;
                padding: 0.125rem 0.25rem;
                border-radius: 0.25rem;
                font-size: 0.875em;
            }
            
            .prose pre {
                background-color: #1f2937;
                color: #f9fafb;
                padding: 1rem;
                border-radius: 0.5rem;
                overflow-x: auto;
            }
            
            .prose pre code {
                background-color: transparent;
                padding: 0;
                color: inherit;
            }
            
            /* 3D Sphere Styles */
            .sphere-container {
                perspective: 1000px;
                height: 300px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
                padding-bottom: 20px;
            }
            
            
            .sphere {
                position: relative;
                width: 250px;
                height: 250px;
                transform-style: preserve-3d;
                animation: rotateSphere 20s linear infinite;
                cursor: grab;
            }
            
            .sphere:active {
                cursor: grabbing;
            }
            
            .sphere-face {
                position: absolute;
                width: 100%;
                height: 100%;
                border: 2px solid rgba(59, 130, 246, 0.3);
                border-radius: 50%;
                overflow: hidden;
            }
            
            .sphere-texture {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                border-radius: 50%;
            }
            
            .sphere-front { transform: rotateY(0deg) translateZ(125px); }
            .sphere-back { transform: rotateY(180deg) translateZ(125px); }
            .sphere-right { transform: rotateY(90deg) translateZ(125px); }
            .sphere-left { transform: rotateY(-90deg) translateZ(125px); }
            .sphere-top { transform: rotateX(90deg) translateZ(125px); }
            .sphere-bottom { transform: rotateX(-90deg) translateZ(125px); }
            
            @keyframes rotateSphere {
                0% { transform: rotateY(0deg) rotateX(0deg); }
                100% { transform: rotateY(360deg) rotateX(360deg); }
            }
            
            /* Pipeline Styles */
            .pipeline-stage {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 1rem;
                border-radius: 0.5rem;
                transition: all 0.3s ease;
            }
            
            .pipeline-stage.completed {
                background-color: rgba(34, 197, 94, 0.1);
                border: 2px solid #22c55e;
            }
            
            .pipeline-stage.active {
                background-color: rgba(59, 130, 246, 0.1);
                border: 2px solid #3b82f6;
                animation: pulse 2s infinite;
            }
            
            .pipeline-stage.pending {
                background-color: rgba(156, 163, 175, 0.1);
                border: 2px solid #9ca3af;
            }
            
            .stage-icon {
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }
            
            .stage-label {
                font-size: 0.875rem;
                font-weight: 500;
            }
            
            .pipeline-arrow {
                font-size: 1.5rem;
                color: #6b7280;
                margin: 0 0.5rem;
            }
            
            /* Infrastructure Areas */
            .infrastructure-areas {
                margin-top: 16px;
            }
            
            .infrastructure-card {
                background: rgba(59, 130, 246, 0.05);
                border: 1px solid rgba(59, 130, 246, 0.1);
                border-radius: 8px;
                padding: 12px;
                transition: transform 0.4s ease-in-out, background 0.2s ease, border-color 0.2s ease;
                position: relative;
                transform-style: preserve-3d;
                min-height: 140px;
                height: auto;
                cursor: pointer;
                background-size: 40px 40px;
                background-position: center right 8px;
                background-repeat: no-repeat;
                background-blend-mode: overlay;
            }
            
            @media (min-width: 640px) {
                .infrastructure-card {
                    height: 120px;
                    min-height: 120px;
                }
            }
            
            .infrastructure-card:hover {
                background: rgba(59, 130, 246, 0.1);
                border-color: rgba(59, 130, 246, 0.2);
                transform: rotateY(180deg);
            }
            
            .infrastructure-card:not(:hover) {
                transform: rotateY(0deg);
            }
            
            .infrastructure-card .card-front,
            .infrastructure-card .card-back {
                position: absolute;
                width: 100%;
                height: 100%;
                backface-visibility: hidden;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
                padding-top: 12px;
                top: 0;
                left: 0;
            }
            
            .infrastructure-card .card-back {
                transform: rotateY(180deg);
                font-size: 24px;
            }
            
            /* Background icons for each infrastructure area */
            
            
            
            /* Company Experience - Interactive */
            .company-experience {
                margin-top: 16px;
            }
            
            .company-selector {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }
            
            .company-btn {
                padding: 8px 16px;
                border: 1px solid rgba(59, 130, 246, 0.2);
                background: rgba(59, 130, 246, 0.05);
                border-radius: 20px;
                font-size: 14px;
                font-weight: 500;
                color: #1e40af;
                cursor: pointer;
                transition: all 0.2s ease;
            }
            
            .company-btn:hover {
                background: rgba(59, 130, 246, 0.1);
                border-color: rgba(59, 130, 246, 0.3);
            }
            
            .company-btn.active {
                background: #1e40af;
                color: white;
                border-color: #1e40af;
            }
            
            .company-detail {
                background: linear-gradient(135deg, rgba(59, 130, 246, 0.05), rgba(147, 51, 234, 0.05));
                border: 1px solid rgba(59, 130, 246, 0.1);
                border-radius: 12px;
                padding: 20px;
                text-align: center;
                margin-top: 16px;
            }
            
            .company-logo {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                font-weight: bold;
                color: white;
                margin: 0 auto 12px;
            }
            
            .silvaco-logo {
                background: linear-gradient(135deg, #f59e0b, #f97316);
            }
            
            .google-logo {
                background: linear-gradient(135deg, #4285f4, #34a853);
            }
            
            .tenstorrent-logo {
                background: linear-gradient(135deg, #8b5cf6, #a855f7);
            }
            
            .nvidia-logo {
                background: linear-gradient(135deg, #76b900, #00d4aa);
            }
            
            .hpe-logo {
                background: linear-gradient(135deg, #009639, #00a651);
            }
            
            .company-name {
                font-size: 18px;
                font-weight: 600;
                color: #1e40af;
                margin: 0 0 6px 0;
            }
            
            .company-role {
                font-size: 13px;
                color: #7c3aed;
                font-weight: 500;
                margin: 0 0 10px 0;
            }
            
            .company-description {
                font-size: 14px;
                color: #6b7280;
                line-height: 1.4;
                margin: 0;
            }
            
            /* Infrastructure Animation Styles */
            .infrastructure-bg {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                overflow: hidden;
                pointer-events: none;
            }
            
            
            
            .network-line {
                stroke: rgba(59, 130, 246, 0.2);
                stroke-width: 0.5;
                animation: pulse 3s ease-in-out infinite;
            }
            
            .data-flow {
                fill: none;
                stroke: rgba(147, 51, 234, 0.3);
                stroke-width: 1;
                stroke-dasharray: 2, 2;
                animation: flow 4s linear infinite;
            }
            
            .node {
                fill: rgba(59, 130, 246, 0.6);
                animation: pulse 2s ease-in-out infinite;
            }
            
            @keyframes float {
                0%, 100% {
                    transform: translateY(0px) rotate(0deg);
                }
                50% {
                    transform: translateY(-40px) rotate(10deg);
                }
            }
            
            @keyframes flow {
                0% {
                    stroke-dashoffset: 0;
                }
                100% {
                    stroke-dashoffset: 20;
                }
            }
            
        </style>
    </head>
    <body class="bg-base-100">
        ${navbarHtml!(activeNav)}
        
        <main class="container mx-auto px-4 py-8">
            ${content}
        </main>
        
        ${footerHtml}
        
        <script>
            // Theme persistence with localStorage
            const themeController = document.querySelector('.theme-controller');
            
            // Load saved theme on page load
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme) {
                document.documentElement.setAttribute('data-theme', savedTheme);
                if (savedTheme === 'dark') {
                    themeController.checked = true;
                }
            }
            
            // Save theme preference when changed
            themeController.addEventListener('change', function() {
                const theme = this.checked ? 'dark' : 'light';
                document.documentElement.setAttribute('data-theme', theme);
                localStorage.setItem('theme', theme);
            });
            
            // 3D Sphere Interactive Controls with Physics
            document.addEventListener('DOMContentLoaded', function() {
                const sphere = document.querySelector('.sphere');
                if (sphere) {
                    let isDragging = false;
                    let startX, startY;
                    let currentRotationX = 0;
                    let currentRotationY = 0;
                    let velocityX = 0;
                    let velocityY = 0;
                    let lastTime = 0;
                    let lastMouseX = 0;
                    let lastMouseY = 0;
                    let animationId = null;
                    
                    // Physics constants
                    const friction = 0.95;
                    const maxVelocity = 20;
                    
                    function updateRotation() {
                        if (!isDragging) {
                            // Apply friction when not dragging
                            velocityX *= friction;
                            velocityY *= friction;
                            
                            // Stop very small velocities
                            if (Math.abs(velocityX) < 0.1) velocityX = 0;
                            if (Math.abs(velocityY) < 0.1) velocityY = 0;
                            
                            // Update rotation
                            currentRotationY += velocityX;
                            currentRotationX += velocityY;
                            
                            // Apply rotation to sphere
                            sphere.style.transform = "rotateY(" + currentRotationY + "deg) rotateX(" + currentRotationX + "deg)";
                            
                            // Continue animation if there's still velocity
                            if (Math.abs(velocityX) > 0.1 || Math.abs(velocityY) > 0.1) {
                                animationId = requestAnimationFrame(updateRotation);
                            }
                        }
                    }
                    
                    function startDrag(e) {
                        isDragging = true;
                        startX = e.clientX || e.touches[0].clientX;
                        startY = e.clientY || e.touches[0].clientY;
                        lastMouseX = startX;
                        lastMouseY = startY;
                        lastTime = Date.now();
                        
                        if (animationId) {
                            cancelAnimationFrame(animationId);
                            animationId = null;
                        }
                    }
                    
                    function drag(e) {
                        if (!isDragging) return;
                        
                        const currentX = e.clientX || e.touches[0].clientX;
                        const currentY = e.clientY || e.touches[0].clientY;
                        const currentTime = Date.now();
                        
                        const deltaX = currentX - lastMouseX;
                        const deltaY = currentY - lastMouseY;
                        const deltaTime = currentTime - lastTime;
                        
                        if (deltaTime > 0) {
                            velocityX = (deltaX / deltaTime) * 0.8;
                            velocityY = (deltaY / deltaTime) * 0.8;
                            
                            // Clamp velocity
                            velocityX = Math.max(-maxVelocity, Math.min(maxVelocity, velocityX));
                            velocityY = Math.max(-maxVelocity, Math.min(maxVelocity, velocityY));
                        }
                        
                        currentRotationY += deltaX * 0.8;
                        currentRotationX += deltaY * 0.8;
                        
                        sphere.style.transform = "rotateY(" + currentRotationY + "deg) rotateX(" + currentRotationX + "deg)";
                        
                        lastMouseX = currentX;
                        lastMouseY = currentY;
                        lastTime = currentTime;
                    }
                    
                    function endDrag() {
                        isDragging = false;
                        if (Math.abs(velocityX) > 0.1 || Math.abs(velocityY) > 0.1) {
                            animationId = requestAnimationFrame(updateRotation);
                        }
                    }
                    
                    // Mouse events
                    sphere.addEventListener('mousedown', startDrag);
                    document.addEventListener('mousemove', drag);
                    document.addEventListener('mouseup', endDrag);
                    
                    // Touch events
                    sphere.addEventListener('touchstart', startDrag, { passive: false });
                    document.addEventListener('touchmove', drag, { passive: false });
                    document.addEventListener('touchend', endDrag);
                    
                    // Click handler to open YouTube video
                    sphere.addEventListener('click', function(e) {
                        // Only open link if not dragging
                        if (!isDragging) {
                            window.open('https://www.youtube.com/watch?v=Vhh_GeBPOhs', '_blank', 'noopener,noreferrer');
                        }
                    });
                    
                    // Start the animation loop
                    updateRotation();
                }
                
                // Company Selector Interactive
                const companyData = {
                    nvidia: {
                        logo: 'N',
                        name: 'NVIDIA',
                        title: 'Senior Software Engineer',
                        role: 'CI/CD & Build Systems',
                        description: 'Currently building CI/CD and build systems for the full development spectrum, from early RTL to pre-tapeout validation.'
                    },
                    tenstorrent: {
                        logo: 'T',
                        name: 'Tenstorrent',
                        title: 'Software Engineer',
                        role: 'RISC-V DV Infrastructure',
                        description: 'Built verification infrastructure for RISC-V development, designing systems to handle the complexity of modern processor verification.'
                    },
                    google: {
                        logo: 'G',
                        name: 'Google',
                        title: 'Software Engineer Intern',
                        role: 'Edge TPU Infrastructure',
                        description: 'Worked on Edge TPU infrastructure, focusing on architectural modeling and performance analysis for massive computational workloads.'
                    }
                };
                
                function updateCompanyDetail(company) {
                    const detail = document.getElementById('company-detail');
                    if (detail) {
                        const data = companyData[company];
                        detail.innerHTML = 
                            '<div class="company-logo ' + company + '-logo">' + data.logo + '</div>' +
                            '<h4 class="company-name">' + data.name + '</h4>' +
                            '<p class="company-role">' + data.title + '</p>' +
                            '<p class="company-description">' + data.role + ' - ' + data.description + '</p>';
                    }
                }
                
                // Add click handlers to company buttons
                document.querySelectorAll('.company-btn').forEach(btn => {
                    btn.addEventListener('click', function() {
                        // Remove active class from all buttons
                        document.querySelectorAll('.company-btn').forEach(b => b.classList.remove('active'));
                        // Add active class to clicked button
                        this.classList.add('active');
                        // Update company detail
                        updateCompanyDetail(this.dataset.company);
                    });
                });
                
                // Initialize Mermaid
                mermaid.initialize({ startOnLoad: true });
                
                // Dynamic system overview animations
                console.log('Dynamic content JavaScript loaded');
                
                // Animate counters
                const counters = document.querySelectorAll('.animate-counter');
                console.log('Found counters:', counters.length);
                counters.forEach(counter => {
                    const target = parseInt(counter.getAttribute('data-target'));
                    let current = target * 0.8; // Start at 80% of target
                    const increment = (target - current) / 60; // 60 steps
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= target) {
                            current = target;
                            clearInterval(timer);
                        }
                        counter.textContent = Math.floor(current) + (counter.textContent.includes('%') ? '%' : 'm ago');
                    }, 100); // Slower animation
                });
                
                // Initialize metrics with random starting values
                function initializeMetrics() {
                    const cpuUsage = document.getElementById('cpu-usage');
                    const memoryUsage = document.getElementById('memory-usage');
                    const networkUsage = document.getElementById('network-usage');
                    const cpuTrend = document.getElementById('cpu-trend');
                    const memoryTrend = document.getElementById('memory-trend');
                    const networkTrend = document.getElementById('network-trend');
                    
                    if (cpuUsage) {
                        const cpuValue = Math.floor(Math.random() * 40) + 30; // 30-70%
                        cpuUsage.textContent = cpuValue + '%';
                        cpuUsage.setAttribute('data-target', cpuValue);
                        const trend = Math.random() > 0.5 ? '↗︎' : '↘︎';
                        const change = Math.floor(Math.random() * 15) + 1;
                        cpuTrend.textContent = trend + ' ' + change + '% from last hour';
                    }
                    
                    if (memoryUsage) {
                        const memoryValue = Math.floor(Math.random() * 30) + 50; // 50-80%
                        memoryUsage.textContent = memoryValue + '%';
                        memoryUsage.setAttribute('data-target', memoryValue);
                        const trend = Math.random() > 0.5 ? '↗︎' : '↘︎';
                        const change = Math.floor(Math.random() * 8) + 1;
                        memoryTrend.textContent = trend + ' ' + change + '% from last hour';
                    }
                    
                    if (networkUsage) {
                        const networkValue = Math.floor(Math.random() * 30) + 20; // 20-50%
                        networkUsage.textContent = networkValue + '%';
                        networkUsage.setAttribute('data-target', networkValue);
                        const trend = Math.random() > 0.5 ? '↗︎' : '↘︎';
                        const change = Math.floor(Math.random() * 10) + 1;
                        networkTrend.textContent = trend + ' ' + change + '% from last hour';
                    }
                }
                
                // Random metric fluctuations
                function updateMetrics() {
                    const cpuUsage = document.getElementById('cpu-usage');
                    const memoryUsage = document.getElementById('memory-usage');
                    const networkUsage = document.getElementById('network-usage');
                    const cpuTrend = document.getElementById('cpu-trend');
                    const memoryTrend = document.getElementById('memory-trend');
                    const networkTrend = document.getElementById('network-trend');
                    
                    if (cpuUsage) {
                        const currentValue = parseInt(cpuUsage.textContent);
                        const cpuValue = Math.max(20, Math.min(95, currentValue + (Math.random() - 0.5) * 10));
                        cpuUsage.textContent = Math.round(cpuValue) + '%';
                        cpuUsage.setAttribute('data-target', Math.round(cpuValue));
                        const trend = Math.random() > 0.5 ? '↗︎' : '↘︎';
                        const change = Math.floor(Math.random() * 15) + 1;
                        cpuTrend.textContent = trend + ' ' + change + '% from last hour';
                    }
                    
                    if (memoryUsage) {
                        const currentValue = parseInt(memoryUsage.textContent);
                        const memoryValue = Math.max(30, Math.min(90, currentValue + (Math.random() - 0.5) * 3));
                        memoryUsage.textContent = Math.round(memoryValue) + '%';
                        memoryUsage.setAttribute('data-target', Math.round(memoryValue));
                        const trend = Math.random() > 0.5 ? '↗︎' : '↘︎';
                        const change = Math.floor(Math.random() * 6) + 1;
                        memoryTrend.textContent = trend + ' ' + change + '% from last hour';
                    }
                    
                    if (networkUsage) {
                        const currentValue = parseInt(networkUsage.textContent);
                        const networkValue = Math.max(10, Math.min(80, currentValue + (Math.random() - 0.5) * 6));
                        networkUsage.textContent = Math.round(networkValue) + '%';
                        networkUsage.setAttribute('data-target', Math.round(networkValue));
                        const trend = Math.random() > 0.5 ? '↗︎' : '↘︎';
                        const change = Math.floor(Math.random() * 10) + 1;
                        networkTrend.textContent = trend + ' ' + change + '% from last hour';
                    }
                }
                
                // Initialize metrics with stable starting values
                initializeMetrics();
                
                // Wait 5 seconds before starting metric updates to avoid jarring initial changes
                setTimeout(() => {
                    // Update metrics every 8-12 seconds
                    setInterval(updateMetrics, 8000 + Math.random() * 4000);
                }, 5000);
                
                // Add new activity feed entries
                const activityFeed = document.getElementById('activity-feed');
                let deploymentVersion = 2.1;
                const activities = [
                    { icon: 'success', text: 'Load balancer health check passed', time: 0 },
                    { icon: 'info', text: 'Cache warming completed', time: 1 },
                    { icon: 'warning', text: 'Memory usage spike detected', time: 3 },
                    { icon: 'accent', text: 'Auto-scaling triggered', time: 4 },
                    { icon: 'success', text: 'SSL certificate renewed', time: 6 },
                    { icon: 'info', text: 'Database backup completed', time: 7 },
                    { icon: 'warning', text: 'Network latency increased', time: 9 },
                    { icon: 'success', text: 'Service mesh updated', time: 11 }
                ];
                
                // Add deployment activities
                function addDeploymentActivity() {
                    deploymentVersion += 0.1;
                    const versionStr = deploymentVersion.toFixed(1);
                    const deploymentActivities = [
                        { icon: 'info', text: 'New deployment v' + versionStr + ' rolled out', time: 0 },
                        { icon: 'success', text: 'Version v' + versionStr + ' deployed to production', time: 1 },
                        { icon: 'accent', text: 'Feature release v' + versionStr + ' completed', time: 2 }
                    ];
                    activities.push(...deploymentActivities);
                }
                
                function addActivityEntry() {
                    if (activityFeed) {
                        const activity = activities[Math.floor(Math.random() * activities.length)];
                        const entry = document.createElement('div');
                        entry.className = 'flex items-center space-x-2 animate-slide-in-right';
                        entry.innerHTML = '<div class="w-2 h-2 bg-' + activity.icon + ' rounded-full animate-pulse"></div><span class="font-mono">' + activity.text + '</span><span class="text-xs text-base-content/50">' + activity.time + 'm ago</span>';
                        activityFeed.querySelector('div').insertBefore(entry, activityFeed.querySelector('div').firstChild);
                        
                        // Remove oldest entries if too many
                        const entries = activityFeed.querySelectorAll('div > div');
                        if (entries.length > 8) {
                            entries[entries.length - 1].remove();
                        }
                    }
                }
                
                // Add new activity every 10-15 seconds
                setInterval(addActivityEntry, 10000 + Math.random() * 5000);
                
                // Interactive pipeline progression with cycling
                const pipelineStages = document.querySelectorAll('#pipeline-stages > div');
                console.log('Found pipeline stages:', pipelineStages.length);
                let currentStage = 0; // Start at stage 0 (Code Commit)
                let versionNumber = 2.1; // Starting version
                
                function resetPipeline() {
                    // Reset all stages to pending
                    pipelineStages.forEach((stage, index) => {
                        const icon = stage.querySelector('div:first-child');
                        const statusText = stage.querySelector('.text-xs');
                        const stageText = stage.querySelector('.text-sm');
                        
                        if (index === 0) {
                            // First stage (Code Commit) - completed
                            icon.className = 'w-8 h-8 bg-success rounded-full flex items-center justify-center';
                            icon.innerHTML = `
                                <svg class="w-4 h-4 text-success-content" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                </svg>
                            `;
                            // Update version text first
                            const versionStr = versionNumber.toFixed(1);
                            statusText.textContent = 'v' + versionStr + ' deployed';
                            statusText.className = 'text-xs text-success';
                            stageText.className = 'text-sm font-medium';
                            
                        } else {
                            // Other stages - pending
                            icon.className = 'w-8 h-8 bg-base-300 rounded-full flex items-center justify-center';
                            icon.innerHTML = `
                                <svg class="w-4 h-4 text-base-content/50" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                </svg>
                            `;
                            statusText.textContent = 'Pending';
                            statusText.className = 'text-xs text-base-content/50';
                            stageText.className = 'text-sm font-medium text-base-content/50';
                            
                        }
                    });
                    
                    // Increment version number for next cycle
                    versionNumber += 0.1;
                    currentStage = 0; // Reset to stage 0
                }
                
                function advancePipeline() {
                    console.log('advancePipeline called, currentStage:', currentStage, 'total stages:', pipelineStages.length);
                    if (currentStage < pipelineStages.length) {
                        const stage = pipelineStages[currentStage];
                        const icon = stage.querySelector('div:first-child');
                        const statusText = stage.querySelector('.text-xs');
                        
                        // Update icon to success
                        icon.className = 'w-8 h-8 bg-success rounded-full flex items-center justify-center animate-bounce-in';
                        icon.innerHTML = `
                            <svg class="w-4 h-4 text-success-content" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                            </svg>
                        `;
                        
                        // Update status text (detail text below bubble)
                        statusText.textContent = 'Completed';
                        statusText.className = 'text-xs text-success';
                        
                        // Update stage text
                        const stageText = stage.querySelector('.text-sm');
                        stageText.className = 'text-sm font-medium';
                        
                        
                        currentStage++;
                        
                        // If there are more stages, start the next one
                        if (currentStage < pipelineStages.length) {
                            const nextStage = pipelineStages[currentStage];
                            const nextIcon = nextStage.querySelector('div:first-child');
                            const nextStatusText = nextStage.querySelector('.text-xs');
                            
                            // Make next stage active
                            nextIcon.className = 'w-8 h-8 bg-warning rounded-full flex items-center justify-center animate-pulse animate-bounce-in';
                            nextStatusText.textContent = 'In progress';
                            nextStatusText.className = 'text-xs text-warning';
                            
                            const nextStageText = nextStage.querySelector('.text-sm');
                            nextStageText.className = 'text-sm font-medium';
                            
                        } else {
                            // All stages complete - reset for next deployment
                            addDeploymentActivity(); // Add deployment activities to feed
                            setTimeout(() => {
                                resetPipeline();
                            }, 2000); // Wait 2 seconds before resetting
                        }
                    }
                }
                
                // Add click handler to pipeline container
                const pipelineContainer = document.getElementById('pipeline-stages');
                console.log('Pipeline container found:', !!pipelineContainer);
                if (pipelineContainer) {
                    pipelineContainer.addEventListener('click', advancePipeline);
                    pipelineContainer.style.cursor = 'pointer';
                    pipelineContainer.title = 'Click to advance pipeline stage';
                }
                
                // Auto-advance pipeline every 8-12 seconds
                setInterval(advancePipeline, 8000 + Math.random() * 4000);
                
                // Dynamic cluster status updates
                function updateClusterStatus() {
                    console.log('updateClusterStatus called');
                    const nodes = [
                        { id: 'web', name: 'web-01', healthStates: ['Healthy', 'Degraded', 'Scaling'], podCounts: [2, 3, 4, 5] },
                        { id: 'api', name: 'api-01', healthStates: ['Healthy', 'Degraded', 'Scaling'], podCounts: [1, 2, 3, 4] },
                        { id: 'db', name: 'db-01', healthStates: ['Stable', 'Healthy', 'Backup'], podCounts: [1, 2] }
                    ];
                    
                    nodes.forEach(node => {
                        const healthElement = document.getElementById(node.id + '-health');
                        const podCountElement = document.getElementById(node.id + '-pod-count');
                        const podsElement = document.getElementById(node.id + '-pods');
                        const nodeElement = document.getElementById(node.id + '-node');
                        
                        console.log("Node " + node.id + ":", {
                            healthElement: !!healthElement,
                            podsElement: !!podsElement,
                            nodeElement: !!nodeElement
                        });
                        
                        if (healthElement && podsElement && nodeElement) {
                            // Randomly change health status
                            const newHealth = node.healthStates[Math.floor(Math.random() * node.healthStates.length)];
                            const newPodCount = node.podCounts[Math.floor(Math.random() * node.podCounts.length)];
                            
                            console.log("Updating " + node.id + " to " + newHealth);
                            
                            // Update health status
                            healthElement.textContent = newHealth;
                            
                            // Update pod count (removed from display)
                            
                            // Update pod indicators
                            podsElement.innerHTML = '';
                            for (let i = 0; i < newPodCount; i++) {
                                const pod = document.createElement('div');
                                pod.className = 'w-3 h-3 rounded-full animate-pulse';
                                pod.style.animationDelay = (i * 0.2) + 's';
                                
                                // Color based on health
                                if (newHealth === 'Healthy' || newHealth === 'Stable') {
                                    pod.classList.add('bg-success', 'border', 'border-success-content/30');
                                } else if (newHealth === 'Scaling') {
                                    pod.classList.add('bg-warning', 'border', 'border-warning-content/30');
                                } else if (newHealth === 'Degraded' || newHealth === 'Restarting') {
                                    pod.classList.add('bg-error', 'border', 'border-error-content/30');
                                } else {
                                    pod.classList.add('bg-info', 'border', 'border-info-content/30');
                                }
                                
                                podsElement.appendChild(pod);
                            }
                            
                            // Update text color based on health
                            if (newHealth === 'Scaling') {
                                healthElement.className = 'text-xs text-center mt-1 text-black font-medium';
                            } else if (newHealth === 'Healthy' || newHealth === 'Stable') {
                                healthElement.className = 'text-xs text-center mt-1 text-success font-medium';
                            } else if (newHealth === 'Degraded' || newHealth === 'Restarting') {
                                healthElement.className = 'text-xs text-center mt-1 text-error font-medium';
                            } else {
                                healthElement.className = 'text-xs text-center mt-1 text-info font-medium';
                            }
                            
                            // Update node border color based on health
                            if (newHealth === 'Healthy' || newHealth === 'Stable') {
                                nodeElement.className = nodeElement.className.replace('border-primary/40', 'border-success/40').replace('border-secondary/40', 'border-success/40').replace('border-accent/40', 'border-success/40');
                            } else if (newHealth === 'Scaling') {
                                nodeElement.className = nodeElement.className.replace('border-primary/40', 'border-warning/40').replace('border-secondary/40', 'border-warning/40').replace('border-accent/40', 'border-warning/40');
                            } else if (newHealth === 'Degraded' || newHealth === 'Restarting') {
                                nodeElement.className = nodeElement.className.replace('border-primary/40', 'border-error/40').replace('border-secondary/40', 'border-error/40').replace('border-accent/40', 'border-error/40');
                            }
                        }
                    });
                }
                
                // Test the function immediately
                setTimeout(updateClusterStatus, 2000);
                
                // Update cluster status every 15-25 seconds
                setInterval(updateClusterStatus, 15000 + Math.random() * 10000);
            });
        </script>
    </body>
    </html>
    """

# Navigation component
navbarHtml! : Str => Str
navbarHtml! = |activeNav|
    homeActive = if activeNav == "home" then "active" else ""
    aboutActive = if activeNav == "about" then "active" else ""
    blogActive = if activeNav == "blog" then "active" else ""
    
    """
    <div class="navbar bg-base-200 shadow-lg">
        <div class="navbar-start">
            <a href="/" class="btn btn-ghost text-sm sm:text-lg lg:text-xl font-mono">
                <svg class="w-4 h-4 sm:w-5 sm:h-5 lg:w-6 lg:h-6 inline mr-1 sm:mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M5.25 14.25H18.75M5.25 14.25C3.59315 14.25 2.25 12.9069 2.25 11.25M5.25 14.25C3.59315 14.25 2.25 15.5931 2.25 17.25C2.25 18.9069 3.59315 20.25 5.25 20.25H18.75C20.4069 20.25 21.75 18.9069 21.75 17.25C21.75 15.5931 20.4069 14.25 18.75 14.25M2.25 11.25C2.25 9.59315 3.59315 8.25 5.25 8.25H18.75C20.4069 8.25 21.75 9.59315 21.75 11.25M2.25 11.25C2.25 10.2763 2.5658 9.32893 3.15 8.55L5.7375 5.1C6.37488 4.25016 7.37519 3.75 8.4375 3.75H15.5625C16.6248 3.75 17.6251 4.25016 18.2625 5.1L20.85 8.55C21.4342 9.32893 21.75 10.2763 21.75 11.25M21.75 11.25C21.75 12.9069 20.4069 14.25 18.75 14.25M18.75 17.25H18.7575V17.2575H18.75V17.25ZM18.75 11.25H18.7575V11.2575H18.75V11.25ZM15.75 17.25H15.7575V17.2575H15.75V17.25ZM15.75 11.25H15.7575V11.2575H15.75V11.25Z"/>
                </svg>
                <span class="hidden lg:inline">> mboisvert</span>
                <span class="hidden sm:inline lg:hidden">mboisvert</span>
                <span class="sm:hidden">mbois</span>
            </a>
        </div>
        <div class="navbar-center">
            <ul class="menu menu-horizontal px-1">
                <li><a href="/" class="${homeActive}">Home</a></li>
                <li><a href="/about" class="${aboutActive}">About</a></li>
                <li><a href="/blog" class="${blogActive}">Blog</a></li>
            </ul>
        </div>
        <div class="navbar-end">
            <label class="swap swap-rotate">
                <input type="checkbox" class="theme-controller" value="dark"/>
                <svg class="swap-off fill-current w-5 h-5 sm:w-6 sm:h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 2.25a.75.75 0 0 1 .75.75v2.25a.75.75 0 0 1-1.5 0V3a.75.75 0 0 1 .75-.75ZM7.5 12a4.5 4.5 0 1 1 9 0 4.5 4.5 0 0 1-9 0ZM18.894 6.166a.75.75 0 0 0-1.06-1.06l-1.591 1.59a.75.75 0 1 0 1.06 1.061l1.591-1.59ZM21.75 12a.75.75 0 0 1-.75.75h-2.25a.75.75 0 0 1 0-1.5H21a.75.75 0 0 1 .75.75ZM17.834 18.894a.75.75 0 0 0 1.06-1.06l-1.59-1.591a.75.75 0 1 0-1.061 1.06l1.59 1.591ZM12 18a.75.75 0 0 1 .75.75V21a.75.75 0 0 1-1.5 0v-2.25A.75.75 0 0 1 12 18ZM7.758 17.303a.75.75 0 0 0-1.061-1.06l-1.591 1.59a.75.75 0 0 0 1.06 1.061l1.591-1.59ZM6 12a.75.75 0 0 1-.75.75H3a.75.75 0 0 1 0-1.5h2.25A.75.75 0 0 1 6 12ZM6.697 7.757a.75.75 0 0 0 1.06-1.06l-1.59-1.591a.75.75 0 0 0-1.061 1.06l1.59 1.591Z"/></svg>
                <svg class="swap-on fill-current w-5 h-5 sm:w-6 sm:h-6" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path fill-rule="evenodd" d="M9.528 1.718a.75.75 0 0 1 .162.819A8.97 8.97 0 0 0 9 6a9 9 0 0 0 9 9 8.97 8.97 0 0 0 3.463-.69.75.75 0 0 1 .981.98 10.503 10.503 0 0 1-9.694 6.46c-5.799 0-10.5-4.7-10.5-10.5 0-4.368 2.667-8.112 6.46-9.694a.75.75 0 0 1 .818.162Z" clip-rule="evenodd"/></svg>
            </label>
        </div>
    </div>
    """

# Footer component
footerHtml =
"""
<footer class="footer footer-center p-4 bg-base-200 text-base-content">
    <aside>
        <p>© 2025 Matt Boisvert. Built with <a href="https://www.roc-lang.org/" class="link link-primary">Roc</a>, <a href="https://htmx.org/" class="link link-secondary">HTMX</a>, and <a href="https://daisyui.com/" class="link link-accent">DaisyUI</a>.</p>
        <div class="flex justify-center gap-2 mt-2">
            <a href="https://github.com/MonsieurBigBird" target="_blank" rel="noopener noreferrer" class="btn btn-ghost btn-sm">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                </svg>
            </a>
            <a href="https://linkedin.com/in/matt-boisvert" target="_blank" rel="noopener noreferrer" class="btn btn-ghost btn-sm">
                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
                </svg>
            </a>
        </div>
    </aside>
</footer>
"""