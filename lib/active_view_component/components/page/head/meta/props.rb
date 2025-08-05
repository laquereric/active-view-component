module ActiveViewComponent
  module Components
    module Page
      module Head 
        module Meta
          class Props < ActiveViewComponent::Core::Facet::Props
            attr_accessor :meta_options, :current_user, :description, :keywords, :author, :lang, :dir
=begin
            def initialize(
              base_props:,
              meta_options:,
              current_user:,
              description:,
              keywords:,
              author:,
              lang:, 
              dir:,
              stylesheets:,
              scripts:
              )
              @base_props = base_props
              @meta_options = meta_options
              @current_user = current_user
              @description = description
              @keywords = keywords
              @author = author
              @lang = lang
              @dir = dir
              @stylesheets = stylesheets
              @scripts = scripts
            end
=end
          end
        end
      end
    end
  end
end