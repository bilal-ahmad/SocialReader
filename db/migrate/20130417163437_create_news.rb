class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :title
      t.string :author
      t.text :summary
      t.text :content
      t.text :image
      t.text :category
      t.text :url
      t.text :guid
      t.text :news_type
      t.integer :source_id
      t.datetime :published_at
      t.timestamps
    end
  end
end
