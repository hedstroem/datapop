import path from 'node:path';
import fs from 'node:fs';

/**
 * Lets blog authors keep writing root-absolute image URLs like
 * `![alt](/images/foo/bar.png)` while still getting Astro's build-time image
 * optimization (and automatic WebP output).
 *
 * Astro only optimizes images it can resolve through the asset pipeline, which
 * means local images imported relative to the source file. Root-absolute paths
 * are treated as `public/` assets and served unprocessed. Since the images now
 * live in `src/images/`, this plugin rewrites any `/images/...` markdown image
 * URL to a path relative to the current file so the pipeline picks it up.
 *
 * Authoring is unchanged: write `/images/...` exactly as before.
 */
export default function remarkImagePaths() {
  const imagesRoot = path.join(process.cwd(), 'src');

  return (tree, file) => {
    const fileDir = file.dirname;
    if (!fileDir) return;

    const walk = (node) => {
      if (
        node.type === 'image' &&
        typeof node.url === 'string' &&
        node.url.startsWith('/images/')
      ) {
        const absolute = path.join(imagesRoot, node.url);
        // Leave unresolvable images untouched so a missing/typo'd path 404s at
        // runtime (as before) instead of hard-failing the build.
        if (!fs.existsSync(absolute)) return;
        let relative = path.relative(fileDir, absolute).split(path.sep).join('/');
        if (!relative.startsWith('.')) relative = './' + relative;
        node.url = relative;
      }
      if (Array.isArray(node.children)) node.children.forEach(walk);
    };

    walk(tree);
  };
}
