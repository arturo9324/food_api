class ChangeProductCaloriasToFloat < ActiveRecord::Migration[5.0]
  def up
  	change_column :products, :calorias, :int
  end

  def down
	change_column :products, :calorias, :float
  end
end
