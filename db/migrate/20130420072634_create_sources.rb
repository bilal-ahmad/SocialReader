class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :logo
      t.string :url
      t.boolean :status

      t.timestamps
    end
  end
end
