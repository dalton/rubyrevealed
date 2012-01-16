require 'delegate'
class Presenter < SimpleDelegator
  def initialize(model, template)
    @template = template
    super(model)
  end

  def render_heading
    @template.render(partial: "/posts/heading", locals: {post: self})
  end

  def to_model
    __getobj__
  end

  def class
    __getobj__.class
  end
end