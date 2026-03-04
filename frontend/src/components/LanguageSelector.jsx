import { useState, useRef, useEffect } from 'react'
import { useTranslation, LANGUAGES } from '../i18n'

export default function LanguageSelector() {
  const { lang, setLang } = useTranslation()
  const [open, setOpen] = useState(false)
  const ref = useRef(null)

  useEffect(() => {
    function handleClick(e) {
      if (ref.current && !ref.current.contains(e.target)) setOpen(false)
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  const current = LANGUAGES.find(l => l.code === lang)

  return (
    <div ref={ref} style={{ position: 'relative' }}>
      <button
        onClick={() => setOpen(!open)}
        style={btnStyle}
        title="Language"
        aria-label="Language"
      >
        <span style={{ fontSize: '0.9rem', lineHeight: 1 }}>{current?.flag}</span>
      </button>

      {open && (
        <div style={dropdownStyle}>
          {LANGUAGES.map(l => (
            <button
              key={l.code}
              onClick={() => { setLang(l.code); setOpen(false) }}
              style={{
                ...itemStyle,
                background: l.code === lang ? '#f0f0f0' : 'transparent',
                fontWeight: l.code === lang ? 700 : 400,
              }}
            >
              <span>{l.flag}</span>
              <span>{l.name}</span>
            </button>
          ))}
        </div>
      )}
    </div>
  )
}

const btnStyle = {
  width: 32,
  height: 32,
  borderRadius: '50%',
  border: '1px solid var(--border)',
  background: 'none',
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  cursor: 'pointer',
}

const dropdownStyle = {
  position: 'absolute',
  top: '100%',
  right: 0,
  marginTop: 4,
  background: '#fff',
  border: '1px solid var(--border)',
  borderRadius: 8,
  boxShadow: '0 4px 12px rgba(0,0,0,0.1)',
  zIndex: 200,
  minWidth: 150,
  overflow: 'hidden',
}

const itemStyle = {
  width: '100%',
  padding: '8px 12px',
  border: 'none',
  display: 'flex',
  alignItems: 'center',
  gap: 8,
  fontSize: '0.85rem',
  cursor: 'pointer',
  textAlign: 'left',
}
