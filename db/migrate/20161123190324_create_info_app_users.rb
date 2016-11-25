class CreateInfoAppUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :info_app_users do |t|
      t.integer :app_users_id
      t.date :fecha_nacimiento
      t.float :peso
      t.float :estatura
      t.boolean :sexo
      t.float :max_calorias
      t.float :min_calorias
      t.boolean :embarazo
      t.boolean :lactancia

      t.timestamps
    end
  end
end
