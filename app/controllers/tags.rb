class Tags < Application
  # provides :xml, :yaml, :js

  def show(name)
    name = Merb::Parse.unescape(name) # Fix for problems with params
    @tag = Tag.first(:name => name)
    raise NotFound unless @tag
    @articles = Article.tagged_with(name, :published => true).paginate(:page => params[:page], :per_page => 10)
    display @articles
  end

end # Tags
