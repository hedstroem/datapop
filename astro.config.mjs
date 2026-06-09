import { defineConfig } from 'astro/config';
import mdx from '@astrojs/mdx';
import react from '@astrojs/react';
import tailwindcss from '@tailwindcss/vite';
import { unified } from '@astrojs/markdown-remark';
import remarkMath from 'remark-math';
import rehypeKatex from 'rehype-katex';
import remarkImagePaths from './remark-image-paths.mjs';

export default defineConfig({
  site: 'https://yourusername.netlify.app',
  prefetch: true,
  integrations: [
    mdx(),
    react()
  ],
  vite: {
    plugins: [tailwindcss()]
  },
  markdown: {
    processor: unified({
      remarkPlugins: [remarkImagePaths, remarkMath],
      rehypePlugins: [rehypeKatex]
    }),
    syntaxHighlight: 'shiki',
    shikiConfig: {
      theme: 'github-dark',
      wrap: true
    }
  }
});
