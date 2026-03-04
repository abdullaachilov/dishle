import Tile from './Tile'
import { useTranslation } from '../i18n'
import { useGameContent } from '../i18n/content'

const SLOTS = ['base', 'protein', 'star', 'fat', 'heat']
const MAX_GUESSES = 6

export default function GameBoard({ guesses, animatingRow, hint, extraHints = [] }) {
  const { t } = useTranslation()
  const { tIngredient } = useGameContent()
  const rows = []
  for (let i = 0; i < MAX_GUESSES; i++) {
    rows.push(guesses[i] || null)
  }

  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', paddingTop: 8 }}>
      {/* Hint banner */}
      {hint && (
        <div style={{
          display: 'flex',
          alignItems: 'center',
          gap: 6,
          background: 'rgba(106, 170, 100, 0.12)',
          border: '1px solid rgba(106, 170, 100, 0.4)',
          borderRadius: 8,
          padding: '6px 14px',
          marginBottom: 8,
          maxWidth: 440,
          width: '100%',
          justifyContent: 'center',
        }}>
          <span style={{ fontSize: '0.85rem' }}>💡</span>
          <span style={{ fontSize: '0.78rem', fontWeight: 600, color: 'var(--text)' }}>
            {t('hint.revealed', {
              slot: t(`slot.${hint.slot}`),
              value: tIngredient(hint.value) || hint.value
            })}
          </span>
        </div>
      )}

      {/* Extra hint banners */}
      {extraHints.map((h, i) => (
        <div key={`extra-hint-${i}`} style={{
          display: 'flex',
          alignItems: 'center',
          gap: 6,
          background: 'rgba(201, 180, 88, 0.12)',
          border: '1px solid rgba(201, 180, 88, 0.4)',
          borderRadius: 8,
          padding: '6px 14px',
          marginBottom: 4,
          maxWidth: 440,
          width: '100%',
          justifyContent: 'center',
        }}>
          <span style={{ fontSize: '0.85rem' }}>{'\uD83D\uDCA1'}</span>
          <span style={{ fontSize: '0.78rem', fontWeight: 600, color: 'var(--text)' }}>
            {t('hint.revealed', {
              slot: t(`slot.${h.slot}`),
              value: tIngredient(h.value) || h.value
            })}
            <span style={{ color: 'var(--gray)', fontSize: '0.7rem', marginLeft: 4 }}>(-2 pts)</span>
          </span>
        </div>
      ))}

      {/* Category labels */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(5, 1fr)',
        gap: 4,
        width: '100%',
        maxWidth: 440,
        marginBottom: 4,
      }}>
        {SLOTS.map(slot => (
          <div key={slot} style={{
            textAlign: 'center',
            fontSize: '0.6rem',
            fontWeight: 700,
            color: 'var(--gray)',
            letterSpacing: '0.08em',
            textTransform: 'uppercase',
          }}>
            {t(`slot.${slot}`)}
          </div>
        ))}
      </div>

      {/* Guess rows */}
      {rows.map((guess, rowIdx) => (
        <div
          key={rowIdx}
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(5, 1fr)',
            gap: 4,
            width: '100%',
            maxWidth: 440,
            marginBottom: 4,
          }}
        >
          {SLOTS.map((slot, colIdx) => {
            const ingredient = guess?.ingredients?.find(i => i.slot === slot)
            const isHintTile = !guess && rowIdx === 0 && guesses.length === 0 && hint?.slot === slot
            const isExtraHint = !guess && rowIdx === 0 && guesses.length === 0 && extraHints.some(h => h.slot === slot)
            const extraHintData = isExtraHint ? extraHints.find(h => h.slot === slot) : null
            return (
              <Tile
                key={`${rowIdx}-${colIdx}`}
                value={isHintTile ? hint.value : isExtraHint ? extraHintData.value : ingredient?.value}
                result={ingredient?.result}
                animate={animatingRow === rowIdx}
                delay={colIdx * 250}
                isHint={isHintTile}
                isExtraHint={isExtraHint}
              />
            )
          })}
        </div>
      ))}
    </div>
  )
}
