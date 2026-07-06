import { vitePreprocess } from '@sveltejs/vite-plugin-svelte'
import { importAssets } from 'svelte-preprocess-import-assets'
import { mdsvex } from 'mdsvex'

export default {
  // Consult https://svelte.dev/docs#compile-time-svelte-preprocess
  // for more information about preprocessors
  extensions: ['.svelte', '.md'],
  preprocess: [
    vitePreprocess(),
    importAssets(),
    mdsvex({
      extensions: ['.md']
    }),
  ],
  compilerOptions: {
    experimental: {
      async: true,
    },
  },
}
