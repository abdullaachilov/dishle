import { useState, useEffect, useCallback } from 'react'
import { fetchToday, submitGuess, fetchReveal, fetchMe, submitGameResult, apiLogout, requestHint } from './api'
import { getGameState, saveGameState, updateStats, getStats, getToken, removeToken } from './storage'
import { useTranslation } from './i18n'
import GameBoard from './components/GameBoard'
import GuessInput from './components/GuessInput'
import Header from './components/Header'
import ResultModal from './components/ResultModal'
import StatsModal from './components/StatsModal'
import HelpModal from './components/HelpModal'
import AuthModal from './components/AuthModal'
import UserModal from './components/UserModal'
import LeaderboardModal from './components/LeaderboardModal'
import FeedbackModal from './components/FeedbackModal'

const SLOTS = ['base', 'protein', 'star', 'fat', 'heat']
const MAX_GUESSES = 6
const MAX_EXTRA_HINTS = 2

function getTodayStr() {
  const now = new Date()
  return now.toISOString().split('T')[0]
}

export default function App() {
  const { t } = useTranslation()
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
  const [showAuth, setShowAuth] = useState(false)
  const [showUser, setShowUser] = useState(false)
  const [showLeaderboard, setShowLeaderboard] = useState(false)
  const [showFeedback, setShowFeedback] = useState(false)
  const [animatingRow, setAnimatingRow] = useState(-1)
  const [user, setUser] = useState(null)
  const [hints, setHints] = useState([])
  const [nearMiss, setNearMiss] = useState(0)

  const todayStr = getTodayStr()

  useEffect(() => {
    const token = getToken()
    if (token) {
      fetchMe().then(res => {
        if (res.data?.user) setUser(res.data.user)
        else removeToken()
      }).catch(() => removeToken())
    }
  }, [])

  useEffect(() => {
    async function init() {
      try {
        const data = await fetchToday()
        setPuzzle(data)

        const saved = getGameState()
        if (saved && saved.currentDate === todayStr) {
          setGuesses(saved.guesses || [])
          setSolved(saved.solved || false)
          setHints(saved.hints || [])
          setGameOver(saved.solved || (saved.guesses || []).length >= MAX_GUESSES)
          if (saved.solved || (saved.guesses || []).length >= MAX_GUESSES) {
            setShowResult(true)
          }
        } else {
          saveGameState({ currentDate: todayStr, guesses: [], solved: false, hints: [] })
          const hasPlayed = saved && saved.currentDate
          if (!hasPlayed) setShowHelp(true)
        }
      } catch {
        setError('error.loadPuzzle')
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
        setError('error.dishNotFound')
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

      const correctCount = guessData.ingredients.filter(i => i.result === 'correct').length
      const newGuesses = [...guesses, guessData]
      setAnimatingRow(guesses.length)
      setGuesses(newGuesses)

      const isSolved = res.data.solved
      const isGameOver = isSolved || newGuesses.length >= MAX_GUESSES
      const currentHints = hints

      setTimeout(() => {
        setAnimatingRow(-1)
        setSolved(isSolved)
        setGameOver(isGameOver)

        if (!isSolved && correctCount >= 4) {
          setNearMiss(correctCount)
          setTimeout(() => setNearMiss(0), 2500)
        }

        saveGameState({
          currentDate: todayStr,
          guesses: newGuesses,
          solved: isSolved,
          hints: currentHints
        })

        if (isGameOver) {
          updateStats(isSolved, newGuesses.length)
          if (getToken()) {
            submitGameResult(todayStr, isSolved, newGuesses.length, currentHints.length).catch(() => {})
          }
          setTimeout(() => setShowResult(true), 400)
        }
      }, 1500)
    } catch {
      setError('error.generic')
    } finally {
      setSubmitting(false)
    }
  }, [guesses, solved, gameOver, submitting, todayStr, hints])

  const handleRequestHint = useCallback(async () => {
    if (solved || gameOver || hints.length >= MAX_EXTRA_HINTS) return
    const allRevealed = [puzzle.hint.slot, ...hints.map(h => h.slot)]
    try {
      const res = await requestHint(todayStr, allRevealed)
      if (res.data?.slot) {
        const newHints = [...hints, { slot: res.data.slot, value: res.data.value }]
        setHints(newHints)
        saveGameState({
          currentDate: todayStr,
          guesses,
          solved,
          hints: newHints
        })
      }
    } catch {}
  }, [puzzle, hints, solved, gameOver, todayStr, guesses])

  useEffect(() => {
    if (gameOver && !revealData) {
      const guessSlugs = guesses.map(g => g.dish.toLowerCase().replace(/\s+/g, '-'))
      fetchReveal(todayStr, guessSlugs).then(setRevealData).catch(() => {})
    }
  }, [gameOver, revealData, guesses, todayStr])

  function handleAuth(userData) {
    setUser(userData)
    if (gameOver) {
      submitGameResult(todayStr, solved, guesses.length, hints.length).catch(() => {})
    }
  }

  function handleLogout() {
    apiLogout().catch(() => {})
    removeToken()
    setUser(null)
    setShowUser(false)
  }

  function handleAuthClick() {
    if (user) {
      setShowUser(true)
    } else {
      setShowAuth(true)
    }
  }

  if (loading) {
    return (
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', minHeight: '100vh' }}>
        <div style={{ fontSize: '2rem' }}>{'\uD83C\uDF7D\uFE0F'}</div>
      </div>
    )
  }

  return (
    <>
      <Header
        puzzleNumber={puzzle?.puzzle_number}
        onHelp={() => setShowHelp(true)}
        onStats={() => setShowStats(true)}
        onLeaderboard={() => setShowLeaderboard(true)}
        onFeedback={() => setShowFeedback(true)}
        onAuth={handleAuthClick}
        user={user}
      />

      <main style={{ flex: 1, display: 'flex', flexDirection: 'column', padding: '0 16px' }}>
        <GameBoard guesses={guesses} animatingRow={animatingRow} hint={puzzle?.hint} extraHints={hints} />

        {nearMiss > 0 && (
          <div style={{
            textAlign: 'center', padding: '8px 16px', margin: '4px auto',
            background: 'rgba(230, 126, 34, 0.12)', border: '1px solid rgba(230, 126, 34, 0.3)',
            borderRadius: 8, maxWidth: 440, width: '100%',
            animation: 'fadeInOut 2.5s ease forwards',
          }}>
            <span style={{ fontSize: '0.9rem', fontWeight: 700 }}>
              {'\uD83D\uDD25'} {t('nearMiss.soClose', { count: nearMiss })}
            </span>
          </div>
        )}

        {!gameOver && (
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6 }}>
            {hints.length < MAX_EXTRA_HINTS && (
              <button
                onClick={handleRequestHint}
                style={{
                  background: 'none', border: '1px solid var(--yellow)',
                  borderRadius: 8, padding: '6px 14px', fontSize: '0.78rem',
                  fontWeight: 600, color: '#c9b458', marginTop: 4,
                }}
                title={t('hint.cost')}
              >
                {'\uD83D\uDCA1'} {t('hint.request')} ({MAX_EXTRA_HINTS - hints.length} {t('hint.remaining')})
              </button>
            )}
            <GuessInput
              onSubmit={handleGuess}
              disabled={submitting || solved || gameOver}
              error={error}
            />
          </div>
        )}

        {error && !gameOver && (
          <p style={{ color: '#e74c3c', textAlign: 'center', fontSize: '0.875rem', marginTop: 8 }}>
            {t(error) !== error ? t(error) : error}
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
          user={user}
          onAuth={() => { setShowResult(false); setShowAuth(true) }}
          hintsUsed={hints.length}
        />
      )}
      {showAuth && <AuthModal onClose={() => setShowAuth(false)} onAuth={handleAuth} />}
      {showUser && <UserModal user={user} onClose={() => setShowUser(false)} onLogout={handleLogout} />}
      {showLeaderboard && <LeaderboardModal onClose={() => setShowLeaderboard(false)} currentUser={user} />}
      {showFeedback && <FeedbackModal onClose={() => setShowFeedback(false)} />}
    </>
  )
}
