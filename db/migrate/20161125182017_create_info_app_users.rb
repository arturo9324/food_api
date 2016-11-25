class CreateInfoAppUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :info_app_users do |t|
      t.references :app_user, foreign_key: true
      t.date :fecha_nacimiento
      t.float :peso
      t.float :estatura
      t.boolean :sexo
      t.float :max_calorias
      t.float :min_calorias
      t.booelan :embarazo
      t.boolean :lactancia

      t.timestamps
    end
  end
end
