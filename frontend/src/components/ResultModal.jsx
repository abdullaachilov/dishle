import { useState } from 'react'
import Countdown from './Countdown'
import { useTranslation } from '../i18n'

const EMOJI_MAP = { correct: '🟩', present: '🟨', absent: '⬛' }

function buildShareText(puzzleNumber, guesses, solved) {
  const header = `🍽️ Dishle #${puzzleNumber} — ${solved ? guesses.length : 'X'}/6`
  const grid = guesses.map(g =>
    g.ingredients.map(i => EMOJI_MAP[i.result]).join('')
  ).join('\n')
  return `${header}\n\n${grid}\n\ndish-le.com`
}

export default function ResultModal({ solved, guesses, puzzleNumber, revealData, onClose, onStats }) {
  const { t } = useTranslation()
  const [copied, setCopied] = useState(false)

  const shareText = buildShareText(puzzleNumber, guesses, solved)

  function handleShare() {
    navigator.clipboard.writeText(shareText).then(() => {
      setCopied(true)
      setTimeout(() => setCopied(false), 2000)
    }).catch(() => {})
  }

  const resultStr = solved ? guesses.length : 'X'

  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>

        <div style={{ textAlign: 'center', marginBottom: 16 }}>
          <p style={{ fontSize: '1.5rem', marginBottom: 4 }}>
            {solved ? '🎉' : '😔'}
          </p>
          <h2 style={{ fontSize: '1.2rem', fontWeight: 700 }}>
            {solved ? t('result.won') : t('result.lost')}
          </h2>
        </div>

        {revealData && (
          <div style={{ textAlign: 'center', marginBottom: 16 }}>
            <h3 style={{ fontSize: '1.1rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: 4 }}>
              {revealData.dish_name}
            </h3>
            {revealData.cuisine && (
              <p style={{ fontSize: '0.75rem', color: 'var(--gray)', marginBottom: 6 }}>
                {revealData.cuisine}
              </p>
            )}
            <p style={{ fontSize: '0.85rem', color: '#555', lineHeight: 1.4 }}>
              {revealData.description}
            </p>
          </div>
        )}

        <div style={{ textAlign: 'center', marginBottom: 16 }}>
          <p style={{ fontSize: '0.9rem', fontWeight: 600 }}>
            {t('result.yourResult', { result: resultStr })}
          </p>
        </div>

        <pre style={{
          textAlign: 'center',
          fontSize: '1.1rem',
          lineHeight: 1.6,
          margin: '0 auto 16px',
          fontFamily: 'inherit',
          whiteSpace: 'pre-wrap',
        }}>
          {shareText}
        </pre>

        <div style={{ display: 'flex', gap: 8, justifyContent: 'center', flexWrap: 'wrap' }}>
          <button onClick={handleShare} style={btnStyle}>
            {copied ? `✓ ${t('result.copied')}` : `📋 ${t('result.share')}`}
          </button>
          <button onClick={onStats} style={{ ...btnStyle, background: '#555' }}>
            📊 {t('result.stats')}
          </button>
        </div>

        <div style={{ textAlign: 'center', marginTop: 16 }}>
          <Countdown />
        </div>
      </div>
    </div>
  )
}

const overlayStyle = {
  position: 'fixed',
  inset: 0,
  background: 'rgba(0,0,0,0.5)',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  zIndex: 1000,
  padding: 16,
}

const modalStyle = {
  background: '#fff',
  borderRadius: 16,
  padding: '28px 24px',
  maxWidth: 400,
  width: '100%',
  maxHeight: '90vh',
  overflowY: 'auto',
  position: 'relative',
}

const closeStyle = {
  position: 'absolute',
  top: 12,
  right: 16,
  background: 'none',
  border: 'none',
  fontSize: '1.4rem',
  color: 'var(--gray)',
  cursor: 'pointer',
}

const btnStyle = {
  padding: '10px 20px',
  background: 'var(--green)',
  color: '#fff',
  border: 'none',
  borderRadius: 8,
  fontSize: '0.9rem',
  fontWeight: 600,
}
