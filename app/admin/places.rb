ActiveAdmin.register Place do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :tel, :url, :rating, :status, :longitude, :latitude, :description, :images => []
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :tel, :url, :rating, :status, :longitude, :latitude, :description, :discarded_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :tel
      f.input :url
      f.input :rating
      f.input :status
      f.input :longitude
      f.input :latitude
      f.input :description
      f.input :images, as: :file, input_html: { multiple: true }
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :address
    column :tel
    column :url
    column :rating
    column :status
    column :longitude
    column :latitude
    column :description
    actions
  end
end
