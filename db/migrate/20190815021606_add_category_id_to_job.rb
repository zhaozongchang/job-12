class AddCategoryIdToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :category_id, :inyeger
  end
end
