class Articles < Application
  # provides :xml, :yaml, :js

  def index
    provides :atom, :rss
    if params[:day]
      @articles = Article.find_by_year_month_day(params[:year], params[:month], params[:day])
    elsif params[:month]
      @articles = Article.find_by_year_month(params[:year], params[:month])
    elsif params[:year]
      @articles = Article.find_by_year(params[:year])
    else
      @articles = Article.find_recent
    end
    etag_cache(Article.first(:order => [:updated_at.desc]), "all")
    cache_or_display(@articles)
  end

  def show(permalink)
    @article = Article.first(:permalink => Merb::Parse.unescape(permalink))
    raise NotFound unless @article
    etag_cache(@article)
    cache_or_display(@article)
  end

  private

    def cache_or_display(resource)
      if request_fresh?
        self.status = 304
        return ""
      else
        display resource
      end
    end

    def etag_cache(resource, key = "")
      self.etag = Digest::SHA1.hexdigest(key << resource.title)
      self.last_modified = resource.updated_at
    end

end # Articles
