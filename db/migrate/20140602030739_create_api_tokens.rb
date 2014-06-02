class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.string :identifier, null: false
      t.string :password_digest

      t.timestamps
    end

    add_index :api_tokens, :identifier, unique: true
  end
end
