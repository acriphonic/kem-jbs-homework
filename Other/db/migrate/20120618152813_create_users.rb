class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :sex
      t.integer :age
      t.string :occupation_id
      t.integer :zip

      t.timestamps
    end
  end
end
