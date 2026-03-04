module Api
  module V1
    class PuzzlesController < ApplicationController
      def today
        puzzle = DailyPuzzle.today
        unless puzzle
          render json: { data: nil, error: "No puzzle available today", meta: {} }, status: :not_found
          return
        end

        dish = puzzle.dish
        slots = Dish::INGREDIENT_SLOTS
        hint_index = puzzle.puzzle_number % slots.length
        hint_slot = slots[hint_index]
        hint_value = dish.send(hint_slot)

        render json: {
          data: {
            puzzle_number: puzzle.puzzle_number,
            date: puzzle.puzzle_date.iso8601,
            total_dishes: Dish.count,
            hint: { slot: hint_slot, value: hint_value }
          },
          error: nil,
          meta: {}
        }
      end

      def guess
        date_str = guess_params[:date].to_s
        guess_slug = guess_params[:guess].to_s

        if date_str.blank? || guess_slug.blank?
          render json: { data: nil, error: "Missing required parameters", meta: {} }, status: :unprocessable_entity
          return
        end

        if date_str.length > 20 || guess_slug.length > 100
          render json: { data: nil, error: "Invalid parameters", meta: {} }, status: :unprocessable_entity
          return
        end

        begin
          date = Date.parse(date_str)
        rescue Date::Error
          render json: { data: nil, error: "Invalid date format", meta: {} }, status: :unprocessable_entity
          return
        end

        puzzle = DailyPuzzle.for_date(date)
        unless puzzle
          render json: { data: nil, error: "No puzzle for this date", meta: {} }, status: :not_found
          return
        end

        guessed_dish = Dish.find_by(slug: guess_slug.parameterize)
        guessed_dish ||= Dish.where("LOWER(name) = ?", guess_slug.strip.downcase).first

        unless guessed_dish
          render json: {
            data: { valid: false },
            error: "Dish not found. Try another!",
            meta: {}
          }, status: :ok
          return
        end

        answer = puzzle.dish
        comparison = answer.compare_with(guessed_dish)
        solved = comparison.values.all? { |v| v[:result] == "correct" }

        render json: {
          data: {
            valid: true,
            dish_name: guessed_dish.name,
            ingredients: comparison,
            solved: solved
          },
          error: nil,
          meta: {}
        }
      end

      def reveal
        date_str = params[:date].to_s
        guesses_param = params[:guesses].to_s

        if date_str.blank?
          render json: { data: nil, error: "Missing date parameter", meta: {} }, status: :unprocessable_entity
          return
        end

        if date_str.length > 20
          render json: { data: nil, error: "Invalid parameters", meta: {} }, status: :unprocessable_entity
          return
        end

        begin
          date = Date.parse(date_str)
        rescue Date::Error
          render json: { data: nil, error: "Invalid date format", meta: {} }, status: :unprocessable_entity
          return
        end

        puzzle = DailyPuzzle.for_date(date)
        unless puzzle
          render json: { data: nil, error: "No puzzle for this date", meta: {} }, status: :not_found
          return
        end

        guess_slugs = guesses_param.split(",").map(&:strip).select(&:present?)
        if guess_slugs.length < 6 && !guess_slugs.any? { |s| s.parameterize == puzzle.dish.slug }
          render json: { data: nil, error: "Complete the puzzle first", meta: {} }, status: :forbidden
          return
        end

        dish = puzzle.dish
        render json: {
          data: {
            dish_name: dish.name,
            cuisine: dish.cuisine,
            ingredients: dish.ingredients,
            description: dish.description,
            fun_fact: dish.fun_fact,
            image_url: dish.image_url
          },
          error: nil,
          meta: {}
        }
      end

      private

      def guess_params
        params.permit(:guess, :date)
      end
    end
  end
end
