# Development Guide

This guide helps you set up and contribute to the Roc SSR Tech Blog project.

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/roc-ssr-blog.git
   cd roc-ssr-blog
   ```

2. **Install dependencies**
   ```bash
   npm run setup
   ```

3. **Start development server**
   ```bash
   npm run dev
   ```

4. **Open in browser**
   Navigate to [http://localhost:8000](http://localhost:8000)

## 🛠️ Development Workflow

### Making Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Edit Roc code in `src/`
   - Update CSS in `static/css/tailwind.css`
   - Add content in `content/posts/`

3. **Build CSS** (if you modified Tailwind classes)
   ```bash
   npm run build:css
   ```

4. **Test your changes**
   ```bash
   npm run dev
   ```

5. **Check Roc syntax**
   ```bash
   npm run check
   ```

6. **Commit and push**
   ```bash
   git add .
   git commit -m "Add your feature description"
   git push origin feature/your-feature-name
   ```

### Available Scripts

- `npm run dev` - Start development server
- `npm run build:css` - Build Tailwind CSS
- `npm run build:css:watch` - Watch and rebuild CSS on changes
- `npm run check` - Check Roc syntax
- `npm run clean` - Clean build artifacts
- `npm run setup` - Install dependencies and build CSS

## 📁 Project Structure

```
tech-posts/
├── src/
│   └── main.roc              # Main Roc application
├── content/
│   └── posts/                # Markdown blog posts
├── static/
│   ├── css/
│   │   ├── tailwind.css      # Tailwind input
│   │   └── output.css        # Compiled CSS (gitignored)
│   └── js/                   # Client-side libraries
├── templates/                # HTML templates
├── .github/workflows/        # CI/CD configuration
├── package.json              # Node.js dependencies
└── tailwind.config.js        # Tailwind configuration
```

## 🧪 Testing

Currently, testing is manual. Future plans include:

- Unit tests for Roc functions
- Integration tests for HTTP endpoints
- Visual regression tests for UI components

## 🚀 Deployment

### Local Development
```bash
npm run dev
```

### Production Build
```bash
npm run dev:build
./main  # Run the compiled binary
```

### Environment Variables
- `ROC_BASIC_WEBSERVER_PORT` - Set custom port (default: 8000)

## 🐛 Debugging

### Common Issues

1. **Roc compilation errors**
   - Check syntax with `npm run check`
   - Ensure you're using the latest Roc version

2. **CSS not updating**
   - Run `npm run build:css`
   - Check `tailwind.config.js` content paths

3. **HTMX not working**
   - Check browser console for errors
   - Verify HTMX script is loaded
   - Check network tab for failed requests

### Logs

The server logs all requests to stdout:
```
2025-08-02T20:12:12Z GET /
2025-08-02T20:12:12Z GET /favicon.ico
```

## 📚 Resources

- [Roc Language](https://roc-lang.org)
- [HTMX Documentation](https://htmx.org/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [roc-htmx-playground](https://github.com/lukewilliamboswell/roc-htmx-playground)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Code Style

- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused
- Follow Roc conventions

### Commit Messages

Use conventional commit format:
```
feat: add user authentication
fix: resolve routing issue
docs: update README
style: format code
refactor: simplify database queries
test: add unit tests
``` 