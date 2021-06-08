class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.text :username
      t.string :password_hash
      t.string :password_salt
      t.string :first_name
      t.string :last_name
      t.text :url
      t.string :short_url

      t.timestamps
    end
  end
end
