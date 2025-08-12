# frozen_string_literal: true

require "spec_helper"

# Create a test component that extends the Facet::Component
module TestNamespace
  class Component < ActiveViewComponent::Core::Facet::Component
    include ActiveViewComponent::Core::Concern::ViewBlock
  end

  class Props
  end

  class Style
  end
end

RSpec.describe "ViewBlock integration with Facet::Component" do
  let(:component) { TestNamespace::Component.new }

  describe "ViewBlock methods on Facet::Component" do
    it "can access sibling Component class" do
      expect(TestNamespace::Component.view_block_component_sibling_klass)
        .to eq(TestNamespace::Component)
    end

    it "can access sibling Props class" do
      expect(TestNamespace::Component.view_block_props_sibling_klass)
        .to eq(TestNamespace::Props)
    end

    it "can access sibling Style class" do
      expect(TestNamespace::Component.view_block_style_sibling_klass)
        .to eq(TestNamespace::Style)
    end
  end

  describe "ErbParts methods still work" do
    it "includes ErbParts concern" do
      expect(TestNamespace::Component.ancestors).to include(ActiveViewComponent::Core::Concern::ErbParts)
    end

    it "includes ViewBlock concern" do
      expect(TestNamespace::Component.ancestors).to include(ActiveViewComponent::Core::Concern::ViewBlock)
    end
  end
end
