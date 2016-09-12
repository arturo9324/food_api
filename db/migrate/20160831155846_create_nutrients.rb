class CreateNutrients < ActiveRecord::Migration[5.0]
  def change
    create_table :nutrients do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
