class Article
  include DataMapper::Resource
  include Archive
  
  property :id, Serial
  property :title, String, :length => 255, :nullable => false, :unique => true
  property :body, Text
  property :published, Boolean
  property :created_at, DateTime
  property :updated_at, DateTime
  property :published_at, DateTime
  property :permalink, String, :length => 255

  belongs_to :user
  has_tags

  validates_present :body, :if => :published?
  validates_present :user

  before :save, :set_published

  def self.find_recent
    self.all(:published => true, :limit => 10, :order => [:published_at.desc])
  end

  def to_html
    RedCloth.new(self.body || "").to_html
  end

  private 
  def set_published
    if published?
      self.published_at ||= Time.now
      self.permalink ||= create_permalink
    end
  end

  def create_permalink
    date = self.published_at.strftime("%Y-%m-%d")
    date + "-" + self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-')
  end  

end
