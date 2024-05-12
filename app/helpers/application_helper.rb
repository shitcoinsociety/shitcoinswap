module ApplicationHelper
  def component_stylesheet_tags
    return '' if Rails.env.development?

    manifest = JSON.parse(File.read(Rails.root.join('public', 'vite', '.vite', 'manifest.json')))

    # TODO: get these from the inertia page object somehow
    component = "pages/#{controller.controller_path}/#{controller.action_name}.svelte"
    layout = "layouts/default.svelte"

    component_css_files = manifest.dig(component, 'css')
    layout_css_files = manifest.dig(layout, 'css')

    ((component_css_files || []) + (layout_css_files || [])).map do |file|
      stylesheet_link_tag("/vite/#{file}", media: 'all')
    end.join.html_safe
  end
end
