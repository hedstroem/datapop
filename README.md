# datapop

A personal blog about data, statistics, algorithms, engineering, and leadership. Built with [Astro](https://astro.build) and deployed on Netlify.

## Stack

- Astro with MDX for posts
- Tailwind CSS for styling
- KaTeX (`remark-math` + `rehype-katex`) for math rendering
- Shiki for code syntax highlighting
- React, used only at build time to render icons

## Getting started

```sh
npm install
npm run dev
```

The dev server runs at `http://localhost:4321`.

| Command           | Action                                      |
| ----------------- | ------------------------------------------- |
| `npm install`     | Install dependencies                        |
| `npm run dev`     | Start the dev server                        |
| `npm run build`   | Build the production site to `./dist/`      |
| `npm run preview` | Preview the production build locally        |

## Project structure

```
src/
  content/blog/   Blog posts (.mdx)
  content.config.ts   Blog collection schema
  components/     Header, Footer, ImageGallery, etc.
  layouts/        Page and blog post layouts
  pages/          Routes (index, blog list, post pages)
  images/         Source images, optimized at build time
  styles/         Global styles
public/           Static assets served as-is
```

## Writing posts

Add an `.mdx` file under `src/content/blog/`. Each post needs frontmatter:

```yaml
---
title: 'Post title'
description: 'Short summary'
pubDate: 2025-07-15
tags: ['statistics', 'streaming-data']
---
```

The first tag is used to group the post on the topic view of the home page.

## Images

Put images under `src/images/` and reference them with a root-relative path, either inline:

```md
![A caption](/images/my-post/figure-1.png)
```

or through the gallery component:

```jsx
<ImageGallery images={[{ src: "/images/my-post/figure-1.png", alt: "..." }]} />
```

Images are optimized and converted to WebP automatically during the build, with width and height added to prevent layout shift. Keep the source files as PNG (or JPG); no manual conversion is needed.

## Deployment

`npm run build` outputs a static site to `dist/`. The included `netlify.toml` configures the Netlify build. Set the `site` value in `astro.config.mjs` to the production URL before deploying.
