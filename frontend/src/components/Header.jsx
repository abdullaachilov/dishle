import { useTranslation } from '../i18n'
import LanguageSelector from './LanguageSelector'

export default function Header({ puzzleNumber, onHelp, onStats, onLeaderboard, onAuth, user }) {
  const { t } = useTranslation()

  return (
    <header style={{
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      padding: '12px 16px',
      borderBottom: '2px solid var(--header-border)',
    }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
        <span style={{ fontSize: '1.5rem' }}>🍽️</span>
        <h1 style={{ fontSize: '1.4rem', fontWeight: 800, letterSpacing: '0.05em' }}>DISHLE</h1>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
        {puzzleNumber && (
          <span style={{ fontSize: '0.8rem', color: 'var(--gray)', fontWeight: 600, marginRight: 2 }}>
            #{puzzleNumber}
          </span>
        )}
        <LanguageSelector />
        <button onClick={onHelp} style={iconBtnStyle} title={t('header.howToPlay')} aria-label="Help">?</button>
        <button onClick={onLeaderboard} style={iconBtnStyle} title={t('header.leaderboard')} aria-label="Leaderboard">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
            <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6" />
            <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18" />
            <path d="M4 22h16" />
            <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20 7 22" />
            <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20 17 22" />
            <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z" />
          </svg>
        </button>
        <button onClick={onStats} style={iconBtnStyle} title={t('header.statistics')} aria-label="Statistics">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <rect x="4" y="12" width="4" height="8" rx="1" />
            <rect x="10" y="6" width="4" height="14" rx="1" />
            <rect x="16" y="2" width="4" height="18" rx="1" />
          </svg>
        </button>
        <button
          onClick={onAuth}
          style={user ? userBtnStyle : iconBtnStyle}
          title={user ? user.nickname : t('header.signIn')}
          aria-label={user ? user.nickname : t('header.signIn')}
        >
          {user ? user.nickname.charAt(0).toUpperCase() : (
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
              <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
              <circle cx="12" cy="7" r="4" />
            </svg>
          )}
        </button>
      </div>
    </header>
  )
}

const iconBtnStyle = {
  width: 32,
  height: 32,
  borderRadius: '50%',
  border: '1px solid var(--border)',
  background: 'none',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  fontSize: '0.9rem',
  fontWeight: 700,
  color: 'var(--text)',
}

const userBtnStyle = {
  width: 32,
  height: 32,
  borderRadius: '50%',
  border: 'none',
  background: 'var(--green)',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  fontSize: '0.75rem',
  fontWeight: 700,
  color: '#fff',
}
