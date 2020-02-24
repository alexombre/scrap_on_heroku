require 'bundler'
Bundler.require


#CHECK 100 %

class ParionsSportWorker


    Watir.default_timeout = 60
    
    def self.scrap_urls_bet #FCT for scrap urls of each event
        b = Watir::Browser.new :firefox, headless: true #Browser INIT
        b.goto 'https://www.enligne.parionssport.fdj.fr/calendrier?selection=240,239,227,22877,1100,2100,1200#section-header-calendar' #All events page
        b.wait
        @urls_arr = [] #array for save urls in string
        b.button(class: "miniFilter-btn__live").click #Click button for delete live event
        while b.h4(class: "is-open").parent.parent.children.count < 5 #while there are not 5 block of event
            b.execute_script("arguments[0].click();", b.button(text: "Afficher les jours suivants")) #Click button for reveal other event
            if b.button(class: "wpsel-internalLink1").text == "..."  #If DOM change button to "..." wait until change again
                Watir::Wait.until { b.button(class: "wpsel-internalLink1").text != "..." }
            end
        end
        
        b.h4(class: "is-open").parent.parent.children[0..3].each {|div| #Take 4 days of event (today, tomorrow, J+2, J+3)
            div.elements(tag_name: 'wpsel-event-main').each {|info|
                @urls_arr << info.a.attribute_value('href') #Scrap urls and save in array
            }
        }
        b.close
        return @urls_arr
    end
    
    def self.scrap_bet(all_urls = []) #FCT for scrap all bets in event and take urls array in argument
        b = Watir::Browser.new :firefox, headless: true
        all_urls.each { |url| 
            begin #If there is an error in scraping bets skip the event with next method
                b.goto url 
                b.wait
                @all_data_hash = {} #Hash for save all data for each event: sport, title, home/away (team or player), datetime, bets
                @sport = b.as(class: 'breadcrumb-item')[1].text
            
                @title = b.div(class: 'headband-eventLabel').text
                @home = @title.split(" - ").first
                @away = @title.split(" - ").last
                @datetime = b.div(class: 'header-banner-event-date-section').text
                @all_data_hash["sport"] = @sport
                @all_data_hash["title"] = @title
                @all_data_hash["home"] = @home
                @all_data_hash["away"] = @away
                @all_data_hash["datetime"] = @datetime
                
                ##SCRAP BET 
                b.divs(class: 'wpsel-market-detail').each {|bet| #clik on  all DROPDOWN
                    next if !bet.button(text: 'Afficher plus de pronostics').exists?
                    b.execute_script("arguments[0].click();", bet.button(text: 'Afficher plus de pronostics'))
                }
                @bet_hash = {} #Hash for save all bets
                @all_option_arr = b.divs(class: 'wpsel-market-detail')
                @all_option_arr.each {|bet|
                    @odds_arr = []
                    bet.divs(class: 'buttonLine-item').each { |odd|
                        @odds_arr << { odd.label(class: 'outcomeButton-label').text => odd.span(class: 'outcomeButton-data').text }
                    }
                    @bet_hash[bet.span(class: 'wpsel-titleRubric-detailMarket').text] = @odds_arr
                }
                
                @all_data_hash["bets"] = @bet_hash
            rescue => e
                p "error for #{url}"
                e.backtrace.each{|error_line|
                    p error_line
                }
                next
            else
                p "done for #{url}"
=begin
                #Save all data in temporary file in JSON
                File.open("temp#{all_urls.index(url)}.json","w") do |f|
                  f.write(@all_data_hash.to_json)
                end
=end
            end
        }
        b.close
    end


end 


=begin
a = Time.now
ParionsSportWorker.scrap_bet(ParionsSportWorker.scrap_urls_bet[0..1]) #Scrap all urls bet and return the first two urls event and then scrap each event
c=Time.now
p "time running: #{c-a} sec"
=end
#binding.pry

