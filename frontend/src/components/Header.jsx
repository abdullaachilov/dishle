export default function Header({ puzzleNumber, onHelp, onStats }) {
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

      <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
        {puzzleNumber && (
          <span style={{ fontSize: '0.8rem', color: 'var(--gray)', fontWeight: 600 }}>
            #{puzzleNumber}
          </span>
        )}
        <button onClick={onHelp} style={iconBtnStyle} title="How to play" aria-label="Help">?</button>
        <button onClick={onStats} style={iconBtnStyle} title="Statistics" aria-label="Statistics">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <rect x="4" y="12" width="4" height="8" rx="1" />
            <rect x="10" y="6" width="4" height="14" rx="1" />
            <rect x="16" y="2" width="4" height="18" rx="1" />
          </svg>
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
