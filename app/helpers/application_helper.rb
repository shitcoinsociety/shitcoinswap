module ApplicationHelper

  # TODO: Move this into the Inertia Svelte SSR renderer
  def vite_global_style_tag
    # return stylesheet_link_tag("/vite-dev/style.css", media: 'all') if Rails.env.development?

    if Rails.env.test?
      vite_folder = 'vite-test'
    else
      vite_folder = 'vite'
    end

    manifest_path = Rails.root.join('public', vite_folder, '.vite', 'manifest.json')

    return '' unless File.exist?(manifest_path)

    manifest = JSON.parse(File.read(manifest_path))

    file = manifest['style.css']['file']

    stylesheet_link_tag("/#{vite_folder}/#{file}", media: 'all')
  end
end
