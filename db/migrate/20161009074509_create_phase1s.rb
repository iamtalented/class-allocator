class CreatePhase1s < ActiveRecord::Migration
  def change
    create_table :phase1s do |t|
      
      t.text :name
      t.text :nric
      t.text :school
      t.text :class_name
      t.text :email
      t.text :phone
      t.text :choice_1
      t.text :choice_2
      t.text :choice_3
      t.text :choice_4
      t.text :choice_5

      t.timestamps null: false
    end
  end
end
