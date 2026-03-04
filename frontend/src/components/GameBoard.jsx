import Tile from './Tile'
import { useTranslation } from '../i18n'

const SLOTS = ['base', 'protein', 'star', 'fat', 'heat']
const MAX_GUESSES = 6

export default function GameBoard({ guesses, animatingRow }) {
  const { t } = useTranslation()
  const rows = []
  for (let i = 0; i < MAX_GUESSES; i++) {
    rows.push(guesses[i] || null)
  }

  return (
    <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', paddingTop: 8 }}>
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
            return (
              <Tile
                key={`${rowIdx}-${colIdx}`}
                value={ingredient?.value}
                result={ingredient?.result}
                animate={animatingRow === rowIdx}
                delay={colIdx * 250}
              />
            )
          })}
        </div>
      ))}
    </div>
  )
}
