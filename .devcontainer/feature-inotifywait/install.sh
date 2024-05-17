apt-get update -qq && \
  apt-get install --no-install-recommends -y \
    inotify-tools

rm -rf /var/lib/apt/lists/*