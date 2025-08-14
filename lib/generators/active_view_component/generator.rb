# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  # Page generator
  class Generator
    def self.create_sub_view_block_s
      p "#{self} calling create_root_view_block"
      Component::Page::Generator.create_root_view_block
    end
  end
end
