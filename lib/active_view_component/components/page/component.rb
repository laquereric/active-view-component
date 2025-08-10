# frozen_string_literal: true
module ActiveViewComponent
  module Components
    module Page
      class Component < ActiveViewComponent::Core::Facet::Component
        attr_accessor :title, :body_class, :lang, :dir, :meta_options, :html_attributes, :data_attributes, :show_header
        
        def initialize(
          title: nil,
          body_class: nil,
          lang: "en",
          dir: "ltr",
          meta_options: {},
          html_attributes: {},
          data_attributes: {},
          show_header: true,
          **_options
        )
          super()
          @title = title
          @body_class = body_class
          @lang = lang
          @dir = dir
          @meta_options = meta_options || {}
          @html_attributes = html_attributes || {}
          @data_attributes = data_attributes || {}
          @show_header = show_header
        end
      end
    end
  end
end