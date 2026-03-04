import { useState, useEffect, useCallback } from 'react'
import { useTranslation } from '../index'
import { fetchTranslations } from '../../api'

const CACHE_KEY = 'dishle_translations'
const CACHE_TTL = 60 * 60 * 1000 // 1 hour

function getCached(locale) {
  try {
    const raw = localStorage.getItem(`${CACHE_KEY}_${locale}`)
    if (!raw) return null
    const parsed = JSON.parse(raw)
    if (Date.now() - parsed.ts > CACHE_TTL) return null
    return parsed.data
  } catch {
    return null
  }
}

function setCache(locale, data) {
  try {
    localStorage.setItem(`${CACHE_KEY}_${locale}`, JSON.stringify({ data, ts: Date.now() }))
  } catch { /* ignore */ }
}

// Shared state to avoid duplicate fetches across hook instances
const loaded = {}
const pending = {}
const subs = new Set()

function notify() { subs.forEach(fn => fn()) }

function load(locale) {
  if (loaded[locale]) return Promise.resolve(loaded[locale])
  if (pending[locale]) return pending[locale]

  const cached = getCached(locale)
  if (cached) { loaded[locale] = cached; return Promise.resolve(cached) }

  pending[locale] = fetchTranslations(locale).then(data => {
    loaded[locale] = data
    setCache(locale, data)
    delete pending[locale]
    notify()
    return data
  }).catch(() => { delete pending[locale]; return null })

  return pending[locale]
}

export function useGameContent() {
  const { lang } = useTranslation()
  const [, bump] = useState(0)

  useEffect(() => {
    const cb = () => bump(n => n + 1)
    subs.add(cb)
    return () => subs.delete(cb)
  }, [])

  useEffect(() => { load(lang) }, [lang])

  const data = loaded[lang] || null

  const tIngredient = useCallback((val) => {
    if (!val || lang === 'en' || !data) return val
    return data.ingredients?.[val] || val
  }, [lang, data])

  const tCuisine = useCallback((val) => {
    if (!val || lang === 'en' || !data) return val
    return data.cuisines?.[val] || val
  }, [lang, data])

  const tDishName = useCallback((name) => {
    if (!name || lang === 'en' || !data) return name
    return data.dish_names?.[name] || name
  }, [lang, data])

  const getSearchableDishes = useCallback(() => {
    const catalog = data?.catalog
    if (!catalog) return []
    if (lang === 'en') {
      return catalog.map(d => ({ en: d.name, name: d.name, cuisine: d.cuisine }))
    }
    return catalog.map(d => ({
      en: d.name,
      name: data.dish_names?.[d.name] || d.name,
      cuisine: data.cuisines?.[d.cuisine] || d.cuisine,
    }))
  }, [lang, data])

  return { tIngredient, tCuisine, tDishName, getSearchableDishes }
}
