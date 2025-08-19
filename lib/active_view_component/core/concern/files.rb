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

        def peer_folders
          folder_name = generator_file.split("/")[0..-2].join("/")
          glob_string = [folder_name, "/", "*"].join
          
          all = Dir.glob(glob_string)
          rbs = all.filter{ |fp| fp.match(/[.*]rb/) }
          erbs = all.filter{ |fp| fp.match(/[.*]erb/) }

          (all - rbs - erbs)
            .map{ |fp| fp.split('/').last}
            .map{|fn| fn.camelcase}
        end

        class_methods do
        end
      end
    end
  end
end
