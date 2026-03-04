module Api
  module V1
    class TranslationsController < ApplicationController
      SUPPORTED_LOCALES = (%w[en] + ContentTranslation::LOCALES).freeze

      def index
        locale = permitted_params[:locale].to_s.strip

        unless SUPPORTED_LOCALES.include?(locale)
          render json: { data: nil, error: "Unsupported locale", meta: {} }, status: :unprocessable_entity
          return
        end

        dishes = Rails.cache.fetch("translations/catalog", expires_in: 1.hour) do
          Dish.select(:name, :cuisine).order(:name).map { |d| { name: d.name, cuisine: d.cuisine } }
        end

        if locale == "en"
          render json: {
            data: { locale: locale, catalog: dishes, ingredients: {}, cuisines: {}, dish_names: {} },
            error: nil,
            meta: {}
          }
          return
        end

        translations = Rails.cache.fetch("translations/#{locale}", expires_in: 1.hour) do
          ContentTranslation.grouped_by_locale(locale)
        end

        render json: {
          data: {
            locale: locale,
            catalog: dishes,
            **translations
          },
          error: nil,
          meta: {}
        }
      end

      private

      def permitted_params
        params.permit(:locale)
      end
    end
  end
end
