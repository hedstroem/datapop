@echo off
echo Creating Astro blog files...

REM Create astro.config.mjs
echo import { defineConfig } from 'astro/config'; > astro.config.mjs
echo import mdx from '@astrojs/mdx'; >> astro.config.mjs
echo import tailwind from '@astrojs/tailwind'; >> astro.config.mjs
echo import react from '@astrojs/react'; >> astro.config.mjs
echo. >> astro.config.mjs
echo export default defineConfig({ >> astro.config.mjs
echo   site: 'https://yourusername.netlify.app', >> astro.config.mjs
echo   integrations: [ >> astro.config.mjs
echo     mdx({ >> astro.config.mjs
echo       remarkPlugins: [ >> astro.config.mjs
echo         'remark-math' >> astro.config.mjs
echo       ], >> astro.config.mjs
echo       rehypePlugins: [ >> astro.config.mjs
echo         ['rehype-katex', { output: 'html' }] >> astro.config.mjs
echo       ] >> astro.config.mjs
echo     }), >> astro.config.mjs
echo     tailwind(), >> astro.config.mjs
echo     react() >> astro.config.mjs
echo   ], >> astro.config.mjs
echo   markdown: { >> astro.config.mjs
echo     syntaxHighlight: 'shiki', >> astro.config.mjs
echo     shikiConfig: { >> astro.config.mjs
echo       theme: 'github-dark', >> astro.config.mjs
echo       wrap: true >> astro.config.mjs
echo     } >> astro.config.mjs
echo   } >> astro.config.mjs
echo }); >> astro.config.mjs

REM Create tailwind.config.mjs
(
echo /** @type {import('tailwindcss').Config} */
echo export default {
echo   content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
echo   theme: {
echo     extend: {
echo       fontFamily: {
echo         'sans': ['Inter', 'system-ui', 'sans-serif'],
echo         'display': ['Geist Sans', 'system-ui', 'sans-serif'],
echo         'mono': ['Geist Mono', 'monospace'],
echo       },
echo       typography: {
echo         DEFAULT: {
echo           css: {
echo             'code::before': {
echo               content: '""'
echo             },
echo             'code::after': {
echo               content: '""'
echo             }
echo           }
echo         }
echo       }
echo     },
echo   },
echo   plugins: [
echo     require('@tailwindcss/typography'^),
echo   ],
echo }
) > tailwind.config.mjs

REM Create global.css
(
echo @import '@fontsource/inter/400.css';
echo @import '@fontsource/inter/500.css';
echo @import '@fontsource/inter/600.css';
echo @import '@fontsource/geist-sans/700.css';
echo @import '@fontsource/geist-sans/800.css';
echo @import '@fontsource/geist-mono/400.css';
echo @import 'katex/dist/katex.min.css';
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
echo.
echo @layer base {
echo   :root {
echo     --font-sans: 'Inter', system-ui, sans-serif;
echo     --font-display: 'Geist Sans', system-ui, sans-serif;
echo     --font-mono: 'Geist Mono', monospace;
echo   }
echo.
echo   html {
echo     @apply antialiased;
echo   }
echo.
echo   body {
echo     @apply bg-white dark:bg-zinc-950 text-zinc-900 dark:text-zinc-100;
echo   }
echo.
echo   h1, h2, h3, h4, h5, h6 {
echo     @apply font-display font-bold tracking-tight;
echo   }
echo.
echo   code {
echo     @apply font-mono text-sm;
echo   }
echo.
echo   p code, li code {
echo     @apply bg-zinc-100 dark:bg-zinc-800 px-1.5 py-0.5 rounded text-zinc-800 dark:text-zinc-200;
echo   }
echo.
echo   pre {
echo     @apply font-mono text-sm leading-relaxed;
echo   }
echo.
echo   pre code {
echo     @apply bg-transparent p-0;
echo   }
echo }
) > src\styles\global.css

REM Create BaseHead.astro
(
echo ---
echo export interface Props {
echo   title: string;
echo   description: string;
echo }
echo.
echo const { title, description } = Astro.props;
echo ---
echo.
echo ^<meta charset="UTF-8" /^>
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0" /^>
echo ^<link rel="icon" type="image/svg+xml" href="/favicon.svg" /^>
echo ^<meta name="generator" content={Astro.generator} /^>
echo ^<title^>{title}^</title^>
echo ^<meta name="description" content={description} /^>
) > src\components\BaseHead.astro

REM Create Header.astro
(
echo ---
echo import { Home, BookOpen, User } from 'lucide-react';
echo ---
echo.
echo ^<header class="border-b border-zinc-200 dark:border-zinc-800"^>
echo   ^<nav class="container mx-auto px-4 py-4 max-w-4xl"^>
echo     ^<div class="flex items-center justify-between"^>
echo       ^<a href="/" class="font-display font-bold text-2xl hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors"^>
echo         ML Blog
echo       ^</a^>
echo       ^<div class="flex items-center gap-6"^>
echo         ^<a href="/" class="flex items-center gap-2 hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors"^>
echo           ^<Home className="w-4 h-4" /^>
echo           ^<span class="hidden sm:inline"^>Home^</span^>
echo         ^</a^>
echo         ^<a href="/blog" class="flex items-center gap-2 hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors"^>
echo           ^<BookOpen className="w-4 h-4" /^>
echo           ^<span class="hidden sm:inline"^>Blog^</span^>
echo         ^</a^>
echo         ^<a href="/about" class="flex items-center gap-2 hover:text-zinc-600 dark:hover:text-zinc-300 transition-colors"^>
echo           ^<User className="w-4 h-4" /^>
echo           ^<span class="hidden sm:inline"^>About^</span^>
echo         ^</a^>
echo       ^</div^>
echo     ^</div^>
echo   ^</nav^>
echo ^</header^>
) > src\components\Header.astro

REM Create Footer.astro
(
echo ---
echo const year = new Date(^).getFullYear(^);
echo ---
echo.
echo ^<footer class="border-t border-zinc-200 dark:border-zinc-800 mt-16"^>
echo   ^<div class="container mx-auto px-4 py-6 max-w-4xl"^>
echo     ^<p class="text-center text-sm text-zinc-600 dark:text-zinc-400"^>
echo       © {year} ML Blog. Built with Astro.
echo     ^</p^>
echo   ^</div^>
echo ^</footer^>
) > src\components\Footer.astro

REM Create Layout.astro
(
echo ---
echo import BaseHead from '../components/BaseHead.astro';
echo import Header from '../components/Header.astro';
echo import Footer from '../components/Footer.astro';
echo import '../styles/global.css';
echo.
echo export interface Props {
echo   title: string;
echo   description?: string;
echo }
echo.
echo const { title, description = 'A blog about statistics, ML, and algorithms' } = Astro.props;
echo ---
echo.
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo   ^<head^>
echo     ^<BaseHead title={title} description={description} /^>
echo   ^</head^>
echo   ^<body^>
echo     ^<div class="min-h-screen flex flex-col"^>
echo       ^<Header /^>
echo       ^<main class="flex-grow container mx-auto px-4 py-8 max-w-4xl"^>
echo         ^<slot /^>
echo       ^</main^>
echo       ^<Footer /^>
echo     ^</div^>
echo   ^</body^>
echo ^</html^>
) > src\layouts\Layout.astro

REM Create BlogPost.astro
(
echo ---
echo import Layout from './Layout.astro';
echo import { CalendarDays, Clock } from 'lucide-react';
echo.
echo export interface Props {
echo   title: string;
echo   description: string;
echo   pubDate: Date;
echo   updatedDate?: Date;
echo   tags?: string[];
echo }
echo.
echo const { title, description, pubDate, updatedDate, tags = [] } = Astro.props;
echo const readingTime = Math.ceil(Astro.slots.has('default'^) ? 5 : 1^);
echo ---
echo.
echo ^<Layout title={title} description={description}^>
echo   ^<article class="prose prose-zinc dark:prose-invert max-w-none"^>
echo     ^<header class="not-prose mb-8"^>
echo       ^<h1 class="font-display text-4xl font-bold mb-4"^>{title}^</h1^>
echo       ^<div class="flex items-center gap-4 text-sm text-zinc-600 dark:text-zinc-400"^>
echo         ^<div class="flex items-center gap-1"^>
echo           ^<CalendarDays className="w-4 h-4" /^>
echo           ^<time datetime={pubDate.toISOString(^)}^>
echo             {pubDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }^)}
echo           ^</time^>
echo         ^</div^>
echo         ^<div class="flex items-center gap-1"^>
echo           ^<Clock className="w-4 h-4" /^>
echo           ^<span^>{readingTime} min read^</span^>
echo         ^</div^>
echo       ^</div^>
echo       {tags.length ^> 0 ^&^& (
echo         ^<div class="flex gap-2 mt-4"^>
echo           {tags.map(tag =^> (
echo             ^<span class="px-3 py-1 bg-zinc-100 dark:bg-zinc-800 rounded-full text-xs"^>
echo               {tag}
echo             ^</span^>
echo           ^)^)}
echo         ^</div^>
echo       ^)}
echo     ^</header^>
echo     ^<slot /^>
echo   ^</article^>
echo ^</Layout^>
) > src\layouts\BlogPost.astro

REM Create ImageGallery.astro
(
echo ---
echo export interface Props {
echo   images: Array^<{
echo     src: string;
echo     alt: string;
echo     caption?: string;
echo   }^>;
echo   columns?: number;
echo }
echo.
echo const { images, columns = 2 } = Astro.props;
echo const gridClass = columns === 1 ? 'grid-cols-1' : columns === 3 ? 'md:grid-cols-3' : 'md:grid-cols-2';
echo ---
echo.
echo ^<div class={`grid gap-4 my-8 grid-cols-1 ${gridClass}`}^>
echo   {images.map((image^) =^> (
echo     ^<figure class="space-y-2"^>
echo       ^<img 
echo         src={image.src} 
echo         alt={image.alt}
echo         class="w-full rounded-lg shadow-md"
echo         loading="lazy"
echo       /^>
echo       {image.caption ^&^& (
echo         ^<figcaption class="text-sm text-zinc-600 dark:text-zinc-400 text-center"^>
echo           {image.caption}
echo         ^</figcaption^>
echo       ^)}
echo     ^</figure^>
echo   ^)^)}
echo ^</div^>
) > src\components\ImageGallery.astro

REM Create content config
(
echo import { defineCollection, z } from 'astro:content';
echo.
echo const blog = defineCollection({
echo   type: 'content',
echo   schema: z.object({
echo     title: z.string(^),
echo     description: z.string(^),
echo     pubDate: z.coerce.date(^),
echo     updatedDate: z.coerce.date(^).optional(^),
echo     tags: z.array(z.string(^)^).default([]^),
echo     image: z.string(^).optional(^),
echo   }^),
echo }^);
echo.
echo export const collections = { blog };
) > src\content\config.ts

REM Create blog post
(
echo ---
echo title: 'Understanding Gradient Descent'
echo description: 'A visual guide to optimization in machine learning'
echo pubDate: 2025-01-15
echo tags: ['machine-learning', 'optimization', 'algorithms']
echo ---
echo.
echo import ImageGallery from '../../components/ImageGallery.astro';
echo.
echo Gradient descent is fundamental to training machine learning models. Let's explore how it works.
echo.
echo ## The Basics
echo.
echo Gradient descent is an optimization algorithm used to minimize a cost function by iteratively moving in the direction of steepest descent.
echo.
echo Here's a simple implementation in Python:
echo.
echo ```python
echo import numpy as np
echo.
echo def gradient_descent(X, y, learning_rate=0.01, iterations=1000^):
echo     m = len(y^)
echo     theta = np.zeros(X.shape[1]^)
echo     
echo     for _ in range(iterations^):
echo         predictions = X @ theta
echo         errors = predictions - y
echo         gradient = (1/m^) * X.T @ errors
echo         theta -= learning_rate * gradient
echo     
echo     return theta
echo ```
echo.
echo ## Mathematical Foundation
echo.
echo The update rule for gradient descent is:
echo.
echo $$\theta_{t+1} = \theta_t - \alpha \nabla_\theta J(\theta^)$$
echo.
echo Where:
echo - $\alpha$ is the learning rate
echo - $J(\theta^)$ is our cost function
echo - $\nabla_\theta J(\theta^)$ is the gradient
echo.
echo ## Visualization Example
echo.
echo ^<ImageGallery 
echo   images={[
echo     {
echo       src: "/images/placeholder1.jpg",
echo       alt: "2D visualization of gradient descent",
echo       caption: "Gradient descent finding the minimum"
echo     },
echo     {
echo       src: "/images/placeholder2.jpg",
echo       alt: "3D loss surface",
echo       caption: "The loss landscape in 3D"
echo     }
echo   ]}
echo /^>
echo.
echo ## Types of Gradient Descent
echo.
echo 1. **Batch Gradient Descent**: Uses entire dataset
echo 2. **Stochastic Gradient Descent**: Uses one sample at a time
echo 3. **Mini-batch Gradient Descent**: Uses small batches
echo.
echo Each has trade-offs between computational efficiency and convergence stability.
) > src\content\blog\gradient-descent.mdx

REM Create blog slug page
(
echo ---
echo import { getCollection } from 'astro:content';
echo import BlogPost from '../../layouts/BlogPost.astro';
echo.
echo export async function getStaticPaths(^) {
echo   const posts = await getCollection('blog'^);
echo   return posts.map((post^) =^> ({
echo     params: { slug: post.slug },
echo     props: post,
echo   }^)^);
echo }
echo.
echo const post = Astro.props;
echo const { Content } = await post.render(^);
echo ---
echo.
echo ^<BlogPost {...post.data}^>
echo   ^<Content /^>
echo ^</BlogPost^>
) > src\pages\blog\[...slug].astro

REM Create blog index
(
echo ---
echo import Layout from '../layouts/Layout.astro';
echo import { getCollection } from 'astro:content';
echo import { CalendarDays } from 'lucide-react';
echo.
echo const posts = (await getCollection('blog'^)^).sort(
echo   (a, b^) =^> b.data.pubDate.valueOf(^) - a.data.pubDate.valueOf(^)
echo ^);
echo ---
echo.
echo ^<Layout title="Blog"^>
echo   ^<h1 class="font-display text-4xl font-bold mb-8"^>All Posts^</h1^>
echo   ^<div class="space-y-8"^>
echo     {posts.map((post^) =^> (
echo       ^<article class="border-b border-zinc-200 dark:border-zinc-800 pb-8 last:border-0"^>
echo         ^<a href={`/blog/${post.slug}`} class="group"^>
echo           ^<h2 class="font-display text-2xl font-bold mb-2 group-hover:text-zinc-600 dark:group-hover:text-zinc-300 transition-colors"^>
echo             {post.data.title}
echo           ^</h2^>
echo         ^</a^>
echo         ^<p class="text-zinc-600 dark:text-zinc-400 mb-3"^>{post.data.description}^</p^>
echo         ^<div class="flex items-center gap-4 text-sm text-zinc-500"^>
echo           ^<div class="flex items-center gap-1"^>
echo             ^<CalendarDays className="w-4 h-4" /^>
echo             ^<time datetime={post.data.pubDate.toISOString(^)}^>
echo               {post.data.pubDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }^)}
echo             ^</time^>
echo           ^</div^>
echo           {post.data.tags.length ^> 0 ^&^& (
echo             ^<div class="flex gap-2"^>
echo               {post.data.tags.map(tag =^> (
echo                 ^<span class="text-xs px-2 py-1 bg-zinc-100 dark:bg-zinc-800 rounded"^>
echo                   {tag}
echo                 ^</span^>
echo               ^)^)}
echo             ^</div^>
echo           ^)}
echo         ^</div^>
echo       ^</article^>
echo     ^)^)}
echo   ^</div^>
echo ^</Layout^>
) > src\pages\blog.astro

REM Create index page
(
echo ---
echo import Layout from '../layouts/Layout.astro';
echo import { getCollection } from 'astro:content';
echo import { ArrowRight } from 'lucide-react';
echo.
echo const posts = (await getCollection('blog'^)^)
echo   .sort((a, b^) =^> b.data.pubDate.valueOf(^) - a.data.pubDate.valueOf(^)^)
echo   .slice(0, 3^);
echo ---
echo.
echo ^<Layout title="ML Blog - Statistics, Machine Learning & Algorithms"^>
echo   ^<section class="mb-16"^>
echo     ^<h1 class="font-display text-5xl font-bold mb-4"^>
echo       Statistics, ML ^& Algorithms
echo     ^</h1^>
echo     ^<p class="text-xl text-zinc-600 dark:text-zinc-400"^>
echo       Exploring machine learning concepts through code and visualizations.
echo     ^</p^>
echo   ^</section^>
echo.
echo   ^<section^>
echo     ^<h2 class="font-display text-3xl font-bold mb-8"^>Recent Posts^</h2^>
echo     ^<div class="space-y-6"^>
echo       {posts.map((post^) =^> (
echo         ^<article class="group"^>
echo           ^<a href={`/blog/${post.slug}`}^>
echo             ^<h3 class="font-display text-xl font-bold mb-2 group-hover:text-zinc-600 dark:group-hover:text-zinc-300 transition-colors"^>
echo               {post.data.title}
echo             ^</h3^>
echo           ^</a^>
echo           ^<p class="text-zinc-600 dark:text-zinc-400"^>
echo             {post.data.description}
echo           ^</p^>
echo         ^</article^>
echo       ^)^)}
echo     ^</div^>
echo     ^<a href="/blog" class="inline-flex items-center gap-2 mt-8 text-zinc-600 dark:text-zinc-400 hover:text-zinc-900 dark:hover:text-zinc-100 transition-colors"^>
echo       View all posts
echo       ^<ArrowRight className="w-4 h-4" /^>
echo     ^</a^>
echo   ^</section^>
echo ^</Layout^>
) > src\pages\index.astro

REM Create .gitignore
(
echo # build output
echo dist/
echo.
echo # dependencies
echo node_modules/
echo.
echo # logs
echo npm-debug.log*
echo yarn-debug.log*
echo yarn-error.log*
echo pnpm-debug.log*
echo.
echo # environment variables
echo .env
echo .env.production
echo.
echo # macOS-specific files
echo .DS_Store
echo.
echo # editor
echo .vscode/
echo .idea/
) > .gitignore

REM Create netlify.toml
(
echo [build]
echo   command = "npm run build"
echo   publish = "dist"
echo.
echo [build.environment]
echo   NODE_VERSION = "18"
) > netlify.toml

echo.
echo All files created successfully!
echo.
echo Next steps:
echo 1. Run: git add .
echo 2. Run: git commit -m "Add all blog components and configuration"
echo 3. Run: git push
echo 4. Run: npm run dev
echo.
pause