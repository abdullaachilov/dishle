Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins ENV.fetch("ALLOWED_ORIGINS", "https://dish-le.com").split(",")
    resource "/api/*",
      headers: :any,
      methods: [:get, :post, :options],
      credentials: true
  end
end
