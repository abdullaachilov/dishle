const BASE = '/api/v1'

function authHeaders() {
  const token = localStorage.getItem('dishle_token')
  return token ? { 'Authorization': `Bearer ${token}` } : {}
}

export async function fetchToday() {
  const res = await fetch(`${BASE}/today`)
  const json = await res.json()
  if (json.error) throw new Error(json.error)
  return json.data
}

export async function submitGuess(guess, date) {
  const res = await fetch(`${BASE}/guess`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ guess, date })
  })
  const json = await res.json()
  return json
}

export async function searchDishes(query) {
  if (!query || query.length < 2) return []
  const res = await fetch(`${BASE}/dishes/search?q=${encodeURIComponent(query)}`)
  const json = await res.json()
  return json.data?.results || []
}

export async function fetchReveal(date, guesses) {
  const slugs = guesses.join(',')
  const res = await fetch(`${BASE}/reveal?date=${date}&guesses=${encodeURIComponent(slugs)}`)
  const json = await res.json()
  if (json.error) throw new Error(json.error)
  return json.data
}

export async function register(nickname, password) {
  const res = await fetch(`${BASE}/auth/register`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ nickname, password })
  })
  return res.json()
}

export async function login(nickname, password) {
  const res = await fetch(`${BASE}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ nickname, password })
  })
  return res.json()
}

export async function apiLogout() {
  const res = await fetch(`${BASE}/auth/logout`, {
    method: 'DELETE',
    headers: { ...authHeaders() }
  })
  return res.json()
}

export async function fetchMe() {
  const res = await fetch(`${BASE}/auth/me`, {
    headers: { ...authHeaders() }
  })
  return res.json()
}

export async function submitGameResult(date, solved, guessesCount) {
  const res = await fetch(`${BASE}/game_results`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', ...authHeaders() },
    body: JSON.stringify({ date, solved, guesses_count: guessesCount })
  })
  return res.json()
}

export async function fetchLeaderboard() {
  const res = await fetch(`${BASE}/leaderboard`)
  return res.json()
}

export async function submitFeedback(body) {
  const res = await fetch(`${BASE}/feedback`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', ...authHeaders() },
    body: JSON.stringify({ body })
  })
  return res.json()
}

export async function fetchTranslations(locale) {
  const res = await fetch(`${BASE}/translations?locale=${encodeURIComponent(locale)}`)
  const json = await res.json()
  if (json.error) throw new Error(json.error)
  return json.data
}
