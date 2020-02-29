namespace :delete do
  
  desc "delete old records event created 1 day ago"
  task old_records: :environment do
    Event.where('created_at < ?', 1.days.ago).each do |model|
      model.destroy
    end
  end

end
