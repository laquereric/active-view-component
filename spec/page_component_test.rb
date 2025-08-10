require "test_helper"

class PageComponentTest < ActiveSupport::TestCase
  include ViewComponent::TestHelpers if defined?(ViewComponent)
  
  def setup
    @title = "Test Page"
    @body_class = "test-page"
  end
  
  test "renders with basic title and body class" do
    component = PageComponent.new(title: @title, body_class: @body_class)
    
    # Basic instantiation test
    assert_equal @title, component.send(:title)
    assert_equal @body_class, component.send(:body_class)
  end
  
  test "accepts meta options" do
    meta_options = {
      description: "Test description",
      keywords: "test, page"
    }
    
    component = PageComponent.new(title: @title, meta_options: meta_options)
    assert_equal meta_options, component.send(:meta_options)
  end
  
  test "accepts stylesheets and scripts" do
    stylesheets = ["/assets/test.css"]
    scripts = ["/assets/test.js"]
    
    component = PageComponent.new(
      title: @title,
      stylesheets: stylesheets,
      scripts: scripts
    )
    
    assert_equal stylesheets, component.send(:stylesheets)
    assert_equal scripts, component.send(:scripts)
  end
  
  test "accepts custom attributes" do
    html_attributes = { "data-theme" => "dark" }
    data_attributes = { "controller" => "page" }
    
    component = PageComponent.new(
      title: @title,
      html_attributes: html_attributes,
      data_attributes: data_attributes
    )
    
    assert_equal html_attributes, component.send(:html_attributes)
    assert_equal data_attributes, component.send(:data_attributes)
  end
  
  test "sets default language and direction" do
    component = PageComponent.new(title: @title)
    
    assert_equal "en", component.send(:lang)
    assert_equal "ltr", component.send(:dir)
  end
  
  test "accepts custom language and direction" do
    component = PageComponent.new(
      title: @title,
      lang: "es",
      dir: "rtl"
    )
    
    assert_equal "es", component.send(:lang)
    assert_equal "rtl", component.send(:dir)
  end
end
