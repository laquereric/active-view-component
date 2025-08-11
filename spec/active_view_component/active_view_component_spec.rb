# frozen_string_literal: true

require "spec_helper"
require_relative "../../lib/active-view-component"

RSpec.describe ActiveViewComponent do
  it "has a version number" do
    expect(ActiveViewComponent::VERSION).not_to be nil
  end

  it "has configuration options" do
    expect(ActiveViewComponent.enabled).to eq(true)
    expect(ActiveViewComponent.auto_persist).to eq(true)
  end

  it "can be configured" do
    ActiveViewComponent.configure do |config|
      config.enabled = false
    end

    expect(ActiveViewComponent.enabled).to eq(false)

    # Reset for other tests
    ActiveViewComponent.enabled = true
  end
end
