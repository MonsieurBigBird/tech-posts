module.exports = {
  content: [
    './templates/**/*.html',
    './content/posts/**/*.md',
    './src/**/*.roc',
  ],
  theme: {
    extend: {},
  },
  plugins: [require('@tailwindcss/typography')],
}; 