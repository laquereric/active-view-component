# frozen_string_literal: true
module ActiveViewComponent
module Base
  class Base::Component < ViewComponent::Base

    def self.props_class
      Props
    end

    def self.from(component, &block)
      yield self.new(props: component.props) if block_given?
    end

    def initialize(props:)
      @props = props
      @component = self
    end

    def set_props(&block)
      yield props
    end

  end
end
end
