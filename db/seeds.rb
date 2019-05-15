# frozen_string_literal: true

require 'csv'

SOURCE_FILE = File.join(Rails.root, 'db', 'cta_ridership_2012.csv')

def parse_coordinates(raw_coords)
  raw_coords.slice(1..-2).split(',').map(&:to_f)
end

def seed_average_bus_stop_boardings
  boardings = []

  CSV.foreach(SOURCE_FILE, headers: true, converters: :all, header_converters: :symbol) do |row|
    begin
      latitude, longitude = parse_coordinates(row[:location])
      intersection = [row[:on_street], row[:cross_street]].sort.join(' & ').upcase

      boardings << {
        id: row[:stop_id],
        on_street: row[:on_street],
        cross_street: row[:cross_street],
        intersection: intersection,
        routes: row[:routes],
        boardings: row[:boardings],
        alightings: row[:alightings],
        month_beginning: row[:month_beginning],
        daytype: row[:daytype],
        latitude: latitude,
        longitude: longitude
      }
    rescue StandardError
      # Whatever the error just keep going for the moment
      puts "Invalid Row: #{row}"
      next
    end
  end

  AverageBusStopBoarding.create(boardings)
end

seed_average_bus_stop_boardings
