module ItemsHelper

    def format_categories(categories)
        # Get each category, turn it inton a link, set it to an array called 'links'
        links = categories.map do |c|
            link_to c.title, category_path(c)
        end 

        # Changes the links array into just a link (with to_sentence)
        #and return it as html with .html_safe 
        links.to_sentence.html_safe
    end 

end
