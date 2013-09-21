class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.references :source
      t.string :name
      t.string :url
      t.string :image
      t.boolean :image_in_detail
      t.boolean :status

      t.timestamps
    end
  end
end
