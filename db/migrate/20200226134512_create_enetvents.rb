class CreateEnetvents < ActiveRecord::Migration[5.0]
  def change
    
    create_table :enetvents do |t|
      t.string :title
      t.string :sport
      t.date :date
      t.integer :enet_id

      t.timestamps
    end
    add_reference :events, :enetvent, foreign_key: true
  end
end
