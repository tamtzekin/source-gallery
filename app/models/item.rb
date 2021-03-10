class Item < ApplicationRecord
    validates :title, presence: true 
    
    # :image comes from schema.rb
    mount_uploader :image, ImageUploader
end
