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
        viewport: "width=800",
        apple_mobile_web_app_capable: "no",
        mobile_web_app_capable: "no"
      }
    end

    let(:component) do
      ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(full_options)
    end

    it "supports all meta attributes through the generator" do
      expect(component.viewport).to eq("width=800")
      expect(component.apple_mobile_web_app_capable).to eq("no")
      expect(component.mobile_web_app_capable).to eq("no")
    end
  end

  describe "generator with invalid options" do
    let(:mixed_options) do
      {
        viewport: "width=1024",
        apple_mobile_web_app_capable: "yes",
        invalid_generator_option: "should be ignored",
        bad_key: "not valid",
        mobile_web_app_capable: "no"
      }
    end

    let(:component) do
      ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(mixed_options)
    end

    it "generates component ignoring invalid options" do
      # Valid options should be set
      expect(component.viewport).to eq("width=1024")
      expect(component.apple_mobile_web_app_capable).to eq("yes")
      expect(component.mobile_web_app_capable).to eq("no")

      # Invalid options should not be set as instance variables
      expect(component.instance_variable_defined?(:@invalid_generator_option)).to be_falsey
      expect(component.instance_variable_defined?(:@bad_key)).to be_falsey

      # Component should not respond to invalid attributes
      expect(component).not_to respond_to(:invalid_generator_option)
      expect(component).not_to respond_to(:bad_key)
    end

    it "does not raise error when generator receives invalid options" do
      expect do
        ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(mixed_options)
      end.not_to raise_error
      expect { ActiveViewComponent::Generator::Page::Html::Head::Meta.generate(mixed_options) }.not_to raise_error
    end

    it "generator.generate filters out invalid keys" do
      result = ActiveViewComponent::Generator::Page::Html::Head::Meta.generate(mixed_options)

      # Should contain all valid meta keys (defined in generator)
      valid_keys = %i[
        viewport apple_mobile_web_app_capable mobile_web_app_capable
      ]
      expect(result.keys).to contain_exactly(*valid_keys)

      # Should not contain invalid keys
      expect(result).not_to have_key(:invalid_generator_option)
      expect(result).not_to have_key(:bad_key)

      # Check that our provided values are still there
      expect(result[:viewport]).to eq("width=1024")
      expect(result[:apple_mobile_web_app_capable]).to eq("yes")
      expect(result[:mobile_web_app_capable]).to eq("no")
    end
  end
end
