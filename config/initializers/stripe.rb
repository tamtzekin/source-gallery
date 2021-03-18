Stripe.api_key = Rails.application.credentials.stripe[Rails.env.to_sym][:stripe_secret_key]
