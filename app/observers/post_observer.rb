class PostObserver < ActiveRecord::Observer

  observe :post

  def after_create(post)
    register_permalink(post)
  end

  private
  def register_permalink(target)
    logger = Logger.new(Rails.root +'/logs/oberser.log')
    HTTParty.post('http://localhost:4567/shorten',
                  body: {
                      key: target.permalink,
                      link: Rails.application.routes.url_helpers.post_url(target, host: "localhost:3000")})

    logger.debug "In observer"
  end

end