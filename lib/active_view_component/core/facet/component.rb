# frozen_string_literal: true
module ActiveViewComponent
  module Core
    module Facet
      class Component < ViewComponent::Base
      end
    end
  end
end
      #def self.from(component: comp, &block)
      #  yield self.new(props: comp.props) if block_given?
      #end



      #def set_props(component: self, path: "/", klass: self.class.props_class)
      #  @props_hash ||= {}
      #  node_hash = path.split('/').inject(@props_hash) do |acc, part|
      #    acc[part] = {children: {}} if acc[part].nil?
      #    acc = acc[part]
      #  end
      #  props = klass.new
      #  node_hash[:parent] = props
      #  yield props if block_given?
      #end

      #body_props = Page::Body::Props.from(props: @component.props) do |p|
      #end
      #def set_props(&block)
      #  @props = self.class.props_class.new unless @props
      #  yield props
      #  self
      #end


