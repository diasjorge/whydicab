require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a search exists" do
  Search.all.destroy!
  request(resource(:search), :method => "POST", 
    :params => { :search => { :id => nil }})
end

describe "resource(:search)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:search))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of search" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a search exists" do
    before(:each) do
      @response = request(resource(:search))
    end
    
    it "has a list of search" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Search.all.destroy!
      @response = request(resource(:search), :method => "POST", 
        :params => { :search => { :id => nil }})
    end
    
    it "redirects to resource(:search)" do
      @response.should redirect_to(resource(Search.first), :message => {:notice => "search was successfully created"})
    end
    
  end
end

describe "resource(@search)" do 
  describe "a successful DELETE", :given => "a search exists" do
     before(:each) do
       @response = request(resource(Search.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:search))
     end

   end
end

describe "resource(:search, :new)" do
  before(:each) do
    @response = request(resource(:search, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@search, :edit)", :given => "a search exists" do
  before(:each) do
    @response = request(resource(Search.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@search)", :given => "a search exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Search.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @search = Search.first
      @response = request(resource(@search), :method => "PUT", 
        :params => { :search => {:id => @search.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@search))
    end
  end
  
end

