import '@unocss/reset/tailwind.css'
import 'virtual:uno.css'

import { createInertiaApp } from "inertiax-svelte"

import Default from "~/layouts/default.svelte"

createInertiaApp({
  pages: "../pages",
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
