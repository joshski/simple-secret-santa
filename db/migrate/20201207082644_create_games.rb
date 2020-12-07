class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :uuid, null: false

      t.timestamps
    end
  end
end
