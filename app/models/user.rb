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


    def update_with_stripe(form_params)
        # Update the model with form params
        # Check if it's valid
        # If valid, update in Stripe
        # Then update the database
        self.assign_attributes(form_params)

        if self.valid?
            # Get the subscription from Stripe
            subscription = Stripe::Subscription.retrieve(self.stripe_subscription_id)

            # Get the first item from the Stripe subscription
            item_id = subscription.items.data[0].id

            # Make a new items list to replace old data
            items = [
                { id: item_id, plan: self.subscription_plan }
            ]

            # Overwrite items with new items
            subscription.items = items

            # Save subscription to Stripe's db
            subscription.save

            # Save our data to our db
            self.save

        else
            false
        end
    end 

end
