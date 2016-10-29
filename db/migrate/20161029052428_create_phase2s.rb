class CreatePhase2s < ActiveRecord::Migration
  def change
    create_table :phase2s do |t|
      
      t.text :name
      t.text :nric
      t.text :school
      t.text :class_name
      t.text :email
      t.text :phone
      t.text :choice_1
      t.text :choice_2

      t.timestamps null: false
    end
  end
end
