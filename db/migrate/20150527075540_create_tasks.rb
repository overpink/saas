class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :project_id
      t.text :content
      t.integer :status
      t.integer :user_id
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
