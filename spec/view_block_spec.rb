# frozen_string_literal: true

require "spec_helper"

# Create a test component class structure to test the concern
module TestApp
  module Components
    module TestComponent
      class Component
        include ActiveViewComponent::Core::Concern::ViewBlock
      end

      class Props
      end

      class Style
      end
    end
  end
end

RSpec.describe ActiveViewComponent::Core::Concern::ViewBlock do
  describe ".view_block_component_sibling_klass" do
    it "returns the Component class from the same namespace" do
      expect(TestApp::Components::TestComponent::Component.view_block_component_sibling_klass)
        .to eq(TestApp::Components::TestComponent::Component)
    end
  end

  describe ".view_block_props_sibling_klass" do
    it "returns the Props class from the same namespace" do
      expect(TestApp::Components::TestComponent::Component.view_block_props_sibling_klass)
        .to eq(TestApp::Components::TestComponent::Props)
    end
  end

  describe ".view_block_style_sibling_klass" do
    it "returns the Style class from the same namespace" do
      expect(TestApp::Components::TestComponent::Component.view_block_style_sibling_klass)
        .to eq(TestApp::Components::TestComponent::Style)
    end
  end
end
