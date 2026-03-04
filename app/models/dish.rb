class Dish < ApplicationRecord
  INGREDIENT_SLOTS = %w[base protein star fat heat].freeze

  has_many :daily_puzzles, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :slug, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :cuisine, presence: true, length: { maximum: 50 }
  validates :base, :protein, :star, :fat, :heat, presence: true, length: { maximum: 50 }
  validates :difficulty, inclusion: { in: %w[easy medium hard] }

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  scope :unused, -> { where(used_as_daily: false) }

  def ingredients
    {
      base: base,
      protein: protein,
      star: star,
      fat: fat,
      heat: heat
    }
  end

  def compare_with(other_dish)
    answer_ingredients = ingredients
    guess_ingredients = other_dish.ingredients

    answer_values = answer_ingredients.values.map(&:downcase)

    results = {}
    INGREDIENT_SLOTS.each do |slot|
      slot_sym = slot.to_sym
      guess_val = guess_ingredients[slot_sym]
      answer_val = answer_ingredients[slot_sym]

      result = if guess_val.downcase == answer_val.downcase
                 "correct"
               elsif answer_values.include?(guess_val.downcase)
                 "present"
               else
                 "absent"
               end

      results[slot_sym] = { value: guess_val, result: result }
    end

    results
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
