class CreateDisease < ActiveRecord::Migration[5.0]
  def change
    create_table :diseases do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
