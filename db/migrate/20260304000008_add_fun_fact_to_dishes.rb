class AddFunFactToDishes < ActiveRecord::Migration[8.1]
  def change
    add_column :dishes, :fun_fact, :text
  end
end
