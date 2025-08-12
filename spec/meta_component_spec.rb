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
          mobile_web_app_capable: "yes",
          description: "Test Description",
          author: "Test Author"
        }
      end

      let(:component) { described_class.new(**options) }

      it "sets instance variables from options" do
        expect(component.viewport).to eq("width=device-width, initial-scale=1")
        expect(component.apple_mobile_web_app_capable).to eq("yes")
        expect(component.mobile_web_app_capable).to eq("yes")
        expect(component.description).to eq("Test Description")
        expect(component.author).to eq("Test Author")
      end
    end
  end

  describe "attr_accessors" do
    let(:component) { described_class.new }

    it "provides accessors for all meta attributes" do
      expect(component).to respond_to(:robots)
      expect(component).to respond_to(:robots=)
      expect(component).to respond_to(:keywords)
      expect(component).to respond_to(:keywords=)
      expect(component).to respond_to(:description)
      expect(component).to respond_to(:description=)
      expect(component).to respond_to(:author)
      expect(component).to respond_to(:author=)
      expect(component).to respond_to(:charset)
      expect(component).to respond_to(:charset=)
      expect(component).to respond_to(:viewport)
      expect(component).to respond_to(:viewport=)
      expect(component).to respond_to(:twitter_card)
      expect(component).to respond_to(:twitter_card=)
      expect(component).to respond_to(:custom_meta)
      expect(component).to respond_to(:custom_meta=)
      expect(component).to respond_to(:og_title)
      expect(component).to respond_to(:og_title=)
      expect(component).to respond_to(:og_description)
      expect(component).to respond_to(:og_description=)
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
        expect(component.description).to eq("Desc") # generator default
        expect(component.author).to eq("me") # generator default
      end
    end
  end
end
