# frozen_string_literal: true

require "spec_helper"

RSpec.describe "ViewBlock with existing Meta component" do
  # Add ViewBlock to the existing Meta component for testing
  before do
    ActiveViewComponent::Components::Page::Head::Meta::Component.include(ActiveViewComponent::Core::ViewBlock)
  end

  describe "ViewBlock methods on existing Meta::Component" do
    it "can access sibling Component class" do
      expect(ActiveViewComponent::Components::Page::Head::Meta::Component.view_block_component_sibling_klass)
        .to eq(ActiveViewComponent::Components::Page::Head::Meta::Component)
    end

    it "can access sibling Props class" do
      expect(ActiveViewComponent::Components::Page::Head::Meta::Component.view_block_props_sibling_klass.name)
        .to eq("ActiveViewComponent::Components::Page::Head::Meta::Props")
    end

    # NOTE: Style class may not exist for Meta component, so we test the method works but may raise NameError
    it "attempts to access sibling Style class" do
      expect do
        ActiveViewComponent::Components::Page::Head::Meta::Component.view_block_style_sibling_klass
      end.to raise_error(NameError, /uninitialized constant.*Style/)
    end
  end
end
