ActiveAdmin.register Shop do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :url, :description, :floor_id, :place_id
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :description
      f.actions
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :url
    column :description
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :url
      row :description
    end
  end
end
