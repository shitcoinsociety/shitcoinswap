import { UniversalConnector } from '@reown/appkit-universal-connector'

export const projectId = import.meta.env.VITE_PROJECT_ID || "4da3493c4591fd3e96fab60fc6bb73ea" // Replace with your actual project ID

// you can configure your own network


export const networks = []

export let universalConnector

export async function getUniversalConnector() {
  if (!universalConnector) {
    universalConnector = await UniversalConnector.init({
      projectId,
      metadata: {
        name: 'Universal Connector',
        description: 'Universal Connector',
        url: 'https://www.walletconnect.com',
        icons: ['https://www.walletconnect.com/icon.png']
      },
      networks: [
      ]
    })
  }
  return universalConnector
}
