class Motif < ActiveRecord::Base
  has_many :bowl_motif_matches

  def self.new_motif(name)
    motif = Motif.new
    motif.motif_name = name
    motif.save
    return motif
  end

  def self.populate(motif_string)
    unless motif_string == nil || motif_string == ""
      motif_list = motif_string.split("; ")
      motif_ids = []
      motif_list.each do |motif|
        m = Motif.find_by_motif_name(motif)
        unless m
          m = new_motif(motif)
        end
        motif_ids << m.id
      end
      return motif_ids
    end
  end
end