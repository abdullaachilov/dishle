module Api
  module V1
    class DishesController < ApplicationController
      def search
        query = params[:q].to_s.strip
        locale = params[:locale].to_s.strip

        if query.blank? || query.length < 2
          render json: { data: { results: [] }, error: nil, meta: {} }
          return
        end

        if query.length > 100
          render json: { data: { results: [] }, error: nil, meta: {} }
          return
        end

        sanitized = "%#{Dish.sanitize_sql_like(query)}%"
        dishes = Dish.where("name ILIKE ?", sanitized).order(:name).limit(8)

        # Also search translated dish names if locale provided
        if ContentTranslation::LOCALES.include?(locale) && dishes.count < 8
          remaining = 8 - dishes.count
          translated_keys = ContentTranslation
            .where(locale: locale, category: "dish_name")
            .where("value ILIKE ?", sanitized)
            .where.not(key: dishes.pluck(:name))
            .limit(remaining)
            .pluck(:key)

          if translated_keys.any?
            extra = Dish.where(name: translated_keys).order(:name)
            dishes = Dish.where(id: dishes.pluck(:id) + extra.pluck(:id)).order(:name).limit(8)
          end
        end

        results = dishes.map { |d| { name: d.name, cuisine: d.cuisine } }
        render json: { data: { results: results }, error: nil, meta: {} }
      end
    end
  end
end
