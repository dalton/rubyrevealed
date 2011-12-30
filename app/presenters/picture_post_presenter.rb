require_relative 'presenter'

class PicturePostPresenter < Presenter
  def render_body
    @template.render(partial: "/posts/picture_body", locals: {post: self})
  end
end

