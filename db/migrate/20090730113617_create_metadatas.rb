class CreateMetadatas < ActiveRecord::Migration
  def self.up
    create_table :metadatas do |t|
      t.integer :metadatable_id
      t.string :metadatable_type
      t.string :description
      t.string :keywords
      t.timestamps
    end
  end

  def self.down
    drop_table :metadatas
  end
end
