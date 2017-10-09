class AddColumnViewCoverToPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :num_views, :integer, default: 0
  	add_column :posts, :cover, :string
  end
end
