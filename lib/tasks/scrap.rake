require_relative '../assets/fdjbot.rb'

namespace :scrap do
    
    
    desc "This task scrap bookmaker => FDJ!"
    
    task :FDJ do
        a = Time.now
        p ParionsSportWorker.scrap_urls_bet.count 
        c=Time.now
        p "time running: #{c-a} sec"
    end
    
end
