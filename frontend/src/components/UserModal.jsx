export default function UserModal({ user, onClose, onLogout }) {
  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>

        <div style={{ textAlign: 'center', marginBottom: 16 }}>
          <div style={{
            width: 48, height: 48, borderRadius: '50%', background: 'var(--green)',
            color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: '1.3rem', fontWeight: 700, margin: '0 auto 8px',
          }}>
            {user.nickname.charAt(0).toUpperCase()}
          </div>
          <h2 style={{ fontSize: '1.1rem', fontWeight: 700 }}>{user.nickname}</h2>
        </div>

        <div style={{ display: 'flex', justifyContent: 'center', gap: 20, marginBottom: 20 }}>
          <StatBox value={user.games_played} label="Played" />
          <StatBox value={user.games_won} label="Won" />
          <StatBox value={user.current_streak} label="Streak" />
          <StatBox value={user.max_streak} label="Best" />
        </div>

        <button onClick={onLogout} style={logoutStyle}>Sign Out</button>
      </div>
    </div>
  )
}

function StatBox({ value, label }) {
  return (
    <div style={{ textAlign: 'center' }}>
      <div style={{ fontSize: '1.3rem', fontWeight: 700 }}>{value}</div>
      <div style={{ fontSize: '0.65rem', color: 'var(--gray)' }}>{label}</div>
    </div>
  )
}

const overlayStyle = {
  position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.5)',
  display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: 16,
}

const modalStyle = {
  background: '#fff', borderRadius: 16, padding: '28px 24px',
  maxWidth: 340, width: '100%', position: 'relative',
}

const closeStyle = {
  position: 'absolute', top: 12, right: 16, background: 'none', border: 'none',
  fontSize: '1.4rem', color: 'var(--gray)', cursor: 'pointer',
}

const logoutStyle = {
  display: 'block', width: '100%', padding: '10px', background: 'none',
  color: '#e74c3c', border: '1px solid #e74c3c', borderRadius: 8,
  fontSize: '0.9rem', fontWeight: 600, cursor: 'pointer',
}
