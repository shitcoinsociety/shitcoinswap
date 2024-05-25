// import 'tippy.js/dist/tippy.css'
import 'tippy.js/themes/material.css'
import tippy from 'tippy.js'

export default function(el, contentOrOptions) {
  const options = typeof(contentOrOptions) == 'string'
    ? {content: contentOrOptions}
    : contentOrOptions
  options.theme = 'material'
  const instance = tippy(el, options)
  
  return {
    destroy() {
      instance.destroy(true)
    }
  }
}