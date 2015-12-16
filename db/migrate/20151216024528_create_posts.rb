class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :category_id
      t.integer :point
      t.string :title
      t.string :image_url

      t.timestamps null: false
    end
  end
end
