class Motifs < ActiveRecord::Migration[5.0]
  def change
    create_table :motifs do |t|
      t.string  "motif_name"
    end
  end
end
