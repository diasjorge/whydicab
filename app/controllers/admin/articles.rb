module Admin
  class Articles < Application

    before :ensure_authenticated
    # provides :xml, :yaml, :js
  
    def index
      @articles = Article.all(:order => [:published_at.desc])
      display @articles
    end
  
    def show(id)
      @article = Article.get(id)
      raise NotFound unless @article
      display @article
    end
  
    def new
      only_provides :html
      @article = Article.new
      display @article
    end
  
    def edit(id)
      only_provides :html
      @article = Article.get(id)
      raise NotFound unless @article
      display @article
    end
    
    def create(article)
      @article = Article.new(article)
      @article.user = User.first
      if @article.save
        redirect url(:admin_article, @article), :message => {:notice => "Article was successfully created"} 
      else
        message[:error] = "Article failed to be created"
        render :new
      end
    end
      
    def update(id, article)
      @article = Article.get(id)
      raise NotFound unless @article
      if @article.update_attributes(article)
        redirect url(:admin_article, @article), :message => {:notice => "Article was successfully edited"} 
      else
        display @article, :edit
      end
    end
  
    def destroy(id)
      @article = Article.get(id)
      raise NotFound unless @article
      if @article.destroy
        redirect resource(:articles)
      else
        raise InternalServerError
      end
    end
  
  end # Articles
end # Admin
