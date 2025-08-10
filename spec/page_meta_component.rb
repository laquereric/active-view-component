# frozen_string_literal: true

# Meta Component for managing meta tags
class PageMetaComponent < SimpleComponent
  def initialize(
    charset: 'UTF-8',
    viewport: 'width=device-width, initial-scale=1',
    description: nil,
    keywords: nil,
    author: nil,
    robots: 'index, follow',
    og_title: nil,
    og_description: nil,
    og_image: nil,
    og_url: nil,
    twitter_card: 'summary',
    custom_meta: {}
  )
    super(
      charset: charset,
      viewport: viewport,
      description: description,
      keywords: keywords,
      author: author,
      robots: robots,
      og_title: og_title,
      og_description: og_description,
      og_image: og_image,
      og_url: og_url,
      twitter_card: twitter_card,
      custom_meta: custom_meta
    )
  end
end
