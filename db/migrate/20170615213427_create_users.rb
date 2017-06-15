class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.string :profile_pic_url, null: false
    end
    add_index :users, :username
    add_index :users, :session_token
  end
end
