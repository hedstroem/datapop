import { defineConfig } from 'astro/config'; 
import mdx from '@astrojs/mdx'; 
import tailwind from '@astrojs/tailwind'; 
import react from '@astrojs/react'; 
 
export default defineConfig({ 
  site: 'https://yourusername.netlify.app', 
  integrations: [ 
    mdx({ 
      remarkPlugins: [ 
        'remark-math' 
      ], 
      rehypePlugins: [ 
        ['rehype-katex', { output: 'html' }] 
      ] 
    }), 
    tailwind(), 
    react() 
  ], 
  markdown: { 
    syntaxHighlight: 'shiki', 
    shikiConfig: { 
      theme: 'github-dark', 
      wrap: true 
    } 
  } 
}); 
