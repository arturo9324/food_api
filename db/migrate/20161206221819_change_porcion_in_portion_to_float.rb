class ChangePorcionInPortionToFloat < ActiveRecord::Migration[5.0]
  def up
  	change_column :portions, :porcion, :float, precision: 2, scale: 2
  end

  def down
  	change_column :portions, :porcion, :integer
  end
end
