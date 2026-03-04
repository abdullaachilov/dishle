import { useState, useEffect } from 'react'

function getTimeUntilMidnightUTC() {
  const now = new Date()
  const tomorrow = new Date(Date.UTC(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() + 1))
  const diff = tomorrow - now
  const hours = Math.floor(diff / (1000 * 60 * 60))
  const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
  const seconds = Math.floor((diff % (1000 * 60)) / 1000)
  return { hours, minutes, seconds }
}

export default function Countdown() {
  const [time, setTime] = useState(getTimeUntilMidnightUTC())

  useEffect(() => {
    const interval = setInterval(() => {
      setTime(getTimeUntilMidnightUTC())
    }, 1000)
    return () => clearInterval(interval)
  }, [])

  const pad = (n) => String(n).padStart(2, '0')

  return (
    <div style={{ color: 'var(--gray)', fontSize: '0.85rem' }}>
      <span>Next Dishle in </span>
      <span style={{ fontWeight: 700, fontVariantNumeric: 'tabular-nums' }}>
        {pad(time.hours)}:{pad(time.minutes)}:{pad(time.seconds)}
      </span>
    </div>
  )
}
