# Shitcoin Swap

[![CircleCI](https://circleci.com/gh/shitcoinswap/launchpad.svg?style=shield)](https://circleci.com/gh/shitcoinswap/launchpad)

Here we go again.

Welcome to Shitcoin Swap, the perfect place to launch, promote, and trade your own ~shitcoins~ revolutionary decentralized currencies.

## Why Open Source?

We want to provide an open platform that can easily integrate with any current and upcoming decentralized networks. At first, we were searching for some kind of standardized protocol or API that would allow platforms like ours to easily communicate with these networks. However, we did not find any. That's why we're (currently) developing this platform in the open, allowing developers to implement network integrations as straight-forward Ruby modules.

## Contributing

This is a pretty straight-forward Ruby on Rails app built with Inertia and Svelte. To contribute and develop new features, you'll have to set up your local development enviroment.

To do this, first clone the repo, initialize and build submodules, install dependencies, and then start the app.

### Clone the repo

```
git clone git@github.com:shitcoinswap/launchpad.git
```

### Initialize and build submodules

We're using our [own fork of Inertia](https://github.com/buhrmi/inertia) because it adds some important features that makes development easier.

```
git submodule init
git submodule update
cd vendor/inertia
npm i
npm run build --workspace=packages --if-present
```

### Install dependencies

```
npm i
bundle
```

### Start the app

The easiest way to run all the processes in development is to use `foreman`. Install it with `bundle install foreman` if you didn't already.

```
foreman s -f Procfile.dev
```
