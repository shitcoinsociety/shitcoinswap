import '@unocss/reset/tailwind.css'
import 'virtual:uno.css'
import 'virtual:unocss-devtools'
import './browser.css'

import "toastify-js/src/toastify.css"

import { mount } from 'svelte'
import { createInertiaApp, router } from '@inertiajs/svelte'

import resolve from './lib/resolve'


createInertiaApp({ 
  resolve,
  setup({ el, App, props }) {
    mount(App, { target: el, hydrate: true, props })
  },
})

window.addEventListener('message', async function(event) {
  if (event.data == 'logged_in') {
    router.reload()
  }
})
