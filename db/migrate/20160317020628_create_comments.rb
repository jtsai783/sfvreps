class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :comment
    	t.string :player_id
    	t.integer :rating
    	t.string :byline
    	t.string :tripcode

      t.timestamps null: false
    end
  end
end
