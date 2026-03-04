import { useState } from 'react'
import { submitFeedback } from '../api'
import { useTranslation } from '../i18n'

const MAX_CHARS = 500
const COOLDOWN_MS = 5 * 60 * 1000

export default function FeedbackModal({ onClose }) {
  const { t } = useTranslation()
  const [body, setBody] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [success, setSuccess] = useState(false)
  const [error, setError] = useState('')

  function getCooldownRemaining() {
    const last = localStorage.getItem('dishle_feedback_ts')
    if (!last) return 0
    const diff = COOLDOWN_MS - (Date.now() - Number(last))
    return diff > 0 ? diff : 0
  }

  const cooldown = getCooldownRemaining()
  const cooldownMin = Math.ceil(cooldown / 60000)

  async function handleSubmit(e) {
    e.preventDefault()
    if (!body.trim() || body.length > MAX_CHARS || submitting) return

    if (getCooldownRemaining() > 0) {
      setError(t('feedback.cooldown'))
      return
    }

    setSubmitting(true)
    setError('')

    try {
      const res = await submitFeedback(body.trim())
      if (res.error) {
        setError(res.error)
      } else {
        localStorage.setItem('dishle_feedback_ts', String(Date.now()))
        setSuccess(true)
      }
    } catch {
      setError(t('feedback.error'))
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>

        <h2 style={{ fontSize: '1.2rem', fontWeight: 700, marginBottom: 16, textAlign: 'center' }}>
          {t('feedback.title')}
        </h2>

        {success ? (
          <div style={{ textAlign: 'center', padding: '20px 0' }}>
            <p style={{ fontSize: '1.5rem', marginBottom: 8 }}>✓</p>
            <p style={{ fontWeight: 600 }}>{t('feedback.success')}</p>
          </div>
        ) : (
          <form onSubmit={handleSubmit}>
            {cooldown > 0 && (
              <p style={{ color: 'var(--gray)', fontSize: '0.85rem', marginBottom: 12, textAlign: 'center' }}>
                {t('feedback.cooldown')} ({cooldownMin} min)
              </p>
            )}

            <textarea
              value={body}
              onChange={e => setBody(e.target.value.slice(0, MAX_CHARS))}
              placeholder={t('feedback.placeholder')}
              disabled={submitting || cooldown > 0}
              rows={5}
              style={{
                width: '100%',
                padding: 12,
                border: '2px solid var(--border)',
                borderRadius: 8,
                fontSize: '0.9rem',
                resize: 'vertical',
                outline: 'none',
                fontFamily: 'inherit',
                boxSizing: 'border-box',
              }}
            />

            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: 8 }}>
              <span style={{
                fontSize: '0.75rem',
                color: body.length > MAX_CHARS * 0.9 ? '#e74c3c' : 'var(--gray)',
              }}>
                {body.length}/{MAX_CHARS}
              </span>
              <button
                type="submit"
                disabled={submitting || !body.trim() || body.length > MAX_CHARS || cooldown > 0}
                style={{
                  padding: '10px 24px',
                  background: (submitting || !body.trim() || cooldown > 0) ? 'var(--light-gray)' : 'var(--green)',
                  color: '#fff',
                  border: 'none',
                  borderRadius: 8,
                  fontSize: '0.9rem',
                  fontWeight: 600,
                }}
              >
                {submitting ? '...' : t('feedback.submit')}
              </button>
            </div>

            {error && (
              <p style={{ color: '#e74c3c', fontSize: '0.85rem', marginTop: 8, textAlign: 'center' }}>
                {error}
              </p>
            )}
          </form>
        )}
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
