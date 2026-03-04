import { useState, useEffect, useCallback } from 'react'
import { fetchToday, submitGuess, fetchReveal } from './api'
import { getGameState, saveGameState, updateStats, getStats } from './storage'
import GameBoard from './components/GameBoard'
import GuessInput from './components/GuessInput'
import Header from './components/Header'
import ResultModal from './components/ResultModal'
import StatsModal from './components/StatsModal'
import HelpModal from './components/HelpModal'

const SLOTS = ['base', 'protein', 'star', 'fat', 'heat']
const MAX_GUESSES = 6

function getTodayStr() {
  const now = new Date()
  return now.toISOString().split('T')[0]
}

export default function App() {
  const [puzzle, setPuzzle] = useState(null)
  const [guesses, setGuesses] = useState([])
  const [solved, setSolved] = useState(false)
  const [gameOver, setGameOver] = useState(false)
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(true)
  const [submitting, setSubmitting] = useState(false)
  const [revealData, setRevealData] = useState(null)
  const [showResult, setShowResult] = useState(false)
  const [showStats, setShowStats] = useState(false)
  const [showHelp, setShowHelp] = useState(false)
  const [animatingRow, setAnimatingRow] = useState(-1)

  const todayStr = getTodayStr()

  useEffect(() => {
    async function init() {
      try {
        const data = await fetchToday()
        setPuzzle(data)

        const saved = getGameState()
        if (saved && saved.currentDate === todayStr) {
          setGuesses(saved.guesses || [])
          setSolved(saved.solved || false)
          setGameOver(saved.solved || (saved.guesses || []).length >= MAX_GUESSES)
          if (saved.solved || (saved.guesses || []).length >= MAX_GUESSES) {
            setShowResult(true)
          }
        } else {
          saveGameState({ currentDate: todayStr, guesses: [], solved: false })
          const hasPlayed = saved && saved.currentDate
          if (!hasPlayed) setShowHelp(true)
        }
      } catch {
        setError('Could not load today\'s puzzle. Please try again.')
      } finally {
        setLoading(false)
      }
    }
    init()
  }, [todayStr])

  const handleGuess = useCallback(async (dishName) => {
    if (solved || gameOver || submitting) return
    setError('')
    setSubmitting(true)

    try {
      const res = await submitGuess(dishName, todayStr)

      if (res.error && !res.data?.valid) {
        setError(res.error)
        setSubmitting(false)
        return
      }

      if (!res.data.valid) {
        setError('Dish not found. Try another!')
        setSubmitting(false)
        return
      }

      const guessData = {
        dish: res.data.dish_name,
        ingredients: SLOTS.map(s => ({
          slot: s,
          value: res.data.ingredients[s].value,
          result: res.data.ingredients[s].result
        }))
      }

      const newGuesses = [...guesses, guessData]
      setAnimatingRow(guesses.length)
      setGuesses(newGuesses)

      const isSolved = res.data.solved
      const isGameOver = isSolved || newGuesses.length >= MAX_GUESSES

      setTimeout(() => {
        setAnimatingRow(-1)
        setSolved(isSolved)
        setGameOver(isGameOver)

        saveGameState({
          currentDate: todayStr,
          guesses: newGuesses,
          solved: isSolved
        })

        if (isGameOver) {
          updateStats(isSolved, newGuesses.length)
          setTimeout(() => setShowResult(true), 400)
        }
      }, 1500)
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }, [guesses, solved, gameOver, submitting, todayStr])

  useEffect(() => {
    if (gameOver && !revealData) {
      const guessSlugs = guesses.map(g => g.dish.toLowerCase().replace(/\s+/g, '-'))
      fetchReveal(todayStr, guessSlugs).then(setRevealData).catch(() => {})
    }
  }, [gameOver, revealData, guesses, todayStr])

  if (loading) {
    return (
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', minHeight: '100vh' }}>
        <div style={{ fontSize: '2rem' }}>🍽️</div>
      </div>
    )
  }

  return (
    <>
      <Header
        puzzleNumber={puzzle?.puzzle_number}
        onHelp={() => setShowHelp(true)}
        onStats={() => setShowStats(true)}
      />

      <main style={{ flex: 1, display: 'flex', flexDirection: 'column', padding: '0 16px' }}>
        <GameBoard guesses={guesses} animatingRow={animatingRow} />

        {!gameOver && (
          <GuessInput
            onSubmit={handleGuess}
            disabled={submitting || solved || gameOver}
            error={error}
          />
        )}

        {error && !gameOver && (
          <p style={{ color: '#e74c3c', textAlign: 'center', fontSize: '0.875rem', marginTop: 8 }}>
            {error}
          </p>
        )}
      </main>

      {showHelp && <HelpModal onClose={() => setShowHelp(false)} />}
      {showStats && <StatsModal stats={getStats()} onClose={() => setShowStats(false)} />}
      {showResult && (
        <ResultModal
          solved={solved}
          guesses={guesses}
          puzzleNumber={puzzle?.puzzle_number}
          revealData={revealData}
          onClose={() => setShowResult(false)}
          onStats={() => { setShowResult(false); setShowStats(true) }}
        />
      )}
    </>
  )
}
