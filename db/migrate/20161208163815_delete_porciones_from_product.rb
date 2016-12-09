class DeletePorcionesFromProduct < ActiveRecord::Migration[5.0]
  def up
  	remove_column :products, :porciones
  end

  def down
  	add_column :products, :porciones, :boolean, default: false
  end
end
