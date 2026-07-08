import { svelte } from '@sveltejs/vite-plugin-svelte'
import inertia from 'inertiax-vite'
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import UnoCSS from 'unocss/vite'
import presetIcons from "@unocss/preset-icons"
import { presetWind4 } from 'unocss'

export default defineConfig({
  resolve: {
    alias: {
      '~vendor': 'vendor',
    }
  },
  plugins: [
    RubyPlugin(),
    UnoCSS({
      presets: [
        presetIcons(),
        presetWind4()
      ],
    }),
    // The inertia plugin is used to perform SSR in dev mode.
    // It's a no-op in production.
    inertia({
      ssr: {
        entry: 'entrypoints/inertia.js'
      },
    }),
    svelte(),
  ],
})
