# frozen_string_literal: true

class CreateActiveViewComponents < ActiveRecord::Migration[7.0]
  def change
    create_table :active_view_components do |t|
      t.string :view_component_class_name, null: false
      t.text :component_data, null: false
      t.text :render_options
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.timestamps
    end
    
    add_index :active_view_components, :ancestry
    add_index :active_view_components, :view_component_class_name
    add_index :active_view_components, :created_at
  end
end
