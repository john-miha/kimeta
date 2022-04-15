class CreateViewpoints < ActiveRecord::Migration[6.1]
  def change
    create_table :viewpoints do |t|
      t.string :name
      t.references :evaluation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
