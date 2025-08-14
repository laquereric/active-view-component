# frozen_string_literal: true

# This file is part of the ActiveViewComponent library.
module ActiveViewComponent
  # Page generator
  class Generator
    def self.create_view_block
      p "#{self} create_component"
      ActiveViewComponent::Component::Page::Generator.create_view_block(parent_view_block_node: nil)
    end
  end
end
