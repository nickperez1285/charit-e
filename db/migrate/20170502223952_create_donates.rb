class CreateDonates < ActiveRecord::Migration[5.0]
  def change
    create_table :donates do |t|
    	t.boolean :twentyfive, default: false 
    	t.boolean :fifty, default: false 
      t.boolean :hundred, default: false 
    	t.boolean :twohundredfifty, default: false 
    	t.string :custom, default: nil
    	t.boolean :recurring, default: false 

      t.timestamps
    end
  end
end
