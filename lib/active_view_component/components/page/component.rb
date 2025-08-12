# frozen_string_literal: true

module ActiveViewComponent
  module Components
    module Page
      class Component < ActiveViewComponent::Core::Facet::Component
        attr_accessor :title, :body_class, :lang, :dir, :meta_options, :html_attributes, :data_attributes, :show_header
      end
    end
  end
end
