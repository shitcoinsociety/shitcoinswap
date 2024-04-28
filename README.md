# Shitcoin Swap

[![CircleCI](https://circleci.com/gh/shitcoinswap/launchpad.svg?style=shield)](https://circleci.com/gh/shitcoinswap/launchpad)

Here we go again.

This is the Shitcoin Swap Launchpad, the perfect place to launch, promote, and trade your own ~shitcoins~ revolutionary decentralized currencies.

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
