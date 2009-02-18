module Merb
  module GlobalHelpers
    def pluralize(count, word)
      new_word = (count == 1 ? word : word.plural)
      "#{count} #{new_word}"
    end
  end
end
