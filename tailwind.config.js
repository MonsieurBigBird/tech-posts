/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.roc",
    "./templates/**/*.html",
    "./content/**/*.md",
  ],
  theme: {
    extend: {
      fontFamily: {
        'inter': ['Inter', 'sans-serif'],
      },
    },
  },
  plugins: [
    require('daisyui').default,
    require('@tailwindcss/typography'),
  ],
  daisyui: {
    themes: ["light", "dark"],
    darkTheme: "dark",
    base: true,
    styled: true,
    utils: true,
    prefix: "",
    logs: true,
    themeRoot: ":root",
  },
} 