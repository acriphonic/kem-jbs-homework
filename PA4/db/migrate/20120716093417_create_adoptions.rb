class CreateAdoptions < ActiveRecord::Migration
  def change
    create_table :adoptions do |t|
      t.integer :user_id
      t.string :title
      t.string :descr
      t.boolean :approved

      t.timestamps
    end
  end
end
