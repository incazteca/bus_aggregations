class AddIntersectionToAverageBusStopBoarding < ActiveRecord::Migration[5.2]
  def change
    add_column :average_bus_stop_boardings, :intersection, :string
  end
end
