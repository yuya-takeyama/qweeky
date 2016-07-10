class CreateAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :access_tokens do |t|
      t.references :user
      t.text :token

      t.timestamps
    end
  end
end
