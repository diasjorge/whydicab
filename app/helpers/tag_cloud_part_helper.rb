module Merb
  module TagCloudPartHelper
    def tag_cloud(tags, classes)
      return "" if tags.nil? || tags.empty?
      max, min = 0, 0
      tags.each do |t|
        max = t.taggings.size.to_i if t.taggings.size.to_i > max
        min = t.taggings.size.to_i if t.taggings.size.to_i < min
      end
      divisor = ((max - min) / classes.size) + 1
      tags.each do |t|
        yield t, classes[(t.taggings.size.to_i - min) / divisor]
      end
    end
  end
end # Merb
