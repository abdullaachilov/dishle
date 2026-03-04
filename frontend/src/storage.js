const GAME_KEY = 'dishle_game'
const STATS_KEY = 'dishle_stats'

export function getGameState() {
  try {
    const raw = localStorage.getItem(GAME_KEY)
    return raw ? JSON.parse(raw) : null
  } catch {
    return null
  }
}

export function saveGameState(state) {
  localStorage.setItem(GAME_KEY, JSON.stringify(state))
}

export function getStats() {
  try {
    const raw = localStorage.getItem(STATS_KEY)
    return raw ? JSON.parse(raw) : defaultStats()
  } catch {
    return defaultStats()
  }
}

export function saveStats(stats) {
  localStorage.setItem(STATS_KEY, JSON.stringify(stats))
}

function defaultStats() {
  return {
    gamesPlayed: 0,
    gamesWon: 0,
    currentStreak: 0,
    maxStreak: 0,
    guessDistribution: { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0 }
  }
}

export function updateStats(won, guessCount) {
  const stats = getStats()
  stats.gamesPlayed++
  if (won) {
    stats.gamesWon++
    stats.currentStreak++
    stats.maxStreak = Math.max(stats.maxStreak, stats.currentStreak)
    stats.guessDistribution[guessCount] = (stats.guessDistribution[guessCount] || 0) + 1
  } else {
    stats.currentStreak = 0
  }
  saveStats(stats)
  return stats
}
