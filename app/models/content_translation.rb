class ContentTranslation < ApplicationRecord
  LOCALES = %w[ru uk pl de es].freeze
  CATEGORIES = %w[ingredient cuisine dish_name].freeze

  validates :locale, presence: true, inclusion: { in: LOCALES }, length: { maximum: 5 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }, length: { maximum: 20 }
  validates :key, presence: true, length: { maximum: 100 }
  validates :value, presence: true, length: { maximum: 200 }
  validates :key, uniqueness: { scope: [:locale, :category] }

  scope :for_locale, ->(locale) { where(locale: locale) }

  def self.grouped_by_locale(locale)
    translations = for_locale(locale).select(:category, :key, :value)

    result = { ingredients: {}, cuisines: {}, dish_names: {} }
    translations.each do |t|
      case t.category
      when "ingredient"
        result[:ingredients][t.key] = t.value
      when "cuisine"
        result[:cuisines][t.key] = t.value
      when "dish_name"
        result[:dish_names][t.key] = t.value
      end
    end
    result
  end
end
