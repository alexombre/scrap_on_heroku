require_relative "#{Rails.root.to_s}/app/workers/lib/enetscrap.rb"

namespace :scrap do
    
    
    desc "This task scrap bookmaker => FDJ!"
    
    task :FDJ => :environment do
        Enetscrap.run
    end
    
end
