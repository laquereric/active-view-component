require "test_helper"

class PageHtmlComponentTest < ActiveSupport::TestCase
  test "initializes with default values" do
    component = PageHtmlComponent.new
    
    assert_equal "en", component.lang
    assert_equal "ltr", component.dir
    assert_equal({}, component.html_attributes)
  end
  
  test "accepts custom language and direction" do
    component = PageHtmlComponent.new(lang: "es", dir: "rtl")
    
    assert_equal "es", component.lang
    assert_equal "rtl", component.dir
  end
  
  test "accepts html attributes" do
    html_attributes = {
      "data-theme" => "dark",
      "class" => "no-js"
    }
    
    component = PageHtmlComponent.new(html_attributes: html_attributes)
    assert_equal html_attributes, component.html_attributes
  end
end
