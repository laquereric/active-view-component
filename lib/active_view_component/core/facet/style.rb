# frozen_string_literal: true
module ActiveViewComponent
  module Core
    module Facet
      class Style
        attr_accessor :html_attributes, :dir, :stylesheets, :scripts, :lang, :charset, :viewport, :inline_styles
        attr_accessor :parent, :children
 
        def initialize(html_attributes: {}, dir: "ltr", stylesheets: [], scripts: [], lang: "en", charset: "utf-8", viewport: "width=device-width, initial-scale=1", **options)
          @html_attributes = html_attributes
          @dir = dir
          @stylesheets = stylesheets
          @inline_styles = ""
          @scripts = scripts
          @lang = lang
          @charset = charset
          @viewport = viewport
          @options = options
        end

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
