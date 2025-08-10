# frozen_string_literal: true

require 'component_helper'

RSpec.describe ActiveViewComponent::Components::Page::Component, type: :component do
  describe "basic rendering" do
    it "renders page component" do
      render_inline(ActiveViewComponent::Components::Page::Component.new) do
        "Page content"
      end
      
      expect(page).to have_content("Page content")
    end
  end
  
  describe "with nested components" do
    it "can render with nested content" do
      render_inline(ActiveViewComponent::Components::Page::Component.new) do
        "Nested page content"
      end
      
      expect(page).to have_content("Nested page content")
    end
  end
end
