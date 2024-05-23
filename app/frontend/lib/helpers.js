export function htmlify(text = '') {
  if (!text) return ''

  // convert to HTML entities
  text = text.replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
    .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')

  // convert URLs to links
  text = text.replace(/(https?:\/\/[^\s]+)/g, '<a href="$1" target="_blank">$1</a>')

  // convert newlines to <br>
  text = text.replace(/\n/g, '<br>')

  return text
}