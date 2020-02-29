require_relative "./lib/enetscrap.rb"
class EnetScrapWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(*args)
    Enetscrap.run
  end
end
