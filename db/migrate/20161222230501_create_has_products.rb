class CreateHasProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :has_products do |t|
      t.references :product, foreign_key: true
      t.references :app_user, foreign_key: true
      t.float :porciones
      t.float :cantidad

      t.timestamps
    end
  end
end
