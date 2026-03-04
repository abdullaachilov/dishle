module Api
  module V1
    class DishesController < ApplicationController
      def search
        query = params[:q].to_s.strip
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

        results = dishes.map { |d| { name: d.name, cuisine: d.cuisine } }
        render json: { data: { results: results }, error: nil, meta: {} }
      end
    end
  end
end
