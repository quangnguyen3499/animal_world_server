ActiveAdmin.register Animal do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :typical, :name, :description, :quantity, :images => []
  #
  # or
  #
  # permit_params do
  #   permitted = [:typical, :name, :description, :quantity, :discarded_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs do
      f.input :typical
      f.input :name
      f.input :description
      f.input :quantity
      f.input :images, as: :file, input_html: { multiple: true }
    end

    f.actions
  end

  index do
    selectable_column
    column :id
    column :typical
    column :name
    column :description
    column :quantity
    actions
  end
  
  show do
    attributes_table do
      row :images do
        div do
          animal.images.each do |img|
            div do
              image_tag url_for(img), size: "200x200"
            end
          end
        end
      end

      row :typical
      row :name
      row :description
      row :quantity
    end
  end
end
