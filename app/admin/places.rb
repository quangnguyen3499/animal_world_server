ActiveAdmin.register Place do
  filter :city
  filter :name
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #

  permit_params :name, :address, :tel, :url, :longitude, :latitude, :description
  config.sort_order = "id_asc"

  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :tel, :url, :longitude, :latitude, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :tel
      f.input :url
      f.input :description
      f.actions
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :address
    column :tel
    column :url
    column :description
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :address
      row :tel
      row :url
      row :description
    end
  end
end
