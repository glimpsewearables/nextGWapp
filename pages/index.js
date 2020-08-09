import Head from 'next/head'
import Design from '../Components'
export default function Home() {
  return (
    <div>
      <Head>
        <title>WiFi App</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
      </Head>
      <Design/>
    </div>
  )
}
