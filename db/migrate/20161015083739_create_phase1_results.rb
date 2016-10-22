class CreatePhase1Results < ActiveRecord::Migration
  def change
    create_table :phase1_results do |t|
      
      t.text :name
      t.text :nric
      t.text :school
      t.text :class_name
      t.text :email
      t.text :phone
      t.text :taster_1
      t.text :taster_2
      t.text :taster_3

      t.timestamps null: false
    end
  end
end
