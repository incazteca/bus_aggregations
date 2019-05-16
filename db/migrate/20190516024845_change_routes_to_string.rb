class ChangeRoutesToString < ActiveRecord::Migration[5.2]
  def change
    change_column :average_bus_stop_boardings, :routes, :string
  end
end
