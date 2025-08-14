# frozen_string_literal: true

module ActiveViewComponent
  module Component
    module Page
      # Component for rendering a page
      class Component < ActiveViewComponent::Core::Facet::Component
        attr_accessor :title, :body_class, :lang, :dir, :meta_options, :html_attributes, :data_attributes, :show_header
      end
    end
  end
end
