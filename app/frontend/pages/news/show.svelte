<script>
  const { slug } = $props()

  const { default: NewsComponent, metadata } = await import(`~/pages/news/_${slug}.md`)
  const { default: img } = await import(`~/pages/news/_${metadata.image}.png`, {eager: true, import: 'default'})
</script>

<svelte:head>
  <title>{metadata.title} — Shitcoin Society</title>
  <meta name="description" content={metadata.description} />
</svelte:head>

<header class="full-width">
  <figure class="pr-hero full-width">
    <img src={img} alt={metadata.title} />
    <figcaption class="pr-hero-overlay">
      <div class="pr-badge">Press Release</div>
      <h1 class="pr-hero-title">{metadata.title}</h1>
    </figcaption>
  </figure>
</header>

<main>
  <article>
    <header>
      <div class="pr-meta">
        <time class="pr-date" datetime={metadata.date || ''}>
          {metadata.date || ''}
        </time>
      </div>
    </header>
    
    <div class="pr-body">
      <NewsComponent />
    </div>
  </article>
</main>

<style>
  .pr-hero {
    position: relative;
    overflow: hidden;
  }

  .pr-hero img {
    width: 100%;
    max-height: 60vh;
    object-fit: cover;
    display: block;
  }

  .pr-hero-overlay {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: flex-start;
    gap: 0.5rem;
    padding: var(--padding);
    background: linear-gradient(
      to bottom,
      transparent 30%,
      rgba(0, 0, 0, 0.7) 100%
    );
  }

  .pr-hero-title {
    font-size: clamp(1.4rem, 5vw, 2.6rem);
    font-weight: 800;
    line-height: 1.2;
    color: #fff;
    margin: 0;
    text-wrap: balance;
    text-shadow: 0 2px 8px rgba(0, 0, 0, 0.5);
  }

  .pr-meta {
    margin-top: 1.5rem;
    margin-bottom: 0.5rem;
  }

  .pr-badge {
    display: inline-block;
    background: #1a1a2e;
    color: #fff;
    font-size: 0.7rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    padding: 0.25rem 0.65rem;
    border-radius: 4px;
  }

  .pr-date {
    font-size: 0.85rem;
    color: #888;
    margin-left: 0.75rem;
  }
</style>