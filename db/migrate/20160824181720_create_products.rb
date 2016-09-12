class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :nombre
      t.float :cantidad
      t.float :calorias
      t.string :codigo
      t.boolean :porciones

      t.timestamps
    end
  end
end
