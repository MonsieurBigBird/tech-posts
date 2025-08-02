# Roc SSR Blog Framework

A modern, server-side rendered blog framework built with [Roc](https://roc-lang.org), [HTMX](https://htmx.org), [Alpine.js](https://alpinejs.dev), and [Tailwind CSS](https://tailwindcss.com).

## 🚀 Features

- **Server-Side Rendering** with Roc
- **Dynamic Interactions** with HTMX
- **Client-Side Reactivity** with Alpine.js
- **Modern Styling** with Tailwind CSS
- **Diagram Support** with Mermaid.js
- **Markdown Content** processing
- **SQLite Database** for content management

## 🛠️ Tech Stack

- **Backend**: [Roc](https://roc-lang.org) - Functional programming language
- **HTTP Server**: [basic-webserver](https://github.com/roc-lang/basic-webserver) platform
- **Frontend**: HTMX for dynamic interactions
- **Styling**: Tailwind CSS
- **Database**: SQLite
- **Content**: Markdown with frontmatter

## 📦 Prerequisites

- [Roc](https://roc-lang.org/install) (latest alpha release)
- [Node.js](https://nodejs.org/) (for Tailwind CSS)
- [SQLite](https://sqlite.org/) (for database)

## 🚀 Getting Started

### 1. Install Dependencies

```bash
# Install Node.js dependencies
npm install

# Build Tailwind CSS
npm run build:css
```

### 2. Add Your Content

```bash
# Create your first blog post
mkdir -p content/posts
echo "---
title: \"My First Post\"
date: 2025-01-01
tags: [roc, htmx]
---

# Welcome to My Blog

This is my first post using Roc and HTMX!
" > content/posts/my-first-post.md
```

### 3. Start the Development Server

```bash
# Start the Roc HTTP server
npm run dev
```

The server will be available at [http://localhost:8000](http://localhost:8000)

### 4. Development Workflow

```bash
# Build CSS (run when you modify Tailwind classes)
npm run build:css

# Start development server
npm run dev

# Check Roc syntax
npm run check
```

## 📁 Project Structure

```
tech-posts/
├── src/
│   ├── framework.roc      # Core framework functionality
│   └── main.roc           # Blog-specific implementation
├── content/
│   └── posts/             # Your markdown blog posts
├── static/
│   ├── css/
│   │   ├── tailwind.css   # Tailwind input
│   │   └── output.css     # Compiled CSS
│   └── js/                # Client-side libraries
├── templates/             # HTML templates
├── package.json           # Node.js dependencies
└── tailwind.config.js     # Tailwind configuration
```

## 🎯 Roadmap

### Phase 1: Foundation ✅
- [x] Basic HTTP server with Roc
- [x] Simple routing
- [x] HTMX integration
- [x] Basic HTML templates

### Phase 2: Content Management
- [ ] Markdown processing
- [ ] SQLite database integration
- [ ] Blog post listing
- [ ] Individual post pages

### Phase 3: Enhanced Features
- [ ] Alpine.js integration
- [ ] Mermaid.js diagrams
- [ ] Search functionality
- [ ] Tags and categories

### Phase 4: Production Ready
- [ ] Error handling
- [ ] Performance optimization
- [ ] Deployment configuration
- [ ] Documentation

## 🤝 Contributing

This is a learning project exploring Roc and modern web technologies. The framework component may be open sourced in the future.

### What We're Looking For
- **Roc patterns** and best practices
- **HTMX integration** improvements
- **Performance optimizations**
- **Documentation** improvements
- **Bug fixes** and feature requests

## 🙏 Acknowledgments

- [Roc Language](https://roc-lang.org) for the functional programming foundation
- [HTMX](https://htmx.org) for dynamic web interactions
- [roc-htmx-playground](https://github.com/lukewilliamboswell/roc-htmx-playground) for inspiration and examples
- [Tailwind CSS](https://tailwindcss.com) for utility-first styling

## 📚 Resources

- [Roc Documentation](https://roc-lang.org/docs)
- [HTMX Documentation](https://htmx.org/docs)
- [Alpine.js Documentation](https://alpinejs.dev/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs) 