import { useState, useEffect } from 'react'
import Countdown from './Countdown'
import { useTranslation } from '../i18n'
import { useGameContent } from '../i18n/content'

const EMOJI_MAP = { correct: '\uD83D\uDFE9', present: '\uD83D\uDFE8', absent: '\u2B1B' }

function buildShareText(puzzleNumber, guesses, solved, hintsUsed) {
  const header = `\uD83C\uDF7D\uFE0F Dishle #${puzzleNumber} \u2014 ${solved ? guesses.length : 'X'}/6${hintsUsed > 0 ? ` (\uD83D\uDCA1${hintsUsed})` : ''}`
  const grid = guesses.map(g =>
    g.ingredients.map(i => EMOJI_MAP[i.result]).join('')
  ).join('\n')
  return `${header}\n\n${grid}\n\ndish-le.com`
}

export default function ResultModal({ solved, guesses, puzzleNumber, revealData, onClose, onStats, user, onAuth, hintsUsed = 0 }) {
  const { t } = useTranslation()
  const { tDishName, tCuisine } = useGameContent()
  const [copied, setCopied] = useState(false)
  const [imageUrl, setImageUrl] = useState(null)
  const [imageError, setImageError] = useState(false)

  const shareText = buildShareText(puzzleNumber, guesses, solved, hintsUsed)

  useEffect(() => {
    if (revealData?.image_url) {
      setImageUrl(revealData.image_url)
    } else if (revealData?.dish_name) {
      const wikiName = revealData.dish_name.replace(/\s+/g, '_')
      fetch(`https://en.wikipedia.org/api/rest_v1/page/summary/${encodeURIComponent(wikiName)}`)
        .then(r => r.json())
        .then(data => {
          if (data.thumbnail?.source) setImageUrl(data.thumbnail.source)
        })
        .catch(() => {})
    }
  }, [revealData])

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
            {solved ? '\uD83C\uDF89' : '\uD83D\uDE14'}
          </p>
          <h2 style={{ fontSize: '1.2rem', fontWeight: 700 }}>
            {solved ? t('result.won') : t('result.lost')}
          </h2>
        </div>

        {revealData && (
          <div style={{ textAlign: 'center', marginBottom: 16 }}>
            <h3 style={{ fontSize: '1.1rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: 4 }}>
              {tDishName(revealData.dish_name)}
            </h3>
            {revealData.cuisine && (
              <p style={{ fontSize: '0.75rem', color: 'var(--gray)', marginBottom: 8 }}>
                {tCuisine(revealData.cuisine)}
              </p>
            )}

            {/* Dish photo */}
            {imageUrl && !imageError ? (
              <div style={{ marginBottom: 10, borderRadius: 12, overflow: 'hidden' }}>
                <img
                  src={imageUrl}
                  alt={tDishName(revealData.dish_name)}
                  style={{ width: '100%', height: 180, objectFit: 'cover', display: 'block' }}
                  onError={() => setImageError(true)}
                />
              </div>
            ) : null}

            <p style={{ fontSize: '0.85rem', color: '#555', lineHeight: 1.4 }}>
              {revealData.description}
            </p>

            {/* Fun fact */}
            {revealData.fun_fact && (
              <div style={{
                background: '#fef9ef', border: '1px solid #f0e6cf', borderRadius: 8,
                padding: '10px 14px', marginTop: 10, textAlign: 'left',
              }}>
                <span style={{ fontSize: '0.8rem', fontWeight: 600, color: '#8b7355' }}>
                  {'\uD83D\uDCA1'} {t('result.funFact')}
                </span>
                <p style={{ fontSize: '0.8rem', color: '#555', lineHeight: 1.4, marginTop: 4 }}>
                  {revealData.fun_fact}
                </p>
              </div>
            )}
          </div>
        )}

        <div style={{ textAlign: 'center', marginBottom: 16 }}>
          <p style={{ fontSize: '0.9rem', fontWeight: 600 }}>
            {t('result.yourResult', { result: resultStr })}
            {hintsUsed > 0 && (
              <span style={{ color: 'var(--gray)', fontSize: '0.8rem', marginLeft: 6 }}>
                ({'\uD83D\uDCA1'}{hintsUsed})
              </span>
            )}
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
            {copied ? `\u2713 ${t('result.copied')}` : `\uD83D\uDCCB ${t('result.share')}`}
          </button>
          <button onClick={onStats} style={{ ...btnStyle, background: '#555' }}>
            {'\uD83D\uDCCA'} {t('result.stats')}
          </button>
        </div>

        {/* Sign-up prompt */}
        {!user && (
          <div style={{
            textAlign: 'center', marginTop: 12, padding: '12px 16px',
            background: '#f0faf0', borderRadius: 8, border: '1px solid rgba(106, 170, 100, 0.3)',
          }}>
            <p style={{ fontSize: '0.85rem', fontWeight: 600, marginBottom: 8 }}>
              {t('result.signUpPrompt')}
            </p>
            <button onClick={onAuth} style={{ ...btnStyle, background: 'var(--green)' }}>
              {t('result.signUpBtn')}
            </button>
          </div>
        )}

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
