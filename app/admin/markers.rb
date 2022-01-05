ActiveAdmin.register Marker do
  filter :pair_name
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :pair_name
  config.sort_order = 'id_asc'

  #
  # or
  #
  # permit_params do
  #   permitted = [:pair_name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
