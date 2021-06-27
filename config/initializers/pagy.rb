require 'pagy/extras/overflow'

Pagy::VARS[:items] = Settings.pagy.items
Pagy::VARS[:overflow] = :empty_page