class AddSummarycommentToCharts < ActiveRecord::Migration[6.1]
  def change
    add_column :charts, :summarycomment, :string
  end
end
