ActiveAdmin.register Direction do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :marker_id, :direct
  config.sort_order = "id_asc"

  #
  # or
  #
  # permit_params do
  #   permitted = [:marker_id, :direct]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    column :id
    column :marker
    column :floor_id
    column :place_id
    column :direct
    actions
  end
end
