class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :name
      t.string :email
      t.string :fb_id
      t.string :token
      t.string :image
      t.boolean :sharing
      t.string :status

      t.timestamps
    end
  end
end
