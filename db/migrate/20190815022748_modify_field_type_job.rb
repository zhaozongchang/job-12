class ModifyFieldTypeJob < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :category_id, :integer
  end
end
