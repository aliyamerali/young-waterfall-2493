class CreateCastings < ActiveRecord::Migration[5.2]
  def change
    create_table :castings do |t|
      t.references :movie, foreign_key: true
      t.references :actor, foreign_key: true

      t.timestamps
    end
  end
end
