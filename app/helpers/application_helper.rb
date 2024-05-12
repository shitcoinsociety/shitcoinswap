module ApplicationHelper

  # TODO: Move this into the Inertia Svelte SSR renderer
  def component_stylesheet_tags
    return '' if Rails.env.development?
    if Rails.env.test?
      vite_folder = 'vite-test'
    else
      vite_folder = 'vite'
    end

    manifest_path = Rails.root.join('public', vite_folder, '.vite', 'manifest.json')

    manifest = JSON.parse(File.read(manifest_path))

    component = "pages/#{controller.controller_path}/#{controller.action_name}.svelte"
    layout = "layouts/default.svelte"

    component_css_files = manifest.dig(component, 'css')
    layout_css_files = manifest.dig(layout, 'css')

    ((component_css_files || []) + (layout_css_files || [])).map do |file|
      stylesheet_link_tag("/#{vite_folder}/#{file}", media: 'all')
    end.join.html_safe
  end
end
