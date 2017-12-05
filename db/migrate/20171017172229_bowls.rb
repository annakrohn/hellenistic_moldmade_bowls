class Bowls < ActiveRecord::Migration[5.0]
  def change
    create_table :bowls do |t|
      t.integer "r_id"
      t.string    "sherd"
      t.string    "fabric"
      t.string    "origin"
      t.string    "date"
    end
  end
end
