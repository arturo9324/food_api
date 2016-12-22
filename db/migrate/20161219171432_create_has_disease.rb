class CreateHasDisease < ActiveRecord::Migration[5.0]
  def change
    create_table :has_diseases do |t|
      t.references :disease, foreign_key: true
      t.references :info_app_user, foreign_key: true
    end
  end
end
