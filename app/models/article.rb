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
  has n, :taggings, :class_name => "Tagging", :child_key => [:taggable_id],
         :taggable_type => self.to_s

  validates_present :body, :if => :published?
  validates_present :user

  before :save, :set_published

  before :destroy, :destroy_taggings

  def self.find_recent
    self.all(:published => true, :limit => 10, :order => [:published_at.desc])
  end

  def self.tagged_with(string, options = {})
    tag = Tag.first(:name => string)
    conditions = {}
    conditions['taggings.tag_id'] = tag.id
    conditions['taggings.tag_context'] = options.delete(:on) if options[:on]
    conditions.merge!(options)
    all(conditions)
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

  def destroy_taggings
    taggings.destroy!
  end

end
