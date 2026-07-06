<script>
  const { slug } = $props()

  const { default: NewsComponent, metadata } = await import(`~/pages/news/_${slug}.md`)
  const { default: img } = await import(`~/pages/news/_${metadata.image}.png`, {eager: true, import: 'default'})
  const raw = await import(`~/pages/news/_${slug}.md?raw`)

  const wordCount = raw.default
    .replace(/^---[\s\S]*?---/m, '')
    .replace(/[#*[\]()!>_`|-]/g, '')
    .split(/\s+/)
    .filter(Boolean)
    .length

  const readTime = Math.max(1, Math.ceil(wordCount / 200))

  const authors = (metadata.authors || []).map(a => ({
    ...a,
    avatar: `${a.github}.png`
  }))

  let copied = $state(false)
  async function copyLink() {
    await navigator.clipboard.writeText(window.location.href)
    copied = true
    setTimeout(() => copied = false, 2000)
  }

  const shareImage = `https://shitcoinsociety.com${img}`
  const shareUrl = `https://shitcoinsociety.com/news/${slug}`
</script>

<svelte:head>
  <title>{metadata.title}</title>
  <meta name="description" content={metadata.description} />

  <meta property="og:title" content={metadata.title} />
  <meta property="og:description" content={metadata.description} />
  <meta property="og:image" content={shareImage} />
  <meta property="og:url" content={shareUrl} />
  <meta property="og:type" content="article" />
  <meta property="og:site_name" content="Shitcoin Society" />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content={metadata.title} />
  <meta name="twitter:description" content={metadata.description} />
  <meta name="twitter:image" content={shareImage} />
</svelte:head>

<header>
  <figure class="post-hero">
    <img src={img} alt={metadata.title} />
    <figcaption class="post-hero-overlay">
    <div class="container">
      <div class="badge badge-dark">{metadata.category}</div>
      <h1 class="post-title max-w-150">{metadata.title}</h1>
    </div>
    </figcaption>
  </figure>
</header>


<article class="container">
  <div class="post-meta">
    <time class="post-date" datetime={metadata.date || ''}>
      {metadata.date || ''}
    </time>
    <span class="post-divider">·</span>
    <span class="post-readtime">{readTime} min read</span>
    <button class="btn btn-copy" onclick={copyLink}>
      {#if copied}
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="14" height="14">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
        Copied
      {:else}
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="14" height="14">
          <rect x="9" y="9" width="13" height="13" rx="2" ry="2"/>
          <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>
        </svg>
        Copy link
      {/if}
    </button>
  </div>

  {#if authors.length}
    <div class="flex items-center gap-3 mb-4">
      <div class="flex gap-1">
        {#each authors as author}
          <a href={author.github} target="_blank" rel="noopener noreferrer">
            <img class="avatar avatar-md" src={author.avatar} alt={author.name} />
          </a>
        {/each}
      </div>
      <span class="text-sm text-gray-400">
        by
        {#each authors as author, i}
          {#if i > 0}, {/if}
          <a class="post-author-link" href={author.github} target="_blank" rel="noopener noreferrer">
            {author.name}
          </a>
        {/each}
      </span>
    </div>
  {/if}
  
  <div>
    <NewsComponent />
  </div>
</article>

<style>
  /* ===== Post / Article Page ===== */
.post-hero { position: relative; overflow: hidden; }
.post-hero img {
  width: 100%;
  max-height: 60vh;
  object-fit: cover;
  display: block;
}
.post-hero-overlay {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  align-items: flex-start;
  gap: .5rem;
  padding-block: var(--padding);
  background: linear-gradient(to bottom, transparent 30%, rgba(0,0,0,.7));
}
.post-title {
  font-size: clamp(1.4rem, 5vw, 2.6rem);
  font-weight: 800;
  line-height: 1.2;
  color: #fff;
  margin: 0;
  text-wrap: balance;
  text-shadow: 0 2px 8px rgba(0,0,0,.5);
}

.post-meta      { margin-top: 1.5rem; margin-bottom: 1rem; display: flex; flex-wrap: wrap; align-items: center; gap: .5rem; }
.post-date      { font-size: .8rem; color: #666; }
.post-divider   { color: #ccc; font-size: .8rem; }
.post-readtime  { font-size: .8rem; color: #888; }
.post-author-link       { color: #555; font-weight: 500; text-decoration: none; font-size: .8rem; }
.post-author-link:hover { color: #1a1a2e; text-decoration: underline; }
</style>