class RenameColumnNameForFileLocation < ActiveRecord::Migration[5.0]
  def change
    rename_column :file_locations, :type, :file_type
  end
end
