API_BASE_URL = Rails.env.production? ? Rails.application.credentials[:production][:url] : Rails.application.credentials[:development][:url]
