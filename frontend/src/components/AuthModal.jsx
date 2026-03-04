import { useState } from 'react'
import { register, login } from '../api'
import { saveToken } from '../storage'
import { useTranslation } from '../i18n'

export default function AuthModal({ onClose, onAuth }) {
  const { t } = useTranslation()
  const [mode, setMode] = useState('login')
  const [nickname, setNickname] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  async function handleSubmit(e) {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      const res = mode === 'register'
        ? await register(nickname, password)
        : await login(nickname, password)

      if (res.error) {
        setError(res.error)
      } else {
        saveToken(res.data.token)
        onAuth(res.data.user)
        onClose()
      }
    } catch {
      setError(t('auth.error'))
    } finally {
      setLoading(false)
    }
  }

  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>

        <h2 style={{ textAlign: 'center', fontSize: '1.1rem', fontWeight: 700, marginBottom: 20 }}>
          {mode === 'login' ? t('auth.signIn') : t('auth.signUp')}
        </h2>

        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: 12 }}>
            <label style={labelStyle}>{t('auth.nickname')}</label>
            <input
              type="text"
              value={nickname}
              onChange={e => setNickname(e.target.value.replace(/[^a-zA-Z0-9_]/g, '').slice(0, 20))}
              placeholder={t('auth.nicknamePlaceholder')}
              autoComplete="username"
              style={inputStyle}
            />
          </div>

          <div style={{ marginBottom: 16 }}>
            <label style={labelStyle}>{t('auth.password')}</label>
            <input
              type="password"
              value={password}
              onChange={e => setPassword(e.target.value.slice(0, 72))}
              placeholder={t('auth.passwordPlaceholder')}
              autoComplete={mode === 'register' ? 'new-password' : 'current-password'}
              style={inputStyle}
            />
          </div>

          {error && (
            <p style={{ color: '#e74c3c', fontSize: '0.8rem', marginBottom: 12, textAlign: 'center' }}>
              {error}
            </p>
          )}

          <button
            type="submit"
            disabled={loading || nickname.length < 3 || password.length < 8}
            style={{
              ...submitStyle,
              opacity: loading || nickname.length < 3 || password.length < 8 ? 0.5 : 1,
            }}
          >
            {loading ? '...' : mode === 'login' ? t('auth.signIn') : t('auth.signUp')}
          </button>
        </form>

        <p style={{ textAlign: 'center', fontSize: '0.8rem', marginTop: 16, color: 'var(--gray)' }}>
          {mode === 'login' ? t('auth.noAccount') + ' ' : t('auth.hasAccount') + ' '}
          <button
            onClick={() => { setMode(mode === 'login' ? 'register' : 'login'); setError('') }}
            style={switchStyle}
          >
            {mode === 'login' ? t('auth.signUp') : t('auth.signIn')}
          </button>
        </p>
      </div>
    </div>
  )
}

const overlayStyle = {
  position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.5)',
  display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: 16,
}

const modalStyle = {
  background: '#fff', borderRadius: 16, padding: '28px 24px',
  maxWidth: 360, width: '100%', position: 'relative',
}

const closeStyle = {
  position: 'absolute', top: 12, right: 16, background: 'none', border: 'none',
  fontSize: '1.4rem', color: 'var(--gray)', cursor: 'pointer',
}

const labelStyle = {
  display: 'block', fontSize: '0.8rem', fontWeight: 600, marginBottom: 4, color: 'var(--text)',
}

const inputStyle = {
  width: '100%', padding: '10px 12px', border: '2px solid var(--border)', borderRadius: 8,
  fontSize: '0.9rem', outline: 'none',
}

const submitStyle = {
  width: '100%', padding: '12px', background: 'var(--green)', color: '#fff',
  border: 'none', borderRadius: 8, fontSize: '1rem', fontWeight: 700,
}

const switchStyle = {
  background: 'none', border: 'none', color: 'var(--green)',
  fontWeight: 600, fontSize: '0.8rem', textDecoration: 'underline', cursor: 'pointer',
}
