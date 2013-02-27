require "digest/md5"

module GravatarHelpers

  def gravatar_for(email)
    hash = Digest::MD5.hexdigest(email)
    default = "https://s3.amazonaws.com/assets.heroku.com/addons.heroku.com/gravatar_default.png"
    url = "https://secure.gravatar.com/avatar/#{hash}?default=#{default}&size=256"
    image_tag(url, class: "gravatar")
  end

end