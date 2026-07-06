<script>
  const posts = import.meta.glob('./_*.md', { eager: true, import: 'metadata' })
  const images = import.meta.glob('./_*.png', { eager: true, import: 'default' })

  const articles = Object.entries(posts)
    .map(([path, meta]) => {
      const slug = path.match(/\.\/_(.+)\.md$/)[1]
      const img = images[`./_${meta.image}.png`] ?? null
      const authors = (meta.authors || []).map(a => ({
        ...a,
        avatar: `${a.github}.png`
      }))
      return { slug, ...meta, img, authors }
    })
    .sort((a, b) => new Date(b.date) - new Date(a.date))
</script>

<svelte:head>
  <title>Shitcoin Society - Brokerage tools for a new generation of digital assets</title>
  <meta name="description" content="Startup shares, vesting schedules, and equity instruments — created in the middle of Central Vietnam's digital finance sandbox." />
</svelte:head>

<header class="hero">
  <section class="container">
    <img src={"/logo_white.svg"} class="h-8 mb-36" alt="Shitcoin Society" />
    <h1 class="hero-title">Infrastructure for a New&nbsp;Generation of Digital&nbsp;Assets.</h1>
    <p class="hero-sub">
      On-Chain startup shares, vesting schedules, and equity instruments
       — in the middle of
      Central Vietnam's digital finance sandbox.
    </p>
    <div class="inline-flex gap-3 flex-wrap">
      <a href="/news/shitcoin-society-launches-tokenization-services" class="btn btn-primary">
        Read the announcement
      </a>
      <a href="https://github.com/shitcoinsociety" target="_blank" rel="noopener noreferrer" class="btn btn-dark">
        View Repositories
      </a>
    </div>
  </section>
</header>


<section class="container">
  <h2 class="text-xl font-bold pt-10 mb-0">Latest News</h2>
  <div class="grid grid-cols-1 sm:grid-cols-2 gap-8 py-8">
  {#each articles as article}
    <a href="/news/{article.slug}" class="card">
      {#if article.img}
        <figure class="card-img">
          <img src={article.img} alt={article.title} />
          <figcaption class="card-overlay">
            <span class="badge badge-light">{article.category}</span>
          </figcaption>
        </figure>
      {/if}
      <div class="card-body">
        <div class="card-meta">
          <time datetime={article.date}>{article.date}</time>
        </div>
        <h2 class="card-title">{article.title}</h2>
        {#if article.authors.length}
          <div class="author-row">
            <div class="flex">
              {#each article.authors as author}
                <img class="avatar avatar-sm" src={author.avatar} alt={author.name} />
              {/each}
            </div>
            <span class="author-names">
              {#each article.authors as author, i}
                {#if i > 0}, {/if}{author.name}
              {/each}
            </span>
          </div>
        {/if}
      </div>
    </a>
  {/each}
  </div>
</section>



<style>
/* ===== Hero (Landing Page) ===== */
.hero {
  color: white;
  background: linear-gradient(rgba(0,0,0,0.25) 40%, rgba(21, 43, 70, 0.55)), url('./_index.png');
  background-size: cover;
  padding-block: 2rem 8rem;
  text-align: left;
  background-position: center;

}
.hero-title {
  font-size: clamp(2rem, 6vw, 3.4rem);
  font-weight: 800;
  line-height: 1.1;
  letter-spacing: -.03em;
  margin-bottom: 1rem;
}
.hero-sub {
  font-size: 1.05rem;
  line-height: 1.7;
  margin-bottom: 1.75rem;
}
</style>