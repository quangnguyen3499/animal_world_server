ActiveAdmin.register Statistic do
  filter :floor_id
  filter :place_id
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :floor_id, :place_id, :graph
  config.sort_order = "id_asc"

  #
  # or
  #
  # permit_params do
  #   permitted = [:floor_id, :place_id, :nodes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
