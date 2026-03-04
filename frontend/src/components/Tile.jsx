import { useState, useEffect } from 'react'
import { useGameContent } from '../i18n/content'

const COLORS = {
  correct: '#6aaa64',
  present: '#c9b458',
  absent: '#787c7e',
}

export default function Tile({ value, result, animate, delay = 0, isHint = false }) {
  const { tIngredient } = useGameContent()
  const [flipped, setFlipped] = useState(!animate)
  const [showColor, setShowColor] = useState(!animate)

  useEffect(() => {
    if (!animate || !value) return
    const flipTimer = setTimeout(() => setFlipped(true), delay)
    const colorTimer = setTimeout(() => setShowColor(true), delay + 250)
    return () => {
      clearTimeout(flipTimer)
      clearTimeout(colorTimer)
    }
  }, [animate, delay, value])

  const hasValue = Boolean(value)
  const bgColor = isHint ? '#e0e0e0' : showColor && result ? COLORS[result] : hasValue ? 'var(--tile-bg)' : 'transparent'
  const textColor = isHint ? '#555' : showColor && result ? '#fff' : 'var(--text)'
  const borderColor = isHint ? '#ccc' : hasValue ? (showColor && result ? bgColor : 'var(--border)') : 'var(--light-gray)'

  return (
    <div
      style={{
        aspectRatio: '1',
        border: `2px solid ${borderColor}`,
        borderRadius: 8,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: bgColor,
        color: textColor,
        fontSize: 'clamp(0.55rem, 2.5vw, 0.75rem)',
        fontWeight: 600,
        textAlign: 'center',
        padding: 4,
        lineHeight: 1.2,
        transition: 'transform 0.3s ease, background-color 0.2s ease',
        transform: animate && !flipped ? 'rotateX(90deg)' : 'rotateX(0deg)',
        overflow: 'hidden',
        wordBreak: 'break-word',
      }}
      title={tIngredient(value) || ''}
    >
      {tIngredient(value) || ''}
    </div>
  )
}
