class CreateRecommends < ActiveRecord::Migration[6.1]
  def change
    create_table :recommends do |t|
      t.string :movie_code
      t.string :title
      t.string :img
      t.float :star_point

      t.timestamps
    end
  end
end
