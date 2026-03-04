const BASE = '/api/v1'

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
