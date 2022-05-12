class AddMybestToCharts < ActiveRecord::Migration[6.1]
  def change
    add_column :charts, :mybest, :int
  end
end
