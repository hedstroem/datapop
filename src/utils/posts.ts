import { getCollection, type CollectionEntry } from 'astro:content';

export type BlogPost = CollectionEntry<'blog'>;

let cachedPosts: BlogPost[] | null = null;

export async function getAllPosts(): Promise<BlogPost[]> {
  if (cachedPosts) {
    return cachedPosts;
  }

  cachedPosts = (await getCollection('blog'))
    .sort((a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf());

  return cachedPosts;
}

export async function getRecentPosts(count: number = 3): Promise<BlogPost[]> {
  const posts = await getAllPosts();
  return posts.slice(0, count);
}

export function getAllTags(posts: BlogPost[]): string[] {
  return Array.from(new Set(posts.flatMap(p => p.data.tags))).sort();
}
