# Roc SSR Blog Framework

This document describes the framework component of this project, which can be extracted into a separate open source repository.

## 🏗️ Architecture

### **Framework Components**
- `src/framework.roc` - Core framework functionality
- `src/main.roc` - Blog-specific implementation (example usage)
- `static/` - Static assets (CSS, JS)
- `templates/` - HTML templates
- `package.json` - Build configuration

### **Blog Components**
- `content/posts/` - Your blog content (private)
- `src/main.roc` - Your blog-specific customizations

## 🚀 Framework Features

### **Core Functionality**
- ✅ HTTP server with Roc
- ✅ Request routing
- ✅ HTMX integration
- ✅ Basic templating
- ✅ Logging and debugging

### **Planned Features**
- [ ] Markdown processing
- [ ] SQLite database integration
- [ ] Template engine
- [ ] Static file serving
- [ ] API endpoints
- [ ] Authentication
- [ ] Admin interface

## 📦 Extraction Strategy

### **Phase 1: Framework Development** (Current)
- Develop framework in single repo
- Test with real blog content
- Iterate on features

### **Phase 2: Framework Extraction**
```bash
# Extract framework to separate repo
roc-ssr-framework/
├── src/
│   ├── framework.roc
│   └── examples/
├── docs/
├── package.json
└── README.md

# Keep blog in current repo
my-blog/
├── src/main.roc
├── content/posts/
└── static/
```

### **Phase 3: Framework Distribution**
- Publish as open source package
- Create documentation and examples
- Build community around framework

## 🎯 Benefits of This Approach

### **For Framework Development**
- ✅ **Real-world testing** with actual blog
- ✅ **Faster iteration** - immediate feedback
- ✅ **Proven use case** - shows framework works

### **For Blog Development**
- ✅ **Customizable** - can modify framework for needs
- ✅ **Learning opportunity** - understand framework internals
- ✅ **Technical credibility** - shows advanced skills

### **For Community**
- ✅ **Working example** - framework with real implementation
- ✅ **Documentation** - shows how to use framework
- ✅ **Contributions** - others can improve framework

## 🔄 Migration Path

When ready to separate:

1. **Create new repo** for framework
2. **Copy framework files** to new repo
3. **Update imports** in blog
4. **Publish framework** as package
5. **Update blog** to use published framework

## 📝 Framework API

### **Core Functions**
```roc
# Initialize framework
init! : {} => Result Model []

# Handle HTTP requests
respond! : Request, Model => Result Response [ServerErr Str]_

# Route requests
routeRequest : Request -> Result Response [ServerErr Str]_
```

### **Customization Points**
- **HTML templates** - Customize appearance
- **Routing logic** - Add custom routes
- **Database integration** - Add data persistence
- **Authentication** - Add user management

## 🤝 Contributing to Framework

The framework is designed to be:
- **Modular** - Easy to extend
- **Well-documented** - Clear APIs
- **Testable** - Unit tests for core functions
- **Customizable** - Flexible for different use cases

## 📚 Resources

- [Roc Language](https://roc-lang.org)
- [HTMX Documentation](https://htmx.org/docs)
- [basic-webserver Platform](https://github.com/roc-lang/basic-webserver) 