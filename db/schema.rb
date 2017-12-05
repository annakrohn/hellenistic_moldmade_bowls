# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171017172504) do

  create_table "bowl_motif_matches", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "bowl_id"
    t.integer "rim_motif"
    t.integer "wall_motif"
    t.integer "calyx_motif"
    t.integer "medallion_motif"
    t.index ["bowl_id"], name: "fk_bowl_motif_match_1", using: :btree
    t.index ["calyx_motif"], name: "fk_bowl_motif_match_4", using: :btree
    t.index ["medallion_motif"], name: "fk_bowl_motif_match_5", using: :btree
    t.index ["rim_motif"], name: "fk_bowl_motif_match_2", using: :btree
    t.index ["wall_motif"], name: "fk_bowl_motif_match_3", using: :btree
  end

  create_table "bowls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "r_id"
    t.string  "sherd"
    t.string  "fabric"
    t.string  "origin"
    t.string  "date"
  end

  create_table "motifs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "motif_name"
  end

  add_foreign_key "bowl_motif_matches", "bowls", name: "fk_bowl_motif_match_1"
  add_foreign_key "bowl_motif_matches", "motifs", column: "calyx_motif", name: "fk_bowl_motif_match_4"
  add_foreign_key "bowl_motif_matches", "motifs", column: "medalion_motif", name: "fk_bowl_motif_match_5"
  add_foreign_key "bowl_motif_matches", "motifs", column: "rim_motif", name: "fk_bowl_motif_match_2"
  add_foreign_key "bowl_motif_matches", "motifs", column: "wall_motif", name: "fk_bowl_motif_match_3"
end
