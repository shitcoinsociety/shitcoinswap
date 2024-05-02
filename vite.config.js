import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { svelte } from '@sveltejs/vite-plugin-svelte';
import Unocss from 'unocss/vite'
import {presetIcons, presetUno} from 'unocss'
import extractorSvelte from '@unocss/extractor-svelte'

import { enhancedImages } from '@sveltejs/enhanced-img';

export default defineConfig({
  resolve: {
    alias: {
      '$': __dirname + '/app/frontend',
      '$lib': __dirname + '/app/frontend/lib',
      '$assets': __dirname + '/app/frontend/assets',
    }
  },
  
  plugins: [
    RubyPlugin(),
    enhancedImages(),
    svelte({
      preprocess: [
        // importAssets()
      ]
    }),
    
    Unocss({
      extractors: [
        extractorSvelte(),
      ],
      presets: [
        presetIcons({
          extraProperties: {
            'display': 'inline-block'
          }
        }),
        presetUno(),
      ]
     })
  ]
})
