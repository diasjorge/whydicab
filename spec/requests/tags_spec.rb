# require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

# given "a tag exists" do
#   Tag.all.destroy!
#   request(resource(:tags), :method => "POST", 
#     :params => { :tag => { :id => Tag.gen }})
# end

# describe "resource(:tags)" do
#   describe "GET" do
    
#     before(:each) do
#       @response = request(resource(:tags))
#     end
    
#     it "responds successfully" do
#       @response.should be_successful
#     end

#     it "contains a list of tags" do
#       pending
#       @response.should have_xpath("//ul")
#     end
    
#   end
  
#   describe "GET", :given => "a tag exists" do
#     before(:each) do
#       @response = request(resource(:tags))
#     end
    
#     it "has a list of tags" do
#       pending
#       @response.should have_xpath("//ul/li")
#     end
#   end
  
#   describe "a successful POST" do
#     before(:each) do
#       Tag.all.destroy!
#       @response = request(resource(:tags), :method => "POST", 
#         :params => { :tag => { :id => nil }})
#     end
    
#     it "redirects to resource(:tags)" do
#       @response.should redirect_to(resource(Tag.first), :message => {:notice => "tag was successfully created"})
#     end
    
#   end
# end

# describe "resource(@tag)" do 
#   describe "a successful DELETE", :given => "a tag exists" do
#      before(:each) do
#        @response = request(resource(Tag.first), :method => "DELETE")
#      end

#      it "should redirect to the index action" do
#        @response.should redirect_to(resource(:tags))
#      end

#    end
# end

# describe "resource(:tags, :new)" do
#   before(:each) do
#     @response = request(resource(:tags, :new))
#   end
  
#   it "responds successfully" do
#     @response.should be_successful
#   end
# end

# describe "resource(@tag, :edit)", :given => "a tag exists" do
#   before(:each) do
#     @response = request(resource(Tag.first, :edit))
#   end
  
#   it "responds successfully" do
#     @response.should be_successful
#   end
# end

# describe "resource(@tag)", :given => "a tag exists" do
  
#   describe "GET" do
#     before(:each) do
#       @response = request(resource(Tag.first))
#     end
  
#     it "responds successfully" do
#       @response.should be_successful
#     end
#   end
  
#   describe "PUT" do
#     before(:each) do
#       @tag = Tag.first
#       @response = request(resource(@tag), :method => "PUT", 
#         :params => { :tag => {:id => @tag.id} })
#     end
  
#     it "redirect to the article show action" do
#       @response.should redirect_to(resource(@tag))
#     end
#   end
  
# end

