require File.join(File.dirname(__FILE__), '..', '..', 'spec_helper.rb')

describe "url(:admin_articles)" do

  before(:each) do
    login
  end

  describe "GET" do
    
    before(:each) do
      @response = request(url(:admin_articles))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "let you write an article" do
      @response.body.should include("Write an article man")
      @response.body.should include(url(:new_admin_article))
    end
    
  end
  
  describe "GET", :given => "an article exists" do
    before(:each) do
      @response = request(url(:admin_articles))
    end
    
    it "has an article" do
      @response.body.should include(@article.title)
    end

    it "has an edit link for an article" do
      @response.body.should include(url(:edit_admin_article, @article))
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Article.all.destroy!
      @response = request(url(:admin_articles), :method => "POST", 
        :params => { :article => { :title => "title" }})
    end
    
    it "redirects to resource(:articles)" do
      @response.should redirect_to(url(:admin_article, Article.first), :message => {:notice => "article was successfully created"})
    end
    
  end
end

describe "resource(@article)" do 
  describe "a successful DELETE", :given => "an article exists" do
     before(:each) do
      login
       @response = request(url(:admin_article, Article.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(url(:admin_articles))
     end

   end
end

describe "resource(:articles, :new)" do
  before(:each) do
    login
    @response = request(url(:new_admin_article))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "edit admin article", :given => "an article exists" do
  before(:each) do
    login
    @response = request(url(:edit_admin_article, Article.first))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "show admin article", :given => "an article exists" do

  before(:each) do
    login
  end

  describe "GET" do
    before(:each) do
      @response = request(url(:admin_article, Article.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @article = Article.first
      @response = request(url(:admin_article, @article), :method => "PUT", 
        :params => { :article => {:body => "NEW BODY"} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(url(:admin_article,@article))
    end
  end
  
end

