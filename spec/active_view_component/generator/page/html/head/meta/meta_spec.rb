# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../../../../lib/active-view-component"

RSpec.describe ActiveViewComponent::Generator::Page::Html::Head::Meta do
  describe ".generate" do
    context "with default options" do
      let(:result) { described_class.generate }

      it "returns a hash with default values" do
        expect(result).to be_a(Hash)
        expect(result[:description]).to eq("Desc")
        expect(result[:author]).to eq("me")
        expect(result[:charset]).to eq("UTF-8")
        expect(result[:viewport]).to eq("width=device-width, initial-scale=1")
        expect(result[:robots]).to eq("index, follow")
        expect(result[:twitter_card]).to eq("summary")
        expect(result[:apple_mobile_web_app_capable]).to eq("yes")
        expect(result[:mobile_web_app_capable]).to eq("yes")
      end

      it "sets optional values to nil when not provided" do
        expect(result[:keywords]).to be_nil
        expect(result[:og_title]).to be_nil
        expect(result[:og_description]).to be_nil
      end

      it "sets custom_meta to empty hash by default" do
        expect(result[:custom_meta]).to eq({})
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          description: "Custom description",
          author: "Custom Author",
          charset: "ISO-8859-1",
          viewport: "width=1024",
          robots: "noindex, nofollow",
          twitter_card: "summary_large_image",
          keywords: "ruby, rails, component",
          og_title: "Custom OG Title",
          og_description: "Custom OG Description",
          apple_mobile_web_app_capable: "no",
          mobile_web_app_capable: "no",
          custom_meta: { "theme-color" => "#ffffff" }
        }
      end

      let(:result) { described_class.generate(custom_options) }

      it "uses provided values over defaults" do
        expect(result[:description]).to eq("Custom description")
        expect(result[:author]).to eq("Custom Author")
        expect(result[:charset]).to eq("ISO-8859-1")
        expect(result[:viewport]).to eq("width=1024")
        expect(result[:robots]).to eq("noindex, nofollow")
        expect(result[:twitter_card]).to eq("summary_large_image")
        expect(result[:apple_mobile_web_app_capable]).to eq("no")
        expect(result[:mobile_web_app_capable]).to eq("no")
      end

      it "sets optional values when provided" do
        expect(result[:keywords]).to eq("ruby, rails, component")
        expect(result[:og_title]).to eq("Custom OG Title")
        expect(result[:og_description]).to eq("Custom OG Description")
      end

      it "sets custom_meta when provided" do
        expect(result[:custom_meta]).to eq({ "theme-color" => "#ffffff" })
      end
    end
  end

  describe ".create_component" do
    context "with default options" do
      let(:component) { described_class.create_component }

      it "returns a Meta component instance" do
        expect(component).to be_an_instance_of(ActiveViewComponent::Components::Page::Head::Meta::Component)
      end

      it "initializes component with default values" do
        expect(component.description).to eq("Desc")
        expect(component.author).to eq("me")
        expect(component.charset).to eq("UTF-8")
        expect(component.viewport).to eq("width=device-width, initial-scale=1")
        expect(component.robots).to eq("index, follow")
        expect(component.twitter_card).to eq("summary")
        expect(component.apple_mobile_web_app_capable).to eq("yes")
        expect(component.mobile_web_app_capable).to eq("yes")
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          description: "Test Description",
          viewport: "width=320",
          apple_mobile_web_app_capable: "no",
          mobile_web_app_capable: "no"
        }
      end

      let(:component) { described_class.create_component(custom_options) }

      it "initializes component with custom values" do
        expect(component.description).to eq("Test Description")
        expect(component.viewport).to eq("width=320")
        expect(component.apple_mobile_web_app_capable).to eq("no")
        expect(component.mobile_web_app_capable).to eq("no")
      end

      it "uses defaults for unspecified values" do
        expect(component.author).to eq("me")
        expect(component.charset).to eq("UTF-8")
        expect(component.robots).to eq("index, follow")
        expect(component.twitter_card).to eq("summary")
      end
    end
  end
end
