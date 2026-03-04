class Rack::Attack
  throttle("api/ip", limit: 30, period: 60) do |req|
    req.ip if req.path.start_with?("/api/")
  end

  throttle("search/ip", limit: 60, period: 60) do |req|
    req.ip if req.path.start_with?("/api/v1/dishes/search")
  end

  throttle("auth/ip", limit: 10, period: 60) do |req|
    req.ip if req.path.start_with?("/api/v1/auth/") && (req.post? || req.delete?)
  end
end
