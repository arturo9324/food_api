class CreateDisease < ActiveRecord::Migration[5.0]
  def change
    create_table :diseases do |t|
      t.string :nombre
    end
  end
end
