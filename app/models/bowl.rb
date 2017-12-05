class Bowl < ActiveRecord::Base
  require 'csv' 
  has_many :bowl_motif_matches   

  def self.new_bowl(bowl_info)
    bowl = Bowl.find_by_r_id(bowl_info[4])
    unless bowl
      bowl = Bowl.create
      bowl.sherd = bowl_info[0]
      bowl.fabric = bowl_info[1]
      bowl.origin = bowl_info[2]
      bowl.date = bowl_info[3]
      bowl.r_id = bowl_info[4]
      bowl.save
      return bowl
    else
      return bowl
    end
  end

  def self.csv_import

    CSV.foreach("/home/mene/remy_bowls/bowls.csv", :headers => false) do |row|

      if row[1] == "Sherd"
        next
      else
        bowl_info = []
        bowl_info << row[1] << row[6] << row[7] << row[8] << row[0]
        bowl = new_bowl(bowl_info)
        rim_motifs = Motif.populate(row[2])
        wall_motifs = Motif.populate(row[3])
        calyx_motifs = Motif.populate(row[4])
        medallion_motifs = Motif.populate(row[5])

        BowlMotifMatch.new_row(bowl.id, rim_motifs, wall_motifs, calyx_motifs, medallion_motifs)
      end

    end
  end

  def self.motifs_by_fabrics
    all_fab_hash = Hash.new
    fabrics = Bowl.select(:fabric).distinct
    all_fab_hash['f_count'] = fabrics.length


    fabrics.each do |fab|
      f_hash = Hash.new
      w_m = BowlMotifMatch.select("wall_motif").where("bowl_id in (select id from bowls where fabric=?)", fab.fabric).group("wall_motif").order("count_wall_motif desc").count("wall_motif")
      r_m = BowlMotifMatch.select("rim_motif").where("bowl_id in (select id from bowls where fabric=?)", fab.fabric).group("rim_motif").order("count_rim_motif desc").count("rim_motif")
      c_m = BowlMotifMatch.select("calyx_motif").where("bowl_id in (select id from bowls where fabric=?)", fab.fabric).group("calyx_motif").order("count_calyx_motif desc").count("calyx_motif")
      m_m = BowlMotifMatch.select("medallion_motif").where("bowl_id in (select id from bowls where fabric=?)", fab.fabric).group("medallion_motif").order("count_medallion_motif desc").count("medallion_motif")
      combined_hash = Hash.new
      combined_hash = w_m.merge(r_m){|k, o, n| o + n} 
      combined_hash.merge!(c_m){|k, o, n| o + n} 
      combined_hash.merge!(m_m){|k, o, n| o + n} 

      get_motif_names(w_m, r_m, c_m, m_m, combined_hash)

      f_hash["wall_motif"] = w_m
      f_hash["rim_motif"] = r_m
      f_hash["calyx_motif"] = c_m
      f_hash["medallion_motif"] = m_m
      f_hash["totals"] = combined_hash
      all_fab_hash[fab.fabric] = f_hash
      #byebug
    end
    return all_fab_hash
  end

  def self.get_motif_names(w_m, r_m, c_m, m_m, combined_hash)
    w_m.each do |k, v|
      m = Motif.find_by_id(k)
      w_m[k] = [m.motif_name, v] if m
    end
    r_m.each do |k, v|
      m = Motif.find_by_id(k)
      r_m[k] = [m.motif_name, v] if m
    end
    c_m.each do |k, v|
      m = Motif.find_by_id(k)
      c_m[k] = [m.motif_name, v] if m
    end
    m_m.each do |k, v|
      m = Motif.find_by_id(k)
      m_m[k] = [m.motif_name, v] if m
    end
    combined_hash.each do |k, v|
      m = Motif.find_by_id(k)
      combined_hash[k] = [m.motif_name, v] if m
    end

  end

end