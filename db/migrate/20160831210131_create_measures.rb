class CreateMeasures < ActiveRecord::Migration[5.0]
  def change
    create_table :measures do |t|
      t.string :nombre
      t.string :abrebiacion

      t.timestamps
    end
  end
end
