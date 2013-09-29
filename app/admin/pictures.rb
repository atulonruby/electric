ActiveAdmin.register Picture do
  show do |ad|
        attributes_table do
          row :id
          row :image do
            image_tag(ad.image.url,:size => "500x500")
          end
          row :width
          row :height
          row :description
          row :created_at
          row :updated_at
          
        end
        active_admin_comments
      end
end
