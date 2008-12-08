class Application < Merb::Controller
  def get_archive
    @archives = Article.get_archive_hash
  end
end
