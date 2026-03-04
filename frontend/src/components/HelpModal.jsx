import { useTranslation } from '../i18n'

export default function HelpModal({ onClose }) {
  const { t } = useTranslation()

  return (
    <div style={overlayStyle} onClick={onClose}>
      <div style={modalStyle} onClick={e => e.stopPropagation()}>
        <button onClick={onClose} style={closeStyle}>&times;</button>
        <h2 style={{ textAlign: 'center', fontSize: '1.1rem', fontWeight: 700, marginBottom: 16 }}>
          {t('help.title')}
        </h2>

        <p style={pStyle}>
          {t('help.description')}
        </p>

        <div style={{ display: 'flex', gap: 4, justifyContent: 'center', margin: '12px 0', fontSize: '0.7rem', fontWeight: 700, color: 'var(--gray)' }}>
          <span style={labelStyle}>{t('slot.base')}</span>
          <span style={labelStyle}>{t('slot.protein')}</span>
          <span style={labelStyle}>{t('slot.star')}</span>
          <span style={labelStyle}>{t('slot.fat')}</span>
          <span style={labelStyle}>{t('slot.heat')}</span>
        </div>

        <h3 style={{ fontSize: '0.85rem', fontWeight: 600, marginTop: 16, marginBottom: 8 }}>
          {t('help.colorHints')}
        </h3>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 8, marginBottom: 16 }}>
          <ColorExample color="#6aaa64" emoji="🟩" text={t('help.correct')} />
          <ColorExample color="#c9b458" emoji="🟨" text={t('help.present')} />
          <ColorExample color="#787c7e" emoji="⬛" text={t('help.absent')} />
        </div>

        <h3 style={{ fontSize: '0.85rem', fontWeight: 600, marginBottom: 8 }}>
          {t('help.example')}
        </h3>

        <div style={{ background: '#f8f8f8', borderRadius: 8, padding: 12, marginBottom: 16 }}>
          <p style={{ fontSize: '0.8rem', fontWeight: 600, marginBottom: 6 }}>
            {t('help.answer')}
          </p>
          <p style={{ fontSize: '0.75rem', color: '#555', marginBottom: 4 }}>
            {t('help.guess')}
          </p>
          <div style={{ display: 'flex', gap: 3 }}>
            <MiniTile text="Pasta" color="#6aaa64" />
            <MiniTile text="Beef" color="#787c7e" />
            <MiniTile text="Tomato" color="#787c7e" />
            <MiniTile text="Olive Oil" color="#787c7e" />
            <MiniTile text="Garlic" color="#787c7e" />
          </div>
          <p style={{ fontSize: '0.7rem', color: '#888', marginTop: 4 }}>
            {t('help.exampleExplain')}
          </p>
        </div>

        <p style={{ ...pStyle, textAlign: 'center', fontSize: '0.8rem' }}>
          {t('help.newPuzzle')}
        </p>

        <button onClick={onClose} style={playBtnStyle}>{t('help.play')}</button>
      </div>
    </div>
  )
}

function ColorExample({ color, emoji, text }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
      <span style={{
        width: 28, height: 28, borderRadius: 4, background: color,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        fontSize: '0.9rem', flexShrink: 0,
      }}>{emoji}</span>
      <span style={{ fontSize: '0.8rem' }}>{text}</span>
    </div>
  )
}

function MiniTile({ text, color }) {
  return (
    <span style={{
      flex: 1, padding: '4px 2px', background: color, borderRadius: 4,
      color: '#fff', fontSize: '0.55rem', fontWeight: 600, textAlign: 'center',
    }}>{text}</span>
  )
}

const pStyle = { fontSize: '0.85rem', lineHeight: 1.5, color: '#444' }
const labelStyle = { flex: 1, textAlign: 'center' }

const overlayStyle = {
  position: 'fixed', inset: 0, background: 'rgba(0,0,0,0.5)',
  display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000, padding: 16,
}

const modalStyle = {
  background: '#fff', borderRadius: 16, padding: '28px 24px',
  maxWidth: 420, width: '100%', maxHeight: '90vh', overflowY: 'auto', position: 'relative',
}

const closeStyle = {
  position: 'absolute', top: 12, right: 16, background: 'none', border: 'none',
  fontSize: '1.4rem', color: 'var(--gray)', cursor: 'pointer',
}

const playBtnStyle = {
  display: 'block', width: '100%', padding: '12px', background: 'var(--green)',
  color: '#fff', border: 'none', borderRadius: 8, fontSize: '1rem', fontWeight: 700,
  marginTop: 16, cursor: 'pointer',
}
