import { useState, useEffect, useRef, useCallback } from 'react'
import { searchDishes } from '../api'
import { useTranslation } from '../i18n'

export default function GuessInput({ onSubmit, disabled, error }) {
  const { t } = useTranslation()
  const [query, setQuery] = useState('')
  const [results, setResults] = useState([])
  const [showDropdown, setShowDropdown] = useState(false)
  const [selectedIdx, setSelectedIdx] = useState(-1)
  const inputRef = useRef(null)
  const debounceRef = useRef(null)
  const dropdownRef = useRef(null)

  const doSearch = useCallback(async (q) => {
    if (q.length < 2) {
      setResults([])
      setShowDropdown(false)
      return
    }
    try {
      const data = await searchDishes(q)
      setResults(data)
      setShowDropdown(data.length > 0)
      setSelectedIdx(-1)
    } catch {
      setResults([])
    }
  }, [])

  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current)
    debounceRef.current = setTimeout(() => doSearch(query), 200)
    return () => clearTimeout(debounceRef.current)
  }, [query, doSearch])

  useEffect(() => {
    function handleClickOutside(e) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target) &&
          inputRef.current && !inputRef.current.contains(e.target)) {
        setShowDropdown(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  function handleSelect(dish) {
    setQuery('')
    setResults([])
    setShowDropdown(false)
    onSubmit(dish.name)
  }

  function handleSubmit(e) {
    e.preventDefault()
    if (selectedIdx >= 0 && results[selectedIdx]) {
      handleSelect(results[selectedIdx])
    } else if (query.trim()) {
      onSubmit(query.trim())
      setQuery('')
      setShowDropdown(false)
    }
  }

  function handleKeyDown(e) {
    if (!showDropdown) return
    if (e.key === 'ArrowDown') {
      e.preventDefault()
      setSelectedIdx(prev => Math.min(prev + 1, results.length - 1))
    } else if (e.key === 'ArrowUp') {
      e.preventDefault()
      setSelectedIdx(prev => Math.max(prev - 1, -1))
    } else if (e.key === 'Escape') {
      setShowDropdown(false)
    }
  }

  return (
    <div style={{ position: 'relative', padding: '12px 0 20px', width: '100%', maxWidth: 440, margin: '0 auto' }}>
      <form onSubmit={handleSubmit} style={{ display: 'flex', gap: 8 }}>
        <div style={{ flex: 1, position: 'relative' }}>
          <span style={{
            position: 'absolute', left: 12, top: '50%', transform: 'translateY(-50%)',
            fontSize: '1rem', color: 'var(--gray)', pointerEvents: 'none',
          }}>🔍</span>
          <input
            ref={inputRef}
            type="text"
            value={query}
            onChange={(e) => setQuery(e.target.value.slice(0, 100))}
            onKeyDown={handleKeyDown}
            onFocus={() => results.length > 0 && setShowDropdown(true)}
            placeholder={t('input.placeholder')}
            disabled={disabled}
            autoComplete="off"
            style={{
              width: '100%',
              padding: '12px 12px 12px 36px',
              border: '2px solid var(--border)',
              borderRadius: 8,
              fontSize: '1rem',
              outline: 'none',
              transition: 'border-color 0.2s',
            }}
          />
        </div>
        <button
          type="submit"
          disabled={disabled || !query.trim()}
          style={{
            padding: '12px 20px',
            background: disabled || !query.trim() ? 'var(--light-gray)' : 'var(--green)',
            color: '#fff',
            border: 'none',
            borderRadius: 8,
            fontSize: '1rem',
            fontWeight: 700,
            letterSpacing: '0.05em',
          }}
        >
          {t('input.submit')}
        </button>
      </form>

      {showDropdown && results.length > 0 && (
        <div
          ref={dropdownRef}
          style={{
            position: 'absolute',
            bottom: '100%',
            left: 0,
            right: 64,
            background: '#fff',
            border: '1px solid var(--border)',
            borderRadius: 8,
            boxShadow: '0 4px 12px rgba(0,0,0,0.1)',
            maxHeight: 280,
            overflowY: 'auto',
            zIndex: 100,
          }}
        >
          {results.map((dish, idx) => (
            <button
              key={dish.name}
              onClick={() => handleSelect(dish)}
              style={{
                width: '100%',
                padding: '10px 14px',
                border: 'none',
                background: idx === selectedIdx ? '#f0f0f0' : 'transparent',
                textAlign: 'left',
                fontSize: '0.9rem',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                borderBottom: idx < results.length - 1 ? '1px solid #f0f0f0' : 'none',
              }}
            >
              <span style={{ fontWeight: 600 }}>{dish.name}</span>
              <span style={{ fontSize: '0.75rem', color: 'var(--gray)' }}>{dish.cuisine}</span>
            </button>
          ))}
        </div>
      )}
    </div>
  )
}
