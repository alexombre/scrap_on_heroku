class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :sport
      t.string :title
      t.string :home
      t.string :away
      t.date :date

      t.timestamps
    end
  end
end
