import '@unocss/reset/tailwind.css'
import 'virtual:uno.css'
import 'virtual:unocss-devtools'
import '../lib/browser.css'

import "toastify-js/src/toastify.css"

import { hydrate, mount } from 'svelte'
import { createInertiaApp, router } from 'inertiax-svelte'

import resolve from '../lib/resolve'


createInertiaApp({ 
  resolve,
  setup({ el, App, props }) {
    // We don't have an SSR server during test
    if (window.RAILS_ENV == 'test') {
      mount(App, { target: el, props })
    }
    else {
      hydrate(App, { target: el, props })
    }

  },
})

window.addEventListener('message', async function(event) {
  if (event.data == 'logged_in') {
    router.reload()
  }
})
