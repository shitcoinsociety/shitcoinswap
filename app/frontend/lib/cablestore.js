import { createConsumer } from "@rails/actioncable"
import { writable } from 'svelte/store'

const consumer = createConsumer()

const stores = {}
const subscriptions = {}

function writableWithEvents(initial = null) {
  const store = writable(initial)
  const callbacks = {}
  store.on = function(event, callback) {
    callbacks[event] = callback
    return store
  }
  store.handle = function(event, data) {
    if (callbacks[event]) {
      callbacks[event](data)
    }
    return store
  }
  store.on('set', function(data) {
    store.set(data.value)
  })
  store.on('update', function(data) {
    store.update(function($data) {
      return Object.assign($data || {}, data.changes)
    })
  })
  store.on('append', function(data) {
    store.update(function($data) {
      return ($data || []).concat(data.value)
    })
  })
  store.on('append_to', function(data) {
    store.update(function($data) {
      $data[data.key] ||= []
      $data[data.key] = $data[data.key].concat(data.value)
      return $data
    })
  })
  store.on('update_by', function(data) {
    store.update(function($data) {
      return ($data || []).map(function(item) {
        if (item[data.key] == data.value) {
          return Object.assign(item, data.changes)
        } else {
          return item
        }
      })
    })
  })
  store.on('update_by_id_in', function(data) {
    store.update(function($data) {
      $data[data.key] ||= []
      for (let i = 0; i < $data[data.key].length; i++) {
        if ($data[data.key][i].id == data.id) {
          $data[data.key][i] = Object.assign($data[data.key][i], data.changes)
          return $data
        }
      }
      return $data
    })
  })
  store.on('delete_by', function(data) {
    store.update(function($data) {
      return ($data || []).filter(function(item) {
        return item[data.key] != data.value
      })
    })
  })
  return store
}

export function getStore(storeId, initial = null) {
  return stores[storeId] ||= writableWithEvents(initial)
}

export function perform(storeId, action, ...args) {
  return getStore(storeId).perform(action, ...args)
}

export function subscribe(subject, initial = null, store_id = subject) {
  if (subscriptions[store_id] && !subject) {
    consumer.subscriptions.remove(subscriptions[store_id])
    subscriptions[store_id] = null
  }
  if (!subject) {
    const store = getStore(store_id, null)
    store.set(null)
    return store
  }
  const defaultStore = getStore(store_id, initial)
  const subscription = subscriptions[store_id] ||= consumer.subscriptions.create({ channel: "CableStoreChannel", subject }, {
    received: function(data) {
      getStore(data.store_id || store_id).handle(data.action, data)
    }
  })

  defaultStore.perform = function(action, ...args) {
    return subscription.perform(action, {args})
  }
  defaultStore.unsubscribe = function() {
    subscriptions[store_id] = null
    consumer.subscriptions.remove(subscription)
  }
  return defaultStore
}