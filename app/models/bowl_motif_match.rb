class BowlMotifMatch < ActiveRecord::Base
  has_many :bowls
  has_many :motifs

  def self.new_row(bowl_id, rim, wall, calyx, medallion)
    if rim && !rim.empty?
      rim.each do |i|
        bmm = BowlMotifMatch.new
        bmm.bowl_id = bowl_id
        bmm.rim_motif = i
        bmm.save
      end
    end

    if wall && !wall.empty?
      wall.each do |i|
        bmm = BowlMotifMatch.new
        bmm.bowl_id = bowl_id
        bmm.wall_motif = i
        bmm.save
      end
    end

    if calyx && !calyx.empty?
      calyx.each do |i|
        bmm = BowlMotifMatch.new
        bmm.bowl_id = bowl_id
        bmm.calyx_motif = i
        bmm.save
      end
    end

    if medallion && !medallion.empty?
      medallion.each do |i|
        bmm = BowlMotifMatch.new
        bmm.bowl_id = bowl_id
        bmm.medallion_motif = i
        bmm.save
      end
    end
  end
end