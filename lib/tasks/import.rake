# run `bundle exec rails import:data`
require 'database_cleaner'

namespace :import do
  desc "Import shop & coordinate from spreadsheet"
  task data: :environment do  
    puts "Clean shop, coordinate, statistic & direction"
    Shop.destroy_all
    Coordinate.destroy_all
    Statistic.destroy_all
    Direction.destroy_all
    ActiveRecord::Base.connection.execute("TRUNCATE shops")
    ActiveRecord::Base.connection.execute("TRUNCATE coordinates")
    ActiveRecord::Base.connection.execute("TRUNCATE statistics")
    ActiveRecord::Base.connection.execute("TRUNCATE directions")
    
    puts 'Importing place, marker, direction, shop & coordinate...'
    Roo::Spreadsheet.open('db/seed/coopmartDN.xlsx').each_with_pagename do |name, data|
      headers = data.row(1)
      nodes = []
      graph = [[]]
      floor_id = nil
      place_id = nil
      data.each_with_index do |row, idx|
        next if idx == 0
        data = Hash[[headers, row].transpose]
        next if data['graph'].nil?
        if data['name'].present?
          shop = Shop.new(name: data['name'], category_id: data['category_id'], place_id: data['place_id'], 
            floor_id: data['floor_id'])
          floor_id = data['floor_id']
          place_id = data['place_id']
          shop.save!
          Coordinate.create!(shop_id: shop.id, longitude: data['longitude'], latitude: data['latitude'])
        end
        Direction.create!(marker_id: Marker.find_by(pair_name: data['pair_name']).id, 
            floor_id: floor_id, place_id: place_id, direct: data['direct'])
        graph << graph_data(data['graph'], data['pair_name'])
        graph.delete([])
      end
      Place.first.statistics.create! floor_id: floor_id, graph: graph
    end
    
    Roo::Spreadsheet.open('db/seed/bigcDN.xlsx').each_with_pagename do |name, data|
      headers = data.row(1)
      nodes = []
      graph = [[]]
      floor_id = nil
      place_id = nil
      data.each_with_index do |row, idx|
        next if idx == 0
        data = Hash[[headers, row].transpose]
        next if data['graph'].nil?
        if data['name'].present?
          shop = Shop.new(name: data['name'], category_id: data['category_id'], place_id: data['place_id'], 
            floor_id: data['floor_id'])
          floor_id = data['floor_id']
          place_id = data['place_id']
          shop.save!
          Coordinate.create!(shop_id: shop.id, longitude: data['longitude'], latitude: data['latitude'])
        end
        Direction.create!(marker_id: Marker.find_by(pair_name: data['pair_name']).id, 
            floor_id: floor_id, place_id: place_id, direct: data['direct'])
        graph << graph_data(data['graph'], data['pair_name'])
        graph.delete([])
      end
      Place.second.statistics.create! floor_id: floor_id, graph: graph
    end
    puts 'Importing success!'
  end
end

def graph_data(graph, pair_name)
  temp = pair_name.split('a')
  ['a' << temp[1], 'a' << temp[2], graph]
end
