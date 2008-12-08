require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "resource(:search)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:search))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "says there are no articles for this search" do
      @response.body.should include("There are no articles for this search")
    end
    
  end
  
  describe "GET", :given => "an article exists" do
    before(:each) do
      @response = request(resource(:search, { :q => "body of"}))
    end
    
    it "has a list of search" do
      @response.body.should include("article_#{@article.id}")
    end
  end
end

