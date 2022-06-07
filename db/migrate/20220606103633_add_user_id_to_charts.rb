class AddUserIdToCharts < ActiveRecord::Migration[6.1]
  def change
    add_reference :charts, :user, foreign_key: true, optional: true
  end
end
