require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Article do

  before(:each) do
    @article = Article.gen
  end
  
  it 'should be valid' do
    @article.should be_valid
  end

  it 'should have a unique title' do
    repeated = Article.gen(:title => @article.title)
    repeated.should_not be_valid
  end

  it 'should have an associated user' do
    @article.user = nil
    @article.should_not be_valid
  end

  describe "when published" do
    before(:each) do
      @article.published = true
    end
    
    it 'should have a body' do
      @article.body = nil
      @article.should_not be_valid
      @article.errors[:body].should_not be_empty
      @article.body = "Body of the article"
      @article.should be_valid
    end

    it 'should have a permalink' do
      @article.save
      @article.permalink.should_not be_blank
    end

    it 'should have a published date' do
      @article.save
      @article.published_at.should_not be_nil
    end

  end

end
