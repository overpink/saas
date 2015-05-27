class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :owner_type
      t.integer :owner_id
      t.text :content
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
