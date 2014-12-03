class Concert
	include HTTParty



	def self.get_concerts(zipcode)
        if zipcode == nil
            return 
        end
        concert_array = []
        Event.delete_all
        response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=YKJJF37EKP27YKDVS2TXE6JE")
        p '='*100
        p response
        p '='*100
        if !response.include?("Events")
            return nil
        end

        response['Events'].each do |concert|
    		venue = concert['Venue']['Name']
    		date = concert['Date']
    		artist = concert['Artists'].first['Name']
    		url = concert['TicketUrl']
    		hash = {venue: venue, date: date, artist: artist, url: url}
    		# concert_array << hash
    		Event.create(hash)
    	end
    	# concert_array
        p Event.all.count
        Event.all
	end

    def self.storeConcerts(concerts)
        concert_store_array = []
        deliver_concert_array = []
        i = 0
        concerts.each do |concert|
            concert_store_array << concert
        end
        while i < 10
            deliver_concert_array << concert_store_array[i]
            concert_store_array.delete_at(i)
            i += 1
        end
        deliver_concert_array
    end
end
