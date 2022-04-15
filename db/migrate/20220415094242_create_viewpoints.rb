class CreateViewpoints < ActiveRecord::Migration[6.1]
  def change
    create_table :viewpoints do |t|
      t.string :name

      t.timestamps
    end
  end
end
