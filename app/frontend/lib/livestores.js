import { createConsumer } from "@rails/actioncable"
import { writable } from 'svelte/store'

let consumer

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

export function subscribe(subject, subscriptionId) {
  if (typeof document == 'undefined') return
  if (!consumer) consumer = createConsumer()

  if (!subject && subscriptions[subscriptionId]) {
    const subscription = subscriptions[subscriptionId]
    delete subscriptions[subscriptionId]
    consumer.subscriptions.remove(subscription)
    return
  }

  if (!subject) return

  const subscription = subscriptions[subscriptionId] ||= consumer.subscriptions.create({ channel: "LiveStoresChannel", subject }, {
    received: function(data) {
      getStore(data.store_id).handle(data.action, data)
    }
  })

  return function unsubscribe() {
    delete subscriptions[subscriptionId]
    consumer.subscriptions.remove(subscription)
  }
}