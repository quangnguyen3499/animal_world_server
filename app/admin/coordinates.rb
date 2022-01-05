ActiveAdmin.register Coordinate do
  filter :shop
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :shop_id, :name, :longitude, :latitude
  #
  # or
  #
  permit_params :shop_id, :name, :longitude, :latitude
  config.sort_order = "id_asc"

end
