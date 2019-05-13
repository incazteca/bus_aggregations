class CreateAverageBusStopBoardings < ActiveRecord::Migration[5.2]
  def change
    create_table :average_bus_stop_boardings do |t|
      t.string :on_street
      t.string :cross_street
      t.integer :routes
      t.float :boardings
      t.float :alightings
      t.date :month_beginning
      t.string :daytype
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
