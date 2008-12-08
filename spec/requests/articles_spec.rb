require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "resource(:articles)" do

  describe "GET" do
    before(:each) do
      Article.all.destroy!
      @response = request(resource(:articles))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "says there are no articles" do
      @response.body.should include("There are no articles")
    end
    
  end
  
  describe "GET", :given => "an article exists" do
    before(:each) do
      @response = request(resource(:articles))
    end
    
    it "contains an article" do
      @response.body.should include("article_#{@article.id}")
    end
  end
  
end

describe "resource(@article)", :given => "an article exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Article.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
end

