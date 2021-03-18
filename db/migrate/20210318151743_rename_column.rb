class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :stripe_subscription, :stripe_subscription_id
  end
end
