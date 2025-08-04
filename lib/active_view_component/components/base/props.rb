# frozen_string_literal: true
module ActiveViewComponent
class Base::Props
  attr_accessor :style, :current_user, :description, :keywords, :author, :lang, :dir, :stylesheets, :scripts, :robots, :title, :og_title, :og_description, :og_image, :og_url, :twitter_card, :custom_meta

  def initialize(style:, current_user:, description:, keywords:, author:, robots:, og_title:, og_description:, og_image:, og_url:, twitter_card:, custom_meta: {})
    @style = style,
    @current_user = current_user
    @description = description
    @keywords = keywords
    @author = author
    @robots = robots
    @title = title
    @og_title = og_title
    @og_description = og_description
    @og_image = og_image
    @og_url = og_url
    @twitter_card = twitter_card
    @custom_meta = custom_meta
  end
end
end