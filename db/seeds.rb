# frozen_string_literal: true

require 'csv'

SOURCE_FILE = File.join(Rails.root, 'db', 'cta_ridership_2012.csv')

def parse_coordinates(raw_coords)
  raw_coords.slice(1..-2).split(',').map(&:to_f)
end

def seed_average_bus_stop_boardings
  boardings = []

  CSV.foreach(SOURCE_FILE, headers: true, converters: :all, header_converters: :symbol) do |row|
    latitude, longitude = parse_coordinates(row[:location])
    boardings << {
      id: row[:stop_id],
      on_street: row[:on_street],
      cross_street: row[:cross_street],
      routes: row[:routes],
      boardings: row[:boardings],
      alightings: row[:alightings],
      month_beginning: row[:month_beginning],
      daytype: row[:daytype],
      latitude: latitude,
      longitude: longitude
    }
  end

  AverageBusStopBoarding.create(boardings)
end

seed_average_bus_stop_boardings
