import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { svelte } from '@sveltejs/vite-plugin-svelte';
import Unocss from 'unocss/vite'
import {presetIcons, presetUno} from 'unocss'
import extractorSvelte from '@unocss/extractor-svelte'
import { importAssets } from 'svelte-preprocess-import-assets'
import { imagetools } from 'vite-imagetools'

export default defineConfig({
  resolve: {
    alias: {
      '$': __dirname + '/app/frontend',
      '$lib': __dirname + '/app/frontend/lib',
      '$assets': __dirname + '/app/frontend/assets',
    }
  },
  build: {
    cssCodeSplit: false
  },
  plugins: [
    Unocss({
      extractors: [
        extractorSvelte(),
      ],
      presets: [
        presetUno(),
        presetIcons({
          extraProperties: {
            'display': 'inline-block',
            'vertical-align': 'middle',
          }
        })
      ]
    }),
    imagetools({}),
    RubyPlugin(),
    svelte({
      preprocess: [
        importAssets()
      ]
    }),
  ]
})
