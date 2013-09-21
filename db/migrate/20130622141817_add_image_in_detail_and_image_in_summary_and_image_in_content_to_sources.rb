class AddImageInDetailAndImageInSummaryAndImageInContentToSources < ActiveRecord::Migration
  def change
    add_column :sources, :image_in_summary, :boolean, :default => false
    add_column :sources, :image_in_content, :boolean, :default => false
    add_column :sources, :image_in_detail, :boolean, :default => false
  end
end
