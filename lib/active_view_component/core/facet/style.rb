# frozen_string_literal: true
module ActiveViewComponent
  module Core
    module Facet
      class Style
        attr_accessor :html_attributes, :dir, :stylesheets, :scripts, :lang, :charset, :viewport, :inline_styles
        
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
      end
    end
  end
end
