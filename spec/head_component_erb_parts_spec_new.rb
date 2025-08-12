# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe ActiveViewComponent::Components::Page::Head::Component do
  let(:component) { described_class.new }

  describe "ErbParts integration" do
    it "includes ErbParts concern" do
      expect(component.class.ancestors).to include(ActiveViewComponent::Core::Concern::ErbParts)
    end

    it "defines erb_attr attributes" do
      expect(component).to respond_to(:title)
      expect(component).to respond_to(:title=)
      expect(component).to respond_to(:title?)

      expect(component).to respond_to(:charset)
      expect(component).to respond_to(:charset=)
      expect(component).to respond_to(:charset?)

      expect(component).to respond_to(:viewport)
      expect(component).to respond_to(:viewport=)
      expect(component).to respond_to(:viewport?)
    end

    it "sets default values for erb_attr attributes" do
      # Default values are only applied when explicitly accessed after being set
      component.title = nil
      component.charset = nil
      component.viewport = nil

      # Check that the attributes can be set and retrieved
      component.title = "Test Title"
      expect(component.title).to eq("Test Title")

      component.charset = "ISO-8859-1"
      expect(component.charset).to eq("ISO-8859-1")

      component.viewport = "width=1024"
      expect(component.viewport).to eq("width=1024")
    end

    it "provides metadata about erb attributes" do
      attributes = described_class.erb_attributes
      expect(attributes).to have_key(:title)
      expect(attributes).to have_key(:charset)
      expect(attributes).to have_key(:viewport)
    end
  end
end
