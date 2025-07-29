## [Unreleased]

## [0.1.0] - 2025-07-29

### Added
- Initial release of ActiveViewComponent gem
- Core ActiveViewComponent::Base model with ActiveRecord and ancestry integration
- Tree-based component storage using the ancestry gem
- Component data extraction and serialization
- Automatic component tree capture during rendering
- Rails engine integration with controller and view extensions
- Generator for creating database migration and initializer
- Configuration options for enabling/disabling features
- Renderer for traversing and re-rendering component trees
- TreeBuilder for capturing component hierarchies during render
- Example components demonstrating usage
- RSpec test suite
- Comprehensive documentation

### Features
- **Tree-based Component Storage**: Every rendered page captured as component tree
- **ActiveRecord Integration**: Components stored in database with full schema support
- **Ancestry Tree Structure**: Efficient tree operations using ancestry gem
- **ViewComponent Compatibility**: Works with existing ViewComponent libraries
- **Automatic Persistence**: Optional auto-capture of component trees
- **Tree Re-rendering**: Stored trees can be re-rendered from database data
