module ApplicationHelper
  def path_active?(path)
    request.fullpath.match?(/#{path}/)
  end
end
