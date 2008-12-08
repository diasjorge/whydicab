module Merb
  module GlobalHelpers
    SITES = Mash.new("Qvitta" => "http://qvitta.net",
                     "Merb" => "http://merbivore.com",
                     "DataMapper" => "http://datamapper.org",
                     "Least Significant Bit" => "http://least-significant-bit.com")      

    # helpers defined here available to all views.  
    def tag_cloud(tags, classes)
      return "" if tags.nil? || tags.empty?
      max, min = 0, 0
      tags.each do |t|
        max = t.taggings.count.to_i if t.taggings.count.to_i > max
        min = t.taggings.count.to_i if t.taggings.count.to_i < min
      end
      divisor = ((max - min) / classes.size) + 1
      tags.each do |t|
        yield t, classes[(t.taggings.count.to_i - min) / divisor]
      end
    end

    def site_links
      SITES.map{|x| "<li>#{link_to x[0], x[1]}</li>"}.join("")
    end

    def navigation_links
      SITES.map{|x| link_to x[0], x[1]}.join(" | ")
    end

  end
end
