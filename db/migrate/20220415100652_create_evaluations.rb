class CreateEvaluations < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluations do |t|
      t.integer :score
      t.string :comment
      t.references :chart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
