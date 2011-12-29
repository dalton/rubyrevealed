require_relative 'presenter'
class TextPostPresenter < SimpleDelegator
  def render_body
    @template.render(partial: "/posts/text_body", locals: {post: self})
  end
end