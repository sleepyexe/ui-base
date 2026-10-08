/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,svelte}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Plus Jakarta Sans"', 'Inter', 'system-ui', 'sans-serif'],
        mono: ['"JetBrains Mono"', 'monospace'],
      },
      colors: {
        tablet: {
          bg: '#111319',
          sidebar: '#12141a',
          surface: '#171a23',
          surfaceHover: '#1f2330',
          border: 'rgba(255, 255, 255, 0.07)',
          accent: '#f59e0b',
        },
      },
    },
  },
  plugins: [],
}


