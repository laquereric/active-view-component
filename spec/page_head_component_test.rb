require "test_helper"

class PageHeadComponentTest < ActiveSupport::TestCase
  def setup
    @title = "Test Title"
  end
  
  test "initializes with title" do
    component = PageHeadComponent.new(title: @title)
    
    assert_equal @title, component.title
  end
  
  test "accepts meta options" do
    meta_options = { description: "Test description" }
    component = PageHeadComponent.new(title: @title, meta_options: meta_options)
    
    assert_equal meta_options, component.meta_options
  end
  
  test "accepts stylesheets and scripts" do
    stylesheets = ["/assets/app.css"]
    scripts = ["/assets/app.js"]
    
    component = PageHeadComponent.new(
      title: @title,
      stylesheets: stylesheets,
      scripts: scripts
    )
    
    assert_equal stylesheets, component.stylesheets
    assert_equal scripts, component.scripts
  end
  
  test "accepts inline styles and scripts" do
    inline_styles = "body { background: red; }"
    inline_scripts = "console.log('test');"
    
    component = PageHeadComponent.new(
      title: @title,
      inline_styles: inline_styles,
      inline_scripts: inline_scripts
    )
    
    assert_equal inline_styles, component.inline_styles
    assert_equal inline_scripts, component.inline_scripts
  end
end
