class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :code
      t.string :category
      t.string :title
      t.string :link
      t.string :img
      t.float :star_point
      t.string :explain
      t.string :cast

      t.timestamps
    end
  end
end
