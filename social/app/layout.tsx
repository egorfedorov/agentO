import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Agent-O Leaderboard — Global Pet Rankings',
  description: 'See the top Agent-O pets worldwide. Level up your ASCII Tamagotchi, earn achievements, and climb the leaderboard.',
  openGraph: {
    title: 'Agent-O Leaderboard',
    description: 'Global rankings for Agent-O ASCII desktop companions',
    siteName: 'Agent-O',
  },
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
