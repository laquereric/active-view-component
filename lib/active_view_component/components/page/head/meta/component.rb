# frozen_string_literal: true
module ActiveViewComponent
  module Components
    module Page
      module Head
        module Meta
          class Component < ActiveViewComponent::Core::Facet::Component
            attr_accessor :robots, :keywords, :description, :author, :charset, :viewport, :twitter_card, :custom_meta
            
            def initialize(
              description: "Desc",
              author: "me", 
              charset: "UTF-8",
              viewport: "width=device-width, initial-scale=1",
              robots: "index, follow",
              twitter_card: "summary",
              custom_meta: {},
              keywords: nil,
              og_title: nil,
              og_description: nil,
              **_options
            )
              super()
              @description = description
              @author = author
              @charset = charset
              @viewport = viewport
              @robots = robots
              @twitter_card = twitter_card
              @keywords = keywords
              @og_title = og_title
              @og_description = og_description
              @custom_meta = custom_meta || {}
            end
          end
        end
      end
    end
  end
end
