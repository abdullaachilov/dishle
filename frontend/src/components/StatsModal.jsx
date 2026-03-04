import { useTranslation } from '../i18n'

export default function StatsModal({ stats, onClose }) {
  const { t } = useTranslation()
  const maxGuesses = Math.max(...Object.values(stats.guessDistribution), 1)
  const winPct = stats.gamesPlayed > 0 ? Math.round((stats.gamesWon / stats.gamesPlayed) * 100) : 0

  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>
        <h2 style={{ textAlign: 'center', fontSize: '1.1rem', fontWeight: 700, marginBottom: 20 }}>{t('stats.title')}</h2>

        <div style={{ display: 'flex', justifyContent: 'center', gap: 20, marginBottom: 24 }}>
          <StatBox value={stats.gamesPlayed} label={t('stats.played')} />
          <StatBox value={winPct} label={t('stats.winPct')} />
          <StatBox value={stats.currentStreak} label={t('stats.streak')} />
          <StatBox value={stats.maxStreak} label={t('stats.max')} />
        </div>

        <h3 style={{ fontSize: '0.85rem', fontWeight: 600, marginBottom: 12, textAlign: 'center' }}>
          {t('stats.guessDistribution')}
        </h3>

        <div style={{ maxWidth: 280, margin: '0 auto' }}>
          {[1, 2, 3, 4, 5, 6].map(n => {
            const count = stats.guessDistribution[n] || 0
            const width = Math.max(8, (count / maxGuesses) * 100)
            return (
              <div key={n} style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 4 }}>
                <span style={{ fontSize: '0.8rem', fontWeight: 600, width: 12, textAlign: 'right' }}>{n}</span>
                <div style={{
                  height: 22,
                  width: `${width}%`,
                  background: count > 0 ? 'var(--green)' : 'var(--light-gray)',
                  borderRadius: 4,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'flex-end',
                  padding: '0 6px',
                  transition: 'width 0.3s ease',
                }}>
                  <span style={{ fontSize: '0.7rem', fontWeight: 700, color: count > 0 ? '#fff' : 'var(--text)' }}>
                    {count}
                  </span>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}

function StatBox({ value, label }) {
  return (
    <div style={{ textAlign: 'center' }}>
      <div style={{ fontSize: '1.5rem', fontWeight: 700 }}>{value}</div>
      <div style={{ fontSize: '0.65rem', color: 'var(--gray)' }}>{label}</div>
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
  maxWidth: 380,
  width: '100%',
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
