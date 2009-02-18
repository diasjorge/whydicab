module Merb
  module GlobalHelpers
    SITES = Mash.new("Qvitta" => "http://qvitta.net",
                     "Merb" => "http://merbivore.com",
                     "DataMapper" => "http://datamapper.org",
                     "Least Significant Bit" => "http://least-significant-bit.com")

    # helpers defined here available to all views.
    def site_links
      SITES.map{|x| "<li>#{link_to x[0], x[1]}</li>"}.join("")
    end

    def navigation_links
      SITES.map{|x| link_to x[0], x[1]}.join(" | ")
    end

  end
end
