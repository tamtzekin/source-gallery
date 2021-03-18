class User < ApplicationRecord
    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    
    has_secure_password


    def save_and_subscribe
        # Check if the user is valid (ie. everything validates)
        # Check Stripe token
        # Make Stripe customer
        # Add that Stripe customer to the plan they picked

        if self.valid?
            # Creates a stripe customer
            customer = Stripe::Customer.create(source: self.stripe_token, description: self.email)

            # Make a subscription in Stripe
            subscription = Stripe::Subscription.create(
                customer: customer.id, 
                items: [{ plan: self.subscription_plan}],
                trial_period_days: 30,
            )

            # Save customer ID to db
            self.stripe_customer = customer.id

            # Save the subscription ID to db
            self.stripe_subscription_id = subscription.id

            # Save everything
            self.save

        else
            false
        end

    rescue Stripe::CardError => e
        @message = e.json_body[:error][:message]

        # NB. errors is built into Rails
        self.errors.add(:stripe_token, @message)

        # Return that it didn't save successfully
        false


    
    end

end
