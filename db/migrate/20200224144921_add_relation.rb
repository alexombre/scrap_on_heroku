class AddRelation < ActiveRecord::Migration[5.0]
  def change
    add_reference :options, :event, foreign_key: true
    add_reference :bets, :option, foreign_key: true
  end
end
