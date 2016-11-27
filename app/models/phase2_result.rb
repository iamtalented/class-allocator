class Phase2Result < ActiveRecord::Base
    belongs_to :Phase2s
    
        def self.to_csv(options = {})
        attributes = %w{name nric school class_name email phone final_selection}
        CSV.generate(options) do |csv|
            csv << {name: 'Name', nric: 'NRIC', school: 'School', class_name: 'Class', email: 'Email', phone: 'Phone', final_selection: 'Final_selection'}.values
                all.each do |phase2_result|
            csv << {name: 'Name', nric: 'NRIC', school: 'School', class_name: 'Class', email: 'Email', phone: 'Phone', final_selection: 'Final_selection'}.keys.map{ |attr| phase2_result.send(attr) }
        end
      end
    end
end
