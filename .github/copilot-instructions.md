<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# ActiveViewComponent Gem

This is a Ruby gem that implements a new Rails rendering flow where every rendered page is persisted to the database as a tree of ActiveViewComponents using the ancestry gem.

## Key Concepts

- **ActiveViewComponent::Base**: The main model that inherits from ActiveRecord and uses the ancestry gem for tree structure
- **Tree Persistence**: Every component render is captured and stored with its data and class name
- **Component Data Extraction**: Instance variables from components are serialized and stored
- **Tree Rendering**: Stored component trees can be re-rendered by traversing the ancestry tree

## Architecture

- Uses ViewComponent as the base component system
- Integrates with Rails through an Engine
- Provides controller and view extensions for automatic tree capture
- Uses ancestry gem for efficient tree operations
- Serializes component state as JSON

## Development Guidelines

- Follow Rails conventions for file structure
- Maintain compatibility with ViewComponent API
- Ensure thread safety for tree building
- Keep component data serializable (basic types only)
- Use ancestry gem methods for tree operations
