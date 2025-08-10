# frozen_string_literal: true

require 'component_helper'

RSpec.describe ActiveViewComponent::Components::Page::Body::Component, type: :component do
  describe "basic rendering" do
    it "renders body element" do
      render_inline(ActiveViewComponent::Components::Page::Body::Component.new) do
        "Body content"
      end
      
      expect(page).to have_selector("body")
      expect(page).to have_content("Body content")
    end
  end
  
  describe "with body class" do
    let(:body_class) { "home-page dark-theme" }
    
    it "applies CSS classes" do
      render_inline(ActiveViewComponent::Components::Page::Body::Component.new(body_class: body_class))
      
      expect(page).to have_selector("body.home-page.dark-theme")
    end
  end
  
  describe "with data attributes" do
    let(:data_attributes) do
      {
        "controller" => "page",
        "action" => "index",
        "turbo-permanent" => ""
      }
    end
    
    it "applies data attributes" do
      render_inline(ActiveViewComponent::Components::Page::Body::Component.new(data_attributes: data_attributes))
      
      expect(page).to have_selector('body[data-controller="page"]')
      expect(page).to have_selector('body[data-action="index"]')
      expect(page).to have_selector('body[data-turbo-permanent=""]')
    end
  end
  
  describe "with both class and data attributes" do
    let(:body_class) { "test-page" }
    let(:data_attributes) { { "controller" => "test" } }
    
    it "applies both class and data attributes" do
      render_inline(ActiveViewComponent::Components::Page::Body::Component.new(
        body_class: body_class,
        data_attributes: data_attributes
      )) do
        "Content"
      end
      
      expect(page).to have_selector('body.test-page[data-controller="test"]')
      expect(page).to have_content("Content")
    end
  end
end
