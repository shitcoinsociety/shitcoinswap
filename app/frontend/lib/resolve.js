const pages = import.meta.glob('~/pages/**/*.svelte')
const layouts = import.meta.glob('~/layouts/**/*.svelte')

export default async name => {
  let layoutPath, componentPath
  // if (name.startsWith('dashboard/')) {
  //   componentPath = `./${name}.svelte`
  //   layoutPath = "./dashboard/_layout.svelte"
  // }
  // else {
    componentPath = `/pages/${name}.svelte`
    layoutPath = `/layouts/default.svelte`      
  // }
  
  if (!pages[componentPath]) throw new Error(`Unknown page ${componentPath}`)
  if (!layouts[layoutPath]) throw new Error(`Unknown layout ${layoutPath}`)
  const page = await pages[componentPath]()
  const layout = await layouts[layoutPath]()
  return Object.assign({
    layout: layout.default
  }, page)
}