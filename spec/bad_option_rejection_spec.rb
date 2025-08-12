# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe "Bad Option Key Rejection" do
  describe "Meta Component" do
    context "when initialized with mixed valid and invalid options" do
      let(:mixed_options) do
        {
          # Valid options
          viewport: "width=320",
          apple_mobile_web_app_capable: "no",

          # Invalid options that should be rejected
          completely_invalid: "bad value",
          another_bad_key: { nested: "object" },
          numeric_key: 12_345,
          symbol_value: :symbol_not_string,

          # More valid options
          mobile_web_app_capable: "yes"
        }
      end

      let(:component) { ActiveViewComponent::Components::Page::Head::Meta::Component.new(**mixed_options) }

      it "only sets instance variables for valid attributes" do
        # Valid attributes should be set
        expect(component.viewport).to eq("width=320")
        expect(component.apple_mobile_web_app_capable).to eq("no")
        expect(component.mobile_web_app_capable).to eq("yes")

        # Invalid attributes should NOT create instance variables
        expect(component.instance_variable_defined?(:@completely_invalid)).to be_falsey
        expect(component.instance_variable_defined?(:@another_bad_key)).to be_falsey
        expect(component.instance_variable_defined?(:@numeric_key)).to be_falsey
        expect(component.instance_variable_defined?(:@symbol_value)).to be_falsey
      end

      it "does not define methods for invalid attributes" do
        expect(component).not_to respond_to(:completely_invalid)
        expect(component).not_to respond_to(:completely_invalid=)
        expect(component).not_to respond_to(:another_bad_key)
        expect(component).not_to respond_to(:numeric_key)
        expect(component).not_to respond_to(:symbol_value)
      end

      it "silently ignores invalid options without raising errors" do
        expect { component }.not_to raise_error
        expect { component.viewport }.not_to raise_error
        expect { component.apple_mobile_web_app_capable }.not_to raise_error
      end
    end
  end

  describe "Meta Generator" do
    context "when called with invalid options" do
      let(:generator_options) do
        {
          # Valid options
          viewport: "width=640",

          # Invalid options that should be ignored
          invalid_meta_option: "ignored",
          bad_generator_key: %w[array values],

          # More valid options
          description: "Test description"
        }
      end

      it "generator.generate ignores invalid keys in input" do
        result = ActiveViewComponent::Generator::Page::Html::Head::Meta.generate(generator_options)

        # Should include valid options that were provided
        expect(result[:viewport]).to eq("width=640")

        # Should NOT include invalid keys
        expect(result).not_to have_key(:invalid_meta_option)
        expect(result).not_to have_key(:bad_generator_key)
      end

      it "create_component handles invalid options gracefully" do
        component = ActiveViewComponent::Generator::Page::Html::Head::Meta.create_component(generator_options)

        # Valid options should work
        expect(component.viewport).to eq("width=640")
        expect(component.instance_variable_defined?(:@viewport)).to be_truthy

        # Invalid options should be ignored
        expect(component.instance_variable_defined?(:@invalid_meta_option)).to be_falsey
        expect(component.instance_variable_defined?(:@bad_generator_key)).to be_falsey
      end
    end
  end
end
