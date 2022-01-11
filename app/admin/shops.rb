ActiveAdmin.register Shop do
  filter :name
  filter :place_id
  filter :floor_id
  filter :category
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :floor_id, :place_id
  config.sort_order = "id_asc"

  form do |f|
    f.inputs do
      f.input :name
      f.input :floor_id
      f.input :place_id
      f.actions
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :floor_id
    column :place_id
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :floor_id
      row :place_id
    end
  end
end
