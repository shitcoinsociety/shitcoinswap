import 'uno.css'

import resolve from '../lib/resolve'
import { createInertiaApp } from 'inertiax-svelte'
import createServer from 'inertiax-svelte/server'

createServer(page =>
  createInertiaApp({page, resolve}),
)