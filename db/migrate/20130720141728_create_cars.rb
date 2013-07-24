class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.float :horsepower
      t.string :number_plate
      t.date :register_date
      t.string :country
      t.string :owner

      t.timestamps
    end
  end
end
