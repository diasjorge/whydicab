module Merb
  module GlobalHelpers
    # helpers defined here available to all views.

    def site_links
      Settings.site_links || []
    end

    def sidebar_links
      site_links.map{|x| "<li>#{link_to x[0], x[1]}</li>"}.join("")
    end

    def navigation_links
      site_links.map{|x| link_to x[0], x[1]}.join(" | ")
    end

  end
end
