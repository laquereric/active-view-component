# frozen_string_literal: true

require "spec_helper"
require_relative "../lib/active-view-component"

RSpec.describe ActiveViewComponent::Core::ErbParts do
  # Create a test component class to test the concern
  let(:test_component_class) do
    Class.new do
      include ActiveViewComponent::Core::ErbParts

      erb_attr :title, type: :string, default: "Default Title"
      erb_attr :count, type: :integer
      erb_attr :visible, type: :boolean, default: true
      erb_attr :description
    end
  end

  let(:test_component) { test_component_class.new }

  describe "erb_attr class method" do
    it "defines getter and setter methods" do
      expect(test_component).to respond_to(:title)
      expect(test_component).to respond_to(:title=)
      expect(test_component).to respond_to(:title?)
    end

    it "applies type coercion for integer type" do
      test_component.count = "123"
      expect(test_component.count).to eq(123)
      expect(test_component.count).to be_a(Integer)
    end

    it "applies type coercion for boolean type" do
      test_component.visible = "false"
      expect(test_component.visible).to eq(true) # non-nil values are truthy

      test_component.visible = nil
      expect(test_component.visible).to be_falsey
    end

    it "applies type coercion for string type" do
      test_component.title = 12_345
      expect(test_component.title).to eq("12345")
      expect(test_component.title).to be_a(String)
    end

    it "provides question mark methods to check if attribute is set" do
      expect(test_component.title?).to be_falsey
      test_component.title = "Test Title"
      expect(test_component.title?).to be_truthy
    end

    it "stores erb attribute metadata" do
      attributes = test_component_class.erb_attributes
      expect(attributes).to have_key(:title)
      expect(attributes[:title][:type]).to eq(:string)
      expect(attributes[:title][:default]).to eq("Default Title")
    end
  end

  describe "class methods" do
    it "provides erb_attributes method to access metadata" do
      expect(test_component_class.erb_attributes).to be_a(Hash)
      expect(test_component_class.erb_attributes.keys).to include(:title, :count, :visible, :description)
    end
  end
end
