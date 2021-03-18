class Item < ApplicationRecord

    has_many :category_items
    # Talk to the categories model, but go via :category_items. Not a direct model-to-model link.
    has_many :categories, through: :category_items
    
    validates :title, presence: true 
    
    # :image comes from schema.rb
    mount_uploader :image, ImageUploader
end
