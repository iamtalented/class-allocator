class Phase1Result < ActiveRecord::Base
    belongs_to :Phase1s
    
        def self.to_csv(options = {})
        attributes = %w{name nric school class_name email phone taster_1 taster_2 taster_3}
        CSV.generate(options) do |csv|
            csv << {name: 'Name', nric: 'NRIC', school: 'School', class_name: 'Class', email: 'Email', phone: 'Phone', taster_1: 'Taster 1', taster_2: 'Taster 2', taster_3: 'Taster 3'}.values
                all.each do |phase1_result|
            csv << {name: 'Name', nric: 'NRIC', school: 'School', class_name: 'Class', email: 'Email', phone: 'Phone', taster_1: 'Taster 1', taster_2: 'Taster 2', taster_3: 'Taster 3'}.keys.map{ |attr| phase1_result.send(attr) }
        end
      end
    end
end
