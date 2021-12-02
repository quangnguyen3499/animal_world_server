require 'pagy/extras/overflow'

Pagy::DEFAULT[:items] = Settings.pagy.items
Pagy::DEFAULT[:overflow] = :empty_page