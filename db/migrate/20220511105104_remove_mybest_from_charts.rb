class RemoveMybestFromCharts < ActiveRecord::Migration[6.1]
  def change
    remove_column :charts, :mybest, :bool
  end
end
