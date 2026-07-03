<script>
  const { slug } = $props()

  const { default: NewsComponent, metadata } = await import(`~/pages/news/_${slug}.md`)
  const { default: img } = await import(`~/pages/news/_${metadata.image}.png`, {eager: true, import: 'default'})
  
</script>

<svelte:head>
  <title>{metadata.title}</title>
  <meta name="description" content={metadata.description} />
</svelte:head>

<img src={img} alt={metadata.title} />

<NewsComponent />