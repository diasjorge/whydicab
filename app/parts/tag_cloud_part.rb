class TagCloudPart < Merb::PartController

  def index
    @tags = Tag.all
    render
  end

end
