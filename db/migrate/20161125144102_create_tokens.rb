class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.datetime :expires_at
      t.references :app_user, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
