class Enetscrap

    def self.run
        Selenium::WebDriver::Firefox::Binary.path="/app/vendor/firefox/firefox"
        sport_array = ['football','tennis','icehockey','basketball','handball','am_football','volleyball','rugby_union']
        b = Watir::Browser.new :firefox, headless: true #Browser INIT
        sport_array.each{|sport|
            b.goto "https://www.enetscores.com/#{sport}"
            b.wait
            cpt = 0
            p b.span(class: 'wff_sport_label').text
            until cpt == 1
                p b.div(class: 'wff_calendar_select_text').text 
                if b.div(class: 'icon-no_information').exists?
                    p 'no-info'
                else
                    b.divs.select{|div| div.attribute_value('class').include?('data_loaded')}.first
                    pointeur = b.divs.select{|div| div.attribute_value('class').include?('data_loaded')}.first
                    attribute_value_class = pointeur.child.children.select{|div| !div.attribute_value('id').empty?}.first.attribute_value('class')
                    
                    pointeur.wait_until(&:present?)
                    while pointeur.children.last.divs.empty?
                        pointeur.scroll.to :bottom
                    end
                    b.divs(class: attribute_value_class).each {|event|
                        @sport = b.span(class: 'wff_sport_label').text
                        @title = event.divs.select{|div| div.attribute_value('class').include?('wff_responsive_text')}[-2].text + ' - ' + event.divs.select{|div| div.attribute_value('class').include?('wff_responsive_text')}[-1].text
                        @date = b.div(class: 'wff_calendar_select_text').text  
                        @enet_id = event.id
                        #Enetvent.create(sport: @sport , title: @title, date: Date.strptime(@date, '%d/%m/%Y'), enet_id: @enet_id )
                        p @title
                    }
                    
                end
                b.div(class: 'icon-select_right').click 
                cpt += 1
            end
        
            
        }
        b.close
    
    end
    
    
    
end