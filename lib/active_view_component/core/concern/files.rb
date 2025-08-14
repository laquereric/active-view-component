# frozen_string_literal: true

module ActiveViewComponent
  module Core
    module Concern
      # Concern that provides ERB template helpers for components
      # Allows components to define ERB attributes declaratively
      module Files
        extend ActiveSupport::Concern

        included do
          attr_accessor :parent, :children
        end

        def setup
        end

        class_methods do
          def peer_folders(file:)
            folder_name = file.split("/")[0..-2].join("/")
            glob_string = [folder_name, "/", "*"].join
            
            all = Dir.glob(glob_string)
            rbs = all.filter{ |fp| fp.match(/[.*]rb/) }
            erbs = all.filter{ |fp| fp.match(/[.*]erb/) }

            (all - rbs - erbs)
              .map{ |fp| fp.split('/').last}
              .map{|fn| fn.camelcase}
          end
        end
      end
    end
  end
end
