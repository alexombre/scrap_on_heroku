class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.string :label
      t.float :value

      t.timestamps
    end
  end
end
