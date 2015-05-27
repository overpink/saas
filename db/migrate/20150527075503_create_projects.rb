class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :tenant_id
      t.string :name
      t.string :description
      t.string :slug

      t.timestamps null: false
    end
  end
end
