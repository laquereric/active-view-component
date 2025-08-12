# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe "Meta Component Integration" do
  describe "template variables" do
    it "generates different output based on component variables" do
      # Create component with custom values
      custom_component = ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(
        viewport: "width=1920, initial-scale=0.5",
        apple_mobile_web_app_capable: "no",
        mobile_web_app_capable: "no"
      )

      # Verify custom values are set
      expect(custom_component.viewport).to eq("width=1920, initial-scale=0.5")
      expect(custom_component.apple_mobile_web_app_capable).to eq("no")
      expect(custom_component.mobile_web_app_capable).to eq("no")

      # Create component with defaults
      default_component = ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component

      # Verify defaults are different from custom values
      expect(default_component.viewport).to eq("width=device-width, initial-scale=1")
      expect(default_component.apple_mobile_web_app_capable).to eq("yes")
      expect(default_component.mobile_web_app_capable).to eq("yes")

      # The templates would generate different HTML based on these variables
      expect(custom_component.viewport).not_to eq(default_component.viewport)
      expect(custom_component.apple_mobile_web_app_capable).not_to eq(default_component.apple_mobile_web_app_capable)
      expect(custom_component.mobile_web_app_capable).not_to eq(default_component.mobile_web_app_capable)
    end
  end

  describe "all meta attributes" do
    let(:full_options) do
      {
        description: "A comprehensive test description",
        author: "Test Author",
        charset: "ISO-8859-1",
        viewport: "width=800",
        robots: "noindex, nofollow",
        twitter_card: "summary_large_image",
        keywords: "test, rspec, component",
        og_title: "Test OG Title",
        og_description: "Test OG Description",
        apple_mobile_web_app_capable: "no",
        mobile_web_app_capable: "no",
        custom_meta: { "theme-color" => "#123456" }
      }
    end

    let(:component) do
      ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(full_options)
    end

    it "supports all meta attributes through the generator" do
      expect(component.description).to eq("A comprehensive test description")
      expect(component.author).to eq("Test Author")
      expect(component.charset).to eq("ISO-8859-1")
      expect(component.viewport).to eq("width=800")
      expect(component.robots).to eq("noindex, nofollow")
      expect(component.twitter_card).to eq("summary_large_image")
      expect(component.keywords).to eq("test, rspec, component")
      expect(component.og_title).to eq("Test OG Title")
      expect(component.og_description).to eq("Test OG Description")
      expect(component.apple_mobile_web_app_capable).to eq("no")
      expect(component.mobile_web_app_capable).to eq("no")
      expect(component.custom_meta).to eq({ "theme-color" => "#123456" })
    end
  end
end
