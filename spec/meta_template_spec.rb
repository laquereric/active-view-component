# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe "Meta Component Template Rendering" do
  let(:component) do
    ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(
      viewport: "width=1024, initial-scale=2",
      apple_mobile_web_app_capable: "no",
      mobile_web_app_capable: "no"
    )
  end

  describe "template rendering" do
    it "uses variables from component instance" do
      expect(component.viewport).to eq("width=1024, initial-scale=2")
      expect(component.apple_mobile_web_app_capable).to eq("no")
      expect(component.mobile_web_app_capable).to eq("no")
    end
  end

  describe "default values" do
    let(:default_component) do
      ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component
    end

    it "uses default values when no options provided" do
      expect(default_component.viewport).to eq("width=device-width, initial-scale=1")
      expect(default_component.apple_mobile_web_app_capable).to eq("yes")
      expect(default_component.mobile_web_app_capable).to eq("yes")
    end
  end
end
