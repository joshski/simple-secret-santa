class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.belongs_to :game, null: false, foreign_key: true
      t.belongs_to :recipient, null: true, foreign_key: { to_table: :players }
      t.string :uuid, null: false
      t.string :name, null: false
      t.datetime :revealed_at

      t.timestamps
    end
  end
end
