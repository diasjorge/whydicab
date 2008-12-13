class Search < Application
  # provides :xml, :yaml, :js

  def index
    @query = Merb::Parse.unescape(params[:q]||"")
    if @query.nil? || @query.strip.empty?
      @results = []
    else
      @results = Article.paginate(:conditions => ["(body like ? OR title like ?)",
                                                  "%#{@query}%","%#{@query}%"],
                                  :published => true,
                                  :order => [:created_at.desc],
                                  :per_page => 10,
                                  :page => params[:page])
    end
    display @results
  end

end # Search
