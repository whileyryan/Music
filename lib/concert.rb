class Concert
	include HTTParty



	def self.get_concerts(zipcode)
        if zipcode == nil
            return 
        end
        concert_array = []
        Event.delete_all
        response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=295TPD284R2D4PUTN3FSUX79")
        if !response.include?("Events")
            response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=g8uac2ww2frjb56bhr7bdpn7")
        end
        if !response.include?("Events")
            response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=B3Q6F9ZTGYVMDWJ57M44JFNJ")
        end
        if !response.include?("Events")
            response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=wzw4p7sy6hjvmj7hcuyhhcb4")
        end
        if !response.include?("Events")
            response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=YKJJF37EKP27YKDVS2TXE6JE")
        end
        # if !response.include?("Events")
        #     response = HTTParty.get("http://api.jambase.com/events?zipCode=#{zipcode}&radius=50&page=0&api_key=j8aah668d4ysk39ekw3qtrgy")
        # end
        if !response.include?("Events")
            response = nil
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
