const pages = import.meta.glob('$/pages/**/*.svelte')
console.log(pages)
export default async name => {
  let layoutPath, componentPath
  // if (name.startsWith('dashboard/')) {
  //   componentPath = `./${name}.svelte`
  //   layoutPath = "./dashboard/_layout.svelte"
  // }
  // else {
    componentPath = `/pages/${name}.svelte`
    layoutPath = `/pages/_layout.svelte`      
  // }
  
  if (!pages[componentPath]) throw new Error(`Unknown page ${componentPath}`)
  if (!pages[layoutPath]) throw new Error(`Unknown layout ${layoutPath}`)
  const page = await pages[componentPath]()
  const layout = await pages[layoutPath]()
  return Object.assign({
    layout: layout.default
  }, page)
}