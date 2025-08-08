# frozen_string_literal: true
module ActiveViewComponent
  module Core
    module Facet
      class Props < Hash
        attr_accessor :parent, :children
        #attr_accessor :style, :current_user, :description, :keywords, :author, :lang, :dir, :stylesheets, :scripts, :robots, :title, :og_title, :og_description, :og_image, :og_url, :twitter_card, :custom_meta
        #def self.from(props:, &block)
        #  yield self.new if block_given?
        #end
        def prepare(parent:nil)
          @parent = parent if parent
          prepare_children(parent:self)
        end

        def prepare_children(parent:nil)
          @children ||= []
          
          # Prepare the children if they respond to prepare
          @children.each { |child| child.prepare(parent: self) }
        end
      end
    end
  end
end
