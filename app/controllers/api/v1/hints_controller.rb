module Api
  module V1
    class HintsController < ApplicationController
      MAX_TOTAL_HINTS = 3

      def create
        date_str = params[:date].to_s
        revealed = params[:revealed]

        if date_str.blank? || date_str.length > 20
          return render json: { data: nil, error: "Invalid parameters", meta: {} },
                        status: :unprocessable_entity
        end

        begin
          date = Date.parse(date_str)
        rescue Date::Error
          return render json: { data: nil, error: "Invalid date format", meta: {} },
                        status: :unprocessable_entity
        end

        puzzle = DailyPuzzle.find_by(puzzle_date: date)
        unless puzzle
          return render json: { data: nil, error: "No puzzle for this date", meta: {} },
                        status: :not_found
        end

        revealed_slots = Array(revealed).map(&:to_s).select { |s| Dish::INGREDIENT_SLOTS.include?(s) }

        if revealed_slots.length >= MAX_TOTAL_HINTS
          return render json: { data: nil, error: "Maximum hints reached", meta: {} },
                        status: :unprocessable_entity
        end

        unrevealed = Dish::INGREDIENT_SLOTS.reject { |s| revealed_slots.include?(s) }
        if unrevealed.empty?
          return render json: { data: nil, error: "All slots revealed", meta: {} },
                        status: :unprocessable_entity
        end

        hint_index = (puzzle.puzzle_number + revealed_slots.length) % unrevealed.length
        next_slot = unrevealed[hint_index]
        hint_value = puzzle.dish.send(next_slot)

        render json: {
          data: {
            slot: next_slot,
            value: hint_value,
            hints_used: revealed_slots.length + 1
          },
          error: nil,
          meta: {}
        }
      end
    end
  end
end
