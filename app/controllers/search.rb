class Search < Application
  # provides :xml, :yaml, :js

  def index(q)
    @query = Merb::Parse.unescape(q)
    pagination = { :per_page => 10, :page => params[:page] }
    @results = [].paginate(pagination)
    @empty_query = (@query.nil? || @query.strip.empty?)
    @results = Article.paginate({ :conditions => ["body like '%#{@query}%' OR title like '%#{@query}%'"],
                                  :order => [:created_at.desc]}.merge(pagination)) unless @empty_query
    display @results
  end

end # Search
