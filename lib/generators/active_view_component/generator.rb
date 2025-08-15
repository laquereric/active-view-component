# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  # Generator is a little different than the standard view_blockgenerator.
  # Its the entry point for root view_block (Component::Page::Generator) which in turn create child view_blocks
  class Generator
    attr_accessor :file

    def self.create_view_block
      new.create_view_block
    end

    def initialize
      @file = __FILE__
    end

    def create_view_block
      p "#{self} calling create_root_view_block"
      view_block = Component::Page::Generator.create_root_view_block
      binding.pry
      view_block
    end
  end
end
