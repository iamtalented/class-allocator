class CreatePhase2Results < ActiveRecord::Migration
  def change
    create_table :phase2_results do |t|
      
      t.text :name
      t.text :nric
      t.text :school
      t.text :class_name
      t.text :email
      t.text :phone
      t.text :final_selection

      t.timestamps null: false
    end
  end
end
