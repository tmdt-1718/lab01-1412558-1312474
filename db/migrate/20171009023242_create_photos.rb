class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :cover
      t.integer :num_views

      t.timestamps
    end
  end
end
