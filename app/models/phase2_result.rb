class Phase2Result < ActiveRecord::Base
    belongs_to :phase2s

    def self.to_csv(options = {})
        CSV.generate(options) do |csv|
            csv << {name: 'Name', nric: 'NRIC', school: 'School', class_name: 'Class', email: 'Email', phone: 'Phone', final_selection: 'Final Selection'}.values
                all.each do |phase2_result|
            csv << {name: 'Name', nric: 'NRIC', school: 'School', class_name: 'Class', email: 'Email', phone: 'Phone', final_selection: 'Final Selection'}.keys.map{ |attr| phase2_result.send(attr) }
            end
        end
    end
    
end
