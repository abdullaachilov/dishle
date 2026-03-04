import { createContext, useContext, useState, useCallback } from 'react'
import en from './en'
import ru from './ru'
import uk from './uk'
import pl from './pl'
import de from './de'
import es from './es'

const translations = { en, ru, uk, pl, de, es }

export const LANGUAGES = [
  { code: 'en', name: 'English', flag: '🇬🇧' },
  { code: 'ru', name: 'Русский', flag: '🇷🇺' },
  { code: 'uk', name: 'Українська', flag: '🇺🇦' },
  { code: 'pl', name: 'Polski', flag: '🇵🇱' },
  { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
  { code: 'es', name: 'Español', flag: '🇪🇸' },
]

const LANG_KEY = 'dishle_lang'

function getInitialLang() {
  const saved = localStorage.getItem(LANG_KEY)
  if (saved && translations[saved]) return saved
  const browserLang = navigator.language?.split('-')[0]
  if (browserLang && translations[browserLang]) return browserLang
  return 'en'
}

const I18nContext = createContext()

export function I18nProvider({ children }) {
  const [lang, setLangState] = useState(getInitialLang)

  const setLang = useCallback((code) => {
    if (translations[code]) {
      setLangState(code)
      localStorage.setItem(LANG_KEY, code)
      document.documentElement.lang = code
    }
  }, [])

  const t = useCallback((key, params) => {
    const str = translations[lang]?.[key] || translations.en[key] || key
    if (!params) return str
    return str.replace(/\{(\w+)\}/g, (_, k) => params[k] ?? `{${k}}`)
  }, [lang])

  return (
    <I18nContext.Provider value={{ t, lang, setLang }}>
      {children}
    </I18nContext.Provider>
  )
}

export function useTranslation() {
  return useContext(I18nContext)
}
