class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.references :order
      t.string :type
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.string :description
      t.integer :position
      t.timestamps
    end
    change_table :orders do |t|
       t.decimal :credit_total, :precision => 8, :scale => 2, :default => 0.0, :null => false      
     end
   end

  def self.down
    drop_table :credits
  end
end
