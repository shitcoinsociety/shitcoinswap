require 'digest'

InertiaRails.configure do |config|
  # We just use the file hash public/vite/manifest.json as the version (if it exists)
  if File.exist?(Rails.root.join('public', 'vite', '.vite', 'manifest.json'))
    config.version = Digest::MD5.hexdigest File.read(Rails.root.join('public', 'vite', '.vite', 'manifest.json'))
  end

  # enable default inertia rendering (warning! this will override rails default rendering behavior)
  config.default_render = true

  # ssr specific options
  config.ssr_enabled = true
  config.ssr_url = 'http://localhost:13714'
end
