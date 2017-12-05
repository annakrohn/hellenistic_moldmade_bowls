class BowlMotifMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :bowl_motif_matches do |t|
      t.integer "bowl_id"
      t.integer "rim_motif"
      t.integer "wall_motif"
      t.integer "calyx_motif"
      t.integer "medallion_motif"
    end
    add_foreign_key "bowl_motif_matches", "bowls", name: "fk_bowl_motif_match_1"
    add_foreign_key "bowl_motif_matches", "motifs", column: "calyx_motif", name: "fk_bowl_motif_match_4"
    add_foreign_key "bowl_motif_matches", "motifs", column: "medallion_motif", name: "fk_bowl_motif_match_5"
    add_foreign_key "bowl_motif_matches", "motifs", column: "rim_motif", name: "fk_bowl_motif_match_2"
    add_foreign_key "bowl_motif_matches", "motifs", column: "wall_motif", name: "fk_bowl_motif_match_3"
  end
end
