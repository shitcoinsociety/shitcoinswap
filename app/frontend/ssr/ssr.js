import 'uno.css'

import resolve from '../lib/resolve'
import { createInertiaApp } from '@inertiajs/svelte'
import createServer from '@inertiajs/svelte/server'

createServer(page =>
  createInertiaApp({page, resolve}),
)