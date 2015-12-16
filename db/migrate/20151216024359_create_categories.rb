class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :is_crawl

      t.timestamps null: false
    end
  end
end
