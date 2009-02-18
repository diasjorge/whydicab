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
    display @articles
  end

  def show(permalink)
    @article = Article.first(:permalink => Merb::Parse.unescape(permalink))
    raise NotFound unless @article
    display @article
  end

end # Articles
