ActiveAdmin.register Item do

    permit_params :title, :description, :image, category_ids: []
    # categories are an array, so you need to category_ids: []

    form do |f| 
        f.inputs do 
            f.input :title
            f.input :description
            f.input :image
            
            # This exists because of the has_Many relationship
            f.input :categories, as: :check_boxes, collection: Category.order("title asc")
        end 

        f.actions
    end 

  
end
