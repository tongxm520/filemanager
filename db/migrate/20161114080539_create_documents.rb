class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :file_type
      t.decimal :file_size, :precision => 10, :scale => 3
      t.integer :parent_id
      t.string :file_path
      t.string :absolute_path

      t.timestamps
    end
  end
end
