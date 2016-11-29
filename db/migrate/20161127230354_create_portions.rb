class CreatePortions < ActiveRecord::Migration[5.0]
  def change
    create_table :portions do |t|
      t.references :product, foreign_key: true
      t.references :measure, foreign_key: true
      t.integer :porcion
      t.float :cantidad
      t.string :equivalencia

      t.timestamps
    end
  end
end
