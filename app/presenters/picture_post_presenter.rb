require_relative 'presenter'

class PicturePostPresenter < SimpleDelegator
  def render_body
    @template.render(partial: "/posts/picture_body", locals: {post: self})
  end
end

