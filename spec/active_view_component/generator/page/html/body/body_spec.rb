# frozen_string_literal: true

require "spec_helper"
require_relative "../../../../../../lib/active-view-component"

RSpec.describe ActiveViewComponent::Generator::Page::Html::Body do
  describe ".generate" do
    context "with default options" do
      it "returns default configuration hash" do
        result = described_class.generate

        expect(result).to be_a(Hash)
        expect(result[:body_class]).to be_nil
        expect(result[:data_attributes]).to eq({})
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          body_class: "custom-body-class",
          data_attributes: { "controller" => "page", "action" => "show" }
        }
      end

      it "returns configuration hash with custom values" do
        result = described_class.generate(custom_options)

        expect(result[:body_class]).to eq("custom-body-class")
        expect(result[:data_attributes]).to eq({ "controller" => "page", "action" => "show" })
      end

      it "preserves defaults for unspecified options" do
        partial_options = { body_class: "partial-class" }
        result = described_class.generate(partial_options)

        expect(result[:body_class]).to eq("partial-class")
        expect(result[:data_attributes]).to eq({}) # default value
      end
    end
  end

  describe ".create_component" do
    context "with default options" do
      it "creates a Body component with default configuration" do
        component = described_class.create_component

        expect(component).to be_a(ActiveViewComponent::Components::Page::Body::Component)
        expect(component.instance_variable_get(:@body_class)).to be_nil
        expect(component.instance_variable_get(:@data_attributes)).to eq({})
      end
    end

    context "with custom options" do
      let(:custom_options) do
        {
          body_class: "test-body-class",
          data_attributes: { "theme" => "dark" }
        }
      end

      it "creates a Body component with custom configuration" do
        component = described_class.create_component(custom_options)

        expect(component).to be_a(ActiveViewComponent::Components::Page::Body::Component)
        expect(component.instance_variable_get(:@body_class)).to eq("test-body-class")
        expect(component.instance_variable_get(:@data_attributes)).to eq({ "theme" => "dark" })
      end
    end
  end

  describe "integration with component initialization" do
    it "properly initializes component through generator" do
      options = {
        body_class: "integration-body",
        data_attributes: { "controller" => "integration", "turbo" => "true" }
      }

      component = described_class.create_component(options)

      # Verify all attributes are accessible
      expect(component.body_class).to eq("integration-body")
      expect(component.data_attributes).to eq({ "controller" => "integration", "turbo" => "true" })
    end
  end
end
