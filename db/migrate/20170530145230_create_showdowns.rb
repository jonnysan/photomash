class CreateShowdowns < ActiveRecord::Migration[5.0]
  def change
    create_table :showdowns do |t|
      t.integer :winner_id
      t.integer :loser_id
      t.float :winner_oldrating
      t.float :winner_newrating
      t.float :loser_oldrating
      t.float :loser_newrating

      t.timestamps

    end
  end
end
