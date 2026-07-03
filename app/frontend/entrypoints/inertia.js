import '@unocss/reset/tailwind.css'
import 'virtual:uno.css'
import '~/assets/global.css'

import { createInertiaApp } from "inertiax-svelte"

import Default from "~/layouts/default.svelte"

createInertiaApp({
  pages: {
    path: "../pages",
    extensions: [".svelte", ".md"],
    lazy: true
  },
  layout: () => Default,
  defaults: {
    form: {
      forceIndicesArrayFormatInFormData: false,
      withAllErrors: true,
    },
    visitOptions: () => {
      return { queryStringArrayFormat: "brackets" }
    },
  },
})
