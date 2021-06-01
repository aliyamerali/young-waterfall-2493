class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.string :name
      t.integer :age
      t.boolean :currently_working

      t.timestamps
    end
  end
end
