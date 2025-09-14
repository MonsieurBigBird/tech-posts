# Matt Boisvert's Tech Blog

A modern, server-side rendered blog built with [Roc](https://roc-lang.org), [HTMX](https://htmx.org), and [Tailwind CSS](https://tailwindcss.com). This blog explores software engineering, infrastructure, and the future of technology.

## 🚀 Features

- **Server-Side Rendering** with Roc
- **Dynamic Interactions** with HTMX
- **Modern Styling** with Tailwind CSS (DaisyUI)

## 🛠️ Tech Stack

- **Backend**: [Roc](https://roc-lang.org) - Functional programming language
- **HTTP Server**: [basic-webserver](https://github.com/roc-lang/basic-webserver) platform
- **Frontend**: HTMX for dynamic interactions
- **Styling**: Tailwind CSS with DaisyUI components
- **Content**: HTML embedded in Roc modules
- **Deployment**: Fly.io with Docker

## 📦 Prerequisites

- [Roc](https://roc-lang.org/install) (latest alpha release)
- [Node.js](https://nodejs.org/) (for Tailwind CSS)

## 🚀 Getting Started

### 1. Install Dependencies

```bash
# Install Node.js dependencies
npm install

# Build Tailwind CSS
npm run build:css
```

### 2. Start the Development Server

```bash
# Start the Roc HTTP server
npm run dev
```

The server will be available at [http://localhost:8000](http://localhost:8000)

### 3. Development Workflow

```bash
# Build CSS (run when you modify Tailwind classes)
npm run build:css

# Check Roc syntax (run when you modify src)
roc check src/main.roc

# Start development server
npm run dev
```

## 📁 Project Structure

```
tech-posts/
├── src/
│   ├── main.roc                    # Main application entry point
│   ├── Home.roc                    # Home page content
│   ├── About.roc                   # About page content
│   ├── Blog.roc                    # Blog listing page
│   ├── Shared.roc                  # Shared components and layout
│   ├── Api.roc                     # HTMX API endpoints
│   ├── Files.roc                   # Static file serving
│   ├── NotFound.roc                # 404 page
│   └── Posts/
│       ├── Post.roc                # Blog post template
│       └── TaxonomizeYourInfrastructure.roc  # Blog post content
├── static/
│   ├── css/
│   │   ├── tailwind.css            # Tailwind input
│   │   ├── output.css              # Compiled CSS
│   │   └── icons.css               # Custom icon styles
│   ├── js/                         # Client-side libraries (HTMX, Alpine, Mermaid)
│   ├── images/                     # Static images
│   └── icons/                      # Technology icons
├── package.json                    # Node.js dependencies
├── tailwind.config.js              # Tailwind configuration
├── Dockerfile                      # Container configuration
└── fly.toml                        # Fly.io deployment config
```

## 🙏 Acknowledgments

- [Roc Language](https://roc-lang.org) for the functional programming foundation
- [HTMX](https://htmx.org) for dynamic web interactions
- [Tailwind CSS](https://tailwindcss.com) for utility-first styling
- [DaisyUI](https://daisyui.com) for beautiful component library
- [Cursor AI](https://cursor.sh) for development assistance and pair programming

## 🤖 AI Development Transparency

This project uses AI assistance (primarily Cursor) for development. I appreciate [Ghostty's AI disclosure policy](https://github.com/ghostty-org/ghostty/pull/8289) and want to be transparent about AI usage for this project.

**AI Usage Disclosure:**
- Recent commits include `Co-Authored-By: Cursor <cursor@cursor.sh>` in commit messages
- Older commits may not include this disclosure but should have
- All AI-generated code is reviewed, understood, and modified as needed
- The goal is to maintain code quality while being transparent about the development process


## 🚀 Deployment

This blog is deployed on [Fly.io](https://fly.io) using Docker. The site is available at [mattboisvert.net](https://mattboisvert.net).
