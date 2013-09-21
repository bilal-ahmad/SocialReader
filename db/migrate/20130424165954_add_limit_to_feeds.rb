class AddLimitToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :limit, :integer
  end
end
