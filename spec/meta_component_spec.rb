# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe ActiveViewComponent::Components::Page::Head::Meta::Component do
  describe "#initialize" do
    context "with default options" do
      let(:component) { described_class.new }

      it "creates a component instance" do
        expect(component).to be_an_instance_of(described_class)
      end

      it "allows setting attributes" do
        component.viewport = "width=1024"
        component.apple_mobile_web_app_capable = "no"
        component.mobile_web_app_capable = "no"

        expect(component.viewport).to eq("width=1024")
        expect(component.apple_mobile_web_app_capable).to eq("no")
        expect(component.mobile_web_app_capable).to eq("no")
      end
    end

    context "with options hash" do
      let(:options) do
        {
          viewport: "width=device-width, initial-scale=1",
          apple_mobile_web_app_capable: "yes",
          mobile_web_app_capable: "yes"
        }
      end

      let(:component) { described_class.new(**options) }

      it "sets instance variables from options" do
        expect(component.viewport).to eq("width=device-width, initial-scale=1")
        expect(component.apple_mobile_web_app_capable).to eq("yes")
        expect(component.mobile_web_app_capable).to eq("yes")
      end
    end

    context "with invalid options" do
      let(:options) do
        {
          viewport: "width=1024",
          invalid_option: "bad value",
          another_bad_key: "should be ignored",
          apple_mobile_web_app_capable: "yes"
        }
      end

      let(:component) { described_class.new(**options) }

      it "only sets valid attributes and ignores invalid ones" do
        expect(component.viewport).to eq("width=1024")
        expect(component.apple_mobile_web_app_capable).to eq("yes")

        # Invalid options should not be set as instance variables
        expect(component.instance_variable_defined?(:@invalid_option)).to be_falsey
        expect(component.instance_variable_defined?(:@another_bad_key)).to be_falsey

        # Component should not respond to invalid attributes
        expect(component).not_to respond_to(:invalid_option)
        expect(component).not_to respond_to(:another_bad_key)
      end

      it "does not raise an error when invalid options are provided" do
        expect { described_class.new(**options) }.not_to raise_error
      end
    end
  end

  describe "attr_accessors" do
    let(:component) { described_class.new }

    it "provides accessors for all meta attributes" do
      expect(component).to respond_to(:viewport)
      expect(component).to respond_to(:viewport=)
      expect(component).to respond_to(:apple_mobile_web_app_capable)
      expect(component).to respond_to(:apple_mobile_web_app_capable=)
      expect(component).to respond_to(:mobile_web_app_capable)
      expect(component).to respond_to(:mobile_web_app_capable=)
    end
  end

  describe "integration with generator" do
    context "when created via generator" do
      let(:generator_options) do
        {
          viewport: "width=768",
          apple_mobile_web_app_capable: "no",
          mobile_web_app_capable: "no"
        }
      end

      let(:component) do
        ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(generator_options)
      end

      it "creates component with generator defaults and overrides" do
        expect(component.viewport).to eq("width=768")
        expect(component.apple_mobile_web_app_capable).to eq("no")
        expect(component.mobile_web_app_capable).to eq("no")
      end
    end
  end
end
