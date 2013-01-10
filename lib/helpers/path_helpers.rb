module PathHelpers

  def root_path?
    request.path == 'index.html'
  end
  
end