# Create all Astro blog files

Write-Host "Creating Astro blog files..." -ForegroundColor Green

# astro.config.mjs
@'
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
'@ | Out-File -FilePath "astro.config.mjs" -Encoding UTF8

# tailwind.config.mjs
@'
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Inter', 'system-ui', 'sans-serif'],
        'display': ['Geist Sans', 'system-ui', 'sans-serif'],
        'mono': ['Geist Mono', 'monospace'],
      },
      typography: {
        DEFAULT: {
          css: {
            'code::before': {
              content: '""'
            },
            'code::after': {
              content: '""'
            }
          }
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
'@ | Out-File -FilePath "tailwind.config.mjs" -Encoding UTF8

# src/styles/global.css
@'
@import '@fontsource/inter/400.css';
@import '@fontsource/inter/500.css';
@import '@fontsource/inter/600.css';
@import '@fontsource/geist-sans/700.css';
@import '@fontsource/geist-sans/800.css';
@import '@fontsource/geist-mono/400.css';
@import 'katex/dist/katex.min.css';
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --font-sans: 'Inter', system-ui, sans-serif;
    --font-display: 'Geist Sans', system-ui, sans-serif;
    --font-mono: 'Geist Mono', monospace;
  }

  html {
    @apply antialiased;
  }

  body {
    @apply bg-white dark:bg-zinc-950 text-zinc-900 dark:text-zinc-100;
  }

  h1, h2, h3, h4, h5, h6 {
    @apply font-display font-bold tracking-tight;
  }

  code {
    @apply font-mono text-sm;
  }

  p code, li code {
    @apply bg-zinc-100 dark:bg-zinc-800 px-1.5 py-0.5 rounded text-zinc-800 dark:text-zinc-200;
  }

  pre {
    @apply font-mono text-sm leading-relaxed;
  }

  pre code {
    @apply bg-transparent p-0;
  }
}
'@ | Out-File -FilePath "src\styles\global.css" -Encoding UTF8

# src/components/BaseHead.astro
@'
---
export interface Props {
  title: string;
  description: string;
}

const { title, description } = Astro.props;
---

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="icon" type="image/svg+xml" href="/favicon.svg" />
<meta name="generator" content={Astro.generator} />
<title>{title}</title>
<meta name="description" content={description} />
'@ | Out-File -FilePath "src\components\BaseHead.astro" -Encoding UTF8

# src/components/Header.astro
@'
---
import { Home, BookOpen, User } from 'lucide-react';
---

<header class="border-b border-zinc-200 dark:border-zinc-800">
  <nav class="container mx-auto px-4 py-4 max-w-4xl">
    <div class="flex items-center justify-between">
      <a href="/" class="font-display font-bold text-2xl hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors">
        ML Blog
      </a>
      <div class="flex items-center gap-6">
        <a href="/" class="flex items-center gap-2 hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors">
          <Home className="w-4 h-4" />
          <span class="hidden sm:inline">Home</span>
        </a>
        <a href="/blog" class="flex items-center gap-2 hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors">
          <BookOpen className="w-4 h-4" />
          <span class="hidden sm:inline">Blog</span>
        </a>
        <a href="/about" class="flex items-center gap-2 hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors">
          <User className="w-4 h-4" />
          <span class="hidden sm:inline">About</span>
        </a>
      </div>
    </div>
  </nav>
</header>
'@ | Out-File -FilePath "src\components\Header.astro" -Encoding UTF8

# src/components/Footer.astro
@'
---
const year = new Date().getFullYear();
---

<footer class="border-t border-zinc-200 dark:border-zinc-800 mt-16">
  <div class="container mx-auto px-4 py-6 max-w-4xl">
    <p class="text-center text-sm text-zinc-600 dark:text-zinc-400">
      © {year} ML Blog. Built with Astro.
    </p>
  </div>
</footer>
'@ | Out-File -FilePath "src\components\Footer.astro" -Encoding UTF8

# src/layouts/Layout.astro
@'
---
import BaseHead from '../components/BaseHead.astro';
import Header from '../components/Header.astro';
import Footer from '../components/Footer.astro';
import '../styles/global.css';

export interface Props {
  title: string;
  description?: string;
}

const { title, description = 'A blog about statistics, ML, and algorithms' } = Astro.props;
---

<!DOCTYPE html>
<html lang="en">
  <head>
    <BaseHead title={title} description={description} />
  </head>
  <body>
    <div class="min-h-screen flex flex-col">
      <Header />
      <main class="flex-grow container mx-auto px-4 py-8 max-w-4xl">
        <slot />
      </main>
      <Footer />
    </div>
  </body>
</html>
'@ | Out-File -FilePath "src\layouts\Layout.astro" -Encoding UTF8

# src/layouts/BlogPost.astro
@'
---
import Layout from './Layout.astro';
import { CalendarDays, Clock } from 'lucide-react';

export interface Props {
  title: string;
  description: string;
  pubDate: Date;
  updatedDate?: Date;
  tags?: string[];
}

const { title, description, pubDate, updatedDate, tags = [] } = Astro.props;
const readingTime = Math.ceil(Astro.slots.has('default') ? 5 : 1);
---

<Layout title={title} description={description}>
  <article class="prose prose-zinc dark:prose-invert max-w-none">
    <header class="not-prose mb-8">
      <h1 class="font-display text-4xl font-bold mb-4">{title}</h1>
      <div class="flex items-center gap-4 text-sm text-zinc-600 dark:text-zinc-400">
        <div class="flex items-center gap-1">
          <CalendarDays className="w-4 h-4" />
          <time datetime={pubDate.toISOString()}>
            {pubDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}
          </time>
        </div>
        <div class="flex items-center gap-1">
          <Clock className="w-4 h-4" />
          <span>{readingTime} min read</span>
        </div>
      </div>
      {tags.length > 0 && (
        <div class="flex gap-2 mt-4">
          {tags.map(tag => (
            <span class="px-3 py-1 bg-zinc-100 dark:bg-zinc-800 rounded-full text-xs">
              {tag}
            </span>
          ))}
        </div>
      )}
    </header>
    <slot />
  </article>
</Layout>
'@ | Out-File -FilePath "src\layouts\BlogPost.astro" -Encoding UTF8

# src/components/ImageGallery.astro
@'
---
export interface Props {
  images: Array<{
    src: string;
    alt: string;
    caption?: string;
  }>;
  columns?: number;
}

const { images, columns = 2 } = Astro.props;
const gridClass = columns === 1 ? 'grid-cols-1' : columns === 3 ? 'md:grid-cols-3' : 'md:grid-cols-2';
---

<div class={`grid gap-4 my-8 grid-cols-1 ${gridClass}`}>
  {images.map((image) => (
    <figure class="space-y-2">
      <img 
        src={image.src} 
        alt={image.alt}
        class="w-full rounded-lg shadow-md"
        loading="lazy"
      />
      {image.caption && (
        <figcaption class="text-sm text-zinc-600 dark:text-zinc-400 text-center">
          {image.caption}
        </figcaption>
      )}
    </figure>
  ))}
</div>
'@ | Out-File -FilePath "src\components\ImageGallery.astro" -Encoding UTF8

# src/content/config.ts
@'
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    tags: z.array(z.string()).default([]),
    image: z.string().optional(),
  }),
});

export const collections = { blog };
'@ | Out-File -FilePath "src\content\config.ts" -Encoding UTF8

# src/content/blog/gradient-descent.mdx
@'
---
title: 'Understanding Gradient Descent'
description: 'A visual guide to optimization in machine learning'
pubDate: 2025-01-15
tags: ['machine-learning', 'optimization', 'algorithms']
---

import ImageGallery from '../../components/ImageGallery.astro';

Gradient descent is fundamental to training machine learning models. Let's explore how it works.

## The Basics

Gradient descent is an optimization algorithm used to minimize a cost function by iteratively moving in the direction of steepest descent.

Here's a simple implementation in Python:

```python
import numpy as np

def gradient_descent(X, y, learning_rate=0.01, iterations=1000):
    m = len(y)
    theta = np.zeros(X.shape[1])
    
    for _ in range(iterations):
        predictions = X @ theta
        errors = predictions - y
        gradient = (1/m) * X.T @ errors
        theta -= learning_rate * gradient
    
    return theta
```

## Mathematical Foundation

The update rule for gradient descent is:

$$\theta_{t+1} = \theta_t - \alpha \nabla_\theta J(\theta)$$

Where:
- $\alpha$ is the learning rate
- $J(\theta)$ is our cost function
- $\nabla_\theta J(\theta)$ is the gradient

## Visualization Example

<ImageGallery 
  images={[
    {
      src: "/images/placeholder1.jpg",
      alt: "2D visualization of gradient descent",
      caption: "Gradient descent finding the minimum"
    },
    {
      src: "/images/placeholder2.jpg",
      alt: "3D loss surface",
      caption: "The loss landscape in 3D"
    }
  ]}
/>

## Types of Gradient Descent

1. **Batch Gradient Descent**: Uses entire dataset
2. **Stochastic Gradient Descent**: Uses one sample at a time
3. **Mini-batch Gradient Descent**: Uses small batches

Each has trade-offs between computational efficiency and convergence stability.
'@ | Out-File -FilePath "src\content\blog\gradient-descent.mdx" -Encoding UTF8

# src/pages/blog/[...slug].astro
@'
---
import { getCollection } from 'astro:content';
import BlogPost from '../../layouts/BlogPost.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map((post) => ({
    params: { slug: post.slug },
    props: post,
  }));
}

const post = Astro.props;
const { Content } = await post.render();
---

<BlogPost {...post.data}>
  <Content />
</BlogPost>
'@ | Out-File -FilePath "src\pages\blog\[...slug].astro" -Encoding UTF8

# src/pages/blog.astro
@'
---
import Layout from '../layouts/Layout.astro';
import { getCollection } from 'astro:content';
import { CalendarDays } from 'lucide-react';

const posts = (await getCollection('blog')).sort(
  (a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf()
);
---

<Layout title="Blog">
  <h1 class="font-display text-4xl font-bold mb-8">All Posts</h1>
  <div class="space-y-8">
    {posts.map((post) => (
      <article class="border-b border-zinc-200 dark:border-zinc-800 pb-8 last:border-0">
        <a href={`/blog/${post.slug}`} class="group">
          <h2 class="font-display text-2xl font-bold mb-2 group-hover:text-zinc-600 dark:group-hover:text-zinc-300 transition-colors">
            {post.data.title}
          </h2>
        </a>
        <p class="text-zinc-600 dark:text-zinc-400 mb-3">{post.data.description}</p>
        <div class="flex items-center gap-4 text-sm text-zinc-500">
          <div class="flex items-center gap-1">
            <CalendarDays className="w-4 h-4" />
            <time datetime={post.data.pubDate.toISOString()}>
              {post.data.pubDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })}
            </time>
          </div>
          {post.data.tags.length > 0 && (
            <div class="flex gap-2">
              {post.data.tags.map(tag => (
                <span class="text-xs px-2 py-1 bg-zinc-100 dark:bg-zinc-800 rounded">
                  {tag}
                </span>
              ))}
            </div>
          )}
        </div>
      </article>
    ))}
  </div>
</Layout>
'@ | Out-File -FilePath "src\pages\blog.astro" -Encoding UTF8

# src/pages/index.astro
@'
---
import Layout from '../layouts/Layout.astro';
import { getCollection } from 'astro:content';
import { ArrowRight } from 'lucide-react';

const posts = (await getCollection('blog'))
  .sort((a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf())
  .slice(0, 3);
---

<Layout title="ML Blog - Statistics, Machine Learning & Algorithms">
  <section class="mb-16">
    <h1 class="font-display text-5xl font-bold mb-4">
      Statistics, ML & Algorithms
    </h1>
    <p class="text-xl text-zinc-600 dark:text-zinc-400">
      Exploring machine learning concepts through code and visualizations.
    </p>
  </section>

  <section>
    <h2 class="font-display text-3xl font-bold mb-8">Recent Posts</h2>
    <div class="space-y-6">
      {posts.map((post) => (
        <article class="group">
          <a href={`/blog/${post.slug}`}>
            <h3 class="font-display text-xl font-bold mb-2 group-hover:text-zinc-600 dark:group-hover:text-zinc-300 transition-colors">
              {post.data.title}
            </h3>
          </a>
          <p class="text-zinc-600 dark:text-zinc-400">
            {post.data.description}
          </p>
        </article>
      ))}
    </div>
    <a href="/blog" class="inline-flex items-center gap-2 mt-8 text-zinc-600 dark:text-zinc-400 hover:text-zinc-900 dark:hover:text-zinc-100 transition-colors">
      View all posts
      <ArrowRight className="w-4 h-4" />
    </a>
  </section>
</Layout>
'@ | Out-File -FilePath "src\pages\index.astro" -Encoding UTF8

# .gitignore
@'
# build output
dist/

# dependencies
node_modules/

# logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# environment variables
.env
.env.production

# macOS-specific files
.DS_Store

# editor
.vscode/
.idea/
'@ | Out-File -FilePath ".gitignore" -Encoding UTF8

# netlify.toml
@'
[build]
  command = "npm run build"
  publish = "dist"

[build.environment]
  NODE_VERSION = "18"
'@ | Out-File -FilePath "netlify.toml" -Encoding UTF8

Write-Host "`nAll files created successfully!" -ForegroundColor Green
Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "1. Run: git add ." -ForegroundColor Cyan
Write-Host "2. Run: git commit -m 'Add all blog components and configuration'" -ForegroundColor Cyan
Write-Host "3. Run: git push" -ForegroundColor Cyan
Write-Host "4. Run: npm run dev" -ForegroundColor Cyan