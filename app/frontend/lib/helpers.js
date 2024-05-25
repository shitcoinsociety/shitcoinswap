export function htmlify(text = '') {
  if (!text) return ''

  // convert to HTML entities
  text = text.replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;')
    .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')

  // convert **bold text** to <b> tags
  text = text.replace(/\*\*(.*?)\*\*/g, '<b>$1</b>')

  // convert *italics text* to <i> tags
  text = text.replace(/\*(.*?)\*/g, '<i>$1</i>')
  
  // convert _italics text_ to <i> tags
  text = text.replace(/_(.*?)_/g, '<i>$1</i>')
  
  // convert `code text` to <code> tags
  text = text.replace(/`([^`]+)`/g, '<code>$1</code>')
  
  
  // convert newlines to <br>
  text = text.replace(/\n/g, '<br>')

    // convert URLs to tags
  text = text.replace(/https?:\/\/\S+/g, '<a href="$&" target="_blank">$&</a>')

  return text
}