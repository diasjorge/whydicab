require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a tag exists" do
  Tag.all.destroy!
  Tag.create!(:name => "test")
end

describe "resource(@tag)", :given => "a tag exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Tag.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end

    it "says there are no articles for this tag" do
      @response.body.should include("There are no articles for this tag")
    end
  end
  
end

describe "resource(@tag)", :given => "an article exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(url(:tag, "tag1"))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains an article with the tag" do
      @response.body.should include("article_#{@article.id}")
    end
  end
  
end

