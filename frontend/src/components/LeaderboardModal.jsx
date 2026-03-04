import { useState, useEffect } from 'react'
import { fetchLeaderboard } from '../api'

export default function LeaderboardModal({ onClose, currentUser }) {
  const [entries, setEntries] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchLeaderboard()
      .then(res => {
        if (res.data?.entries) setEntries(res.data.entries)
      })
      .catch(() => {})
      .finally(() => setLoading(false))
  }, [])

  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>

        <h2 style={{ textAlign: 'center', fontSize: '1.1rem', fontWeight: 700, marginBottom: 20 }}>
          Leaderboard
        </h2>

        {loading ? (
          <p style={{ textAlign: 'center', color: 'var(--gray)', padding: 20 }}>Loading...</p>
        ) : entries.length === 0 ? (
          <p style={{ textAlign: 'center', color: 'var(--gray)', padding: 20, fontSize: '0.9rem' }}>
            No results yet. Be the first!
          </p>
        ) : (
          <div style={{ overflowX: 'auto' }}>
            <table style={tableStyle}>
              <thead>
                <tr>
                  <th style={thStyle}>#</th>
                  <th style={{ ...thStyle, textAlign: 'left' }}>Player</th>
                  <th style={thStyle}>W</th>
                  <th style={thStyle}>P</th>
                  <th style={thStyle}>%</th>
                  <th style={thStyle}>Max</th>
                </tr>
              </thead>
              <tbody>
                {entries.map(e => {
                  const isMe = currentUser && currentUser.nickname === e.nickname
                  return (
                    <tr key={e.nickname} style={isMe ? { background: '#f0faf0' } : {}}>
                      <td style={tdStyle}>
                        {e.rank <= 3 ? ['\u{1F947}', '\u{1F948}', '\u{1F949}'][e.rank - 1] : e.rank}
                      </td>
                      <td style={{ ...tdStyle, textAlign: 'left', fontWeight: isMe ? 700 : 400 }}>
                        {e.nickname}
                      </td>
                      <td style={tdStyle}>{e.games_won}</td>
                      <td style={tdStyle}>{e.games_played}</td>
                      <td style={tdStyle}>{e.win_pct}%</td>
                      <td style={tdStyle}>{e.max_streak}</td>
                    </tr>
                  )
                })}
              </tbody>
            </table>
          </div>
        )}

        <div style={{ marginTop: 12, textAlign: 'center' }}>
          <p style={{ fontSize: '0.7rem', color: 'var(--gray)' }}>
            W = Wins &middot; P = Played &middot; Max = Best Streak
          </p>
        </div>
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
  maxWidth: 440, width: '100%', maxHeight: '90vh', overflowY: 'auto', position: 'relative',
}

const closeStyle = {
  position: 'absolute', top: 12, right: 16, background: 'none', border: 'none',
  fontSize: '1.4rem', color: 'var(--gray)', cursor: 'pointer',
}

const tableStyle = {
  width: '100%', borderCollapse: 'collapse', fontSize: '0.85rem',
}

const thStyle = {
  padding: '8px 6px', borderBottom: '2px solid var(--border)', fontSize: '0.75rem',
  fontWeight: 700, color: 'var(--gray)', textAlign: 'center',
}

const tdStyle = {
  padding: '8px 6px', borderBottom: '1px solid #f0f0f0', textAlign: 'center',
}
