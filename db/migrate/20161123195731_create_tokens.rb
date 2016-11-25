class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.date :expires_at
      t.integer :app_users_id
      t.string :token

      t.timestamps
    end
  end
end
