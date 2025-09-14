module [
    htmxResponseHtml,
    infrastructureDemoHtml,
    k8sDemoHtml,
    pipelineDemoHtml,
    nodeStatusHtml,
]

# Api.roc
# API endpoints and HTMX responses

# HTMX response templates
htmxResponseHtml =
"""
<div class="alert alert-success shadow-lg">
    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
    </svg>
    <div>
        <h3 class="font-bold">HTMX Magic Working! ✨</h3>
        <div class="text-xs">This content was loaded dynamically using HTMX without a page refresh.</div>
    </div>
</div>
"""

infrastructureDemoHtml =
"""
<div class="card bg-base-100 shadow-xl">
    <div class="card-body">
        <h2 class="card-title text-primary">Infrastructure Dashboard</h2>
        <p class="text-base-content">Real-time infrastructure monitoring and orchestration visualization.</p>
        <div class="grid grid-cols-2 gap-4 mt-4">
            <div class="stat bg-base-200 rounded-lg p-4">
                <div class="stat-title">Active Pods</div>
                <div class="stat-value text-primary">24</div>
                <div class="stat-desc">↗︎ 12% from last hour</div>
            </div>
            <div class="stat bg-base-200 rounded-lg p-4">
                <div class="stat-title">CPU Usage</div>
                <div class="stat-value text-secondary">67%</div>
                <div class="stat-desc">↘︎ 8% from last hour</div>
            </div>
        </div>
        <div class="card-actions justify-end">
            <button class="btn btn-primary" hx-get="/api/k8s-demo" hx-target="#k8s-demo" hx-swap="innerHTML">
                View Cluster
            </button>
        </div>
    </div>
</div>
"""

k8sDemoHtml =
"""
<div class="card bg-base-100 shadow-xl">
    <div class="card-body">
        <h2 class="card-title text-primary">Kubernetes Cluster</h2>
        <p class="text-base-content">Live cluster visualization with pod scaling and service discovery.</p>
        <div class="mockup-window bg-base-300 p-4 mt-4">
            <div class="flex justify-center opacity-75">
                <code>kubectl get pods --all-namespaces</code>
            </div>
            <pre class="text-xs mt-2">
NAMESPACE     NAME                    READY   STATUS    RESTARTS   AGE
default       web-app-7d8f9           2/2     Running   0          2h
default       api-gateway-abc12       1/1     Running   0          1h
monitoring    prometheus-server       1/1     Running   0          4h
monitoring    grafana-dashboard       1/1     Running   0          4h
            </pre>
        </div>
        <div class="card-actions justify-end">
            <button class="btn btn-secondary" hx-get="/api/pipeline-demo" hx-target="#pipeline-demo" hx-swap="innerHTML">
                View Pipeline
            </button>
        </div>
    </div>
</div>
"""

pipelineDemoHtml =
"""
<div class="card bg-base-100 shadow-xl">
    <div class="card-body">
        <h2 class="card-title text-secondary">CI/CD Pipeline</h2>
        <p class="text-base-content">Deployment pipeline with automated testing and deployment stages.</p>
        <div class="space-y-2 mt-4">
            <div class="flex items-center space-x-2">
                <div class="w-3 h-3 bg-success rounded-full animate-pulse"></div>
                <span class="text-sm">Code Commit</span>
            </div>
            <div class="flex items-center space-x-2">
                <div class="w-3 h-3 bg-warning rounded-full animate-pulse"></div>
                <span class="text-sm">Build & Test</span>
            </div>
            <div class="flex items-center space-x-2">
                <div class="w-3 h-3 bg-info rounded-full animate-pulse"></div>
                <span class="text-sm">Deploy to Staging</span>
            </div>
            <div class="flex items-center space-x-2">
                <div class="w-3 h-3 bg-base-300 rounded-full"></div>
                <span class="text-sm text-base-content/50">Deploy to Production</span>
            </div>
        </div>
        <div class="card-actions justify-end">
            <button class="btn btn-primary" hx-get="/api/infrastructure-demo" hx-target="#infrastructure-demo" hx-swap="innerHTML">
                Back to Dashboard
            </button>
        </div>
    </div>
</div>
"""

nodeStatusHtml =
"""
<div class="w-16 h-16 bg-primary/20 rounded-lg border-2 border-primary/40 transition-all duration-1000 ease-in-out hover:scale-110 animate-pulse">
    <div class="text-xs text-center mt-1">Node 1</div>
    <div class="flex justify-center mt-1">
        <div class="w-2 h-2 bg-success rounded-full animate-ping"></div>
        <div class="w-2 h-2 bg-success rounded-full animate-ping ml-1" style="animation-delay: 0.5s"></div>
    </div>
</div>
"""
