ActiveAdmin.register City do
  permit_params :name
  config.sort_order = "id_asc"

end
