module Archive
  def self.included(base)
    base.send(:extend, ClassMethods)
  end
  module ClassMethods
    def find_by_year(year)
      self.all(:published_at.like => "#{year}%", :published => true, :order => [:published_at.desc])
    end

    def find_by_year_month(year, month)
      month = month.to_i.two_digits
      self.all(:published_at.like => "#{year}-#{month}%", :published => true, :order => [:published_at.desc])
    end

    def find_by_year_month_day(year, month, day)
      month = month.to_i.two_digits
      day = day.to_i.two_digits
      self.all(:published_at.like => "#{year}-#{month}-#{day}%", :published => true, :order => [:published_at.desc])
    end

    def get_archive_hash
      counts = repository.adapter.query("SELECT COUNT(*) as count, #{specific_date_function} FROM articles WHERE published_at IS NOT NULL AND published = ? GROUP BY year, month ORDER BY year DESC, month DESC",true)
      archives = counts.map do |entry|
        {
          :name => "#{Date::MONTHNAMES[entry.month.to_i]} #{entry.year}",
          :month => entry.month.to_i,
          :year => entry.year.to_i,
          :article_count => entry.count
        }
      end
      archives
    end

    private
    def specific_date_function
      if Merb::Orms::DataMapper.config[:adapter] == "sqlite3"
        "strftime('%Y', published_at) as year, strftime('%m', published_at) as month"
      else
        "extract(year from published_at) as year, extract(month from published_at) as month"
      end
    end
  end
end

