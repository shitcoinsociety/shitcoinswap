# Shitcoin Swap

[![CircleCI](https://circleci.com/gh/buhrmi/shitcoinswap.svg?style=shield)](https://circleci.com/gh/buhrmi/shitcoinswap)

Shitcoin Swap is an open source trading platform under constant development. It serves as a foundation to integrate and trade with highly experimental, high-risk crypto assets.

## Why Open Source?

The reason is rather egoistic: I'm hoping that by developing this app in the open it will be easier to accrue help from blockchain developers when it comes to integrating new platforms.

## Run locally

This is a pretty straight-forward Ruby on Rails app built with [Inertia](https://inertiajs.com) and [Svelte](https://svelte.dev).

To set up your local environment, first clone the repo, initialize and build submodules, install dependencies, and then start the app.

### Inside a dev container

Coming soon

### Without dev containers

#### Clone the repo

```
git clone git@github.com:buhrmi/shitcoinswap.git
```

#### Install dependencies

```
npm i
bundle
```

#### Start the app

The easiest way to run all the processes in development is to use `foreman`. Install it with `bundle install foreman` if you didn't already.

```
foreman s -f Procfile.dev
```
