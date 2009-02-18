class ArchivePart < Merb::PartController
  def index
    @archives = Article.get_archive_hash
    render
  end
end
