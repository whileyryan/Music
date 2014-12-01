class Concert
	include HTTParty

	def self.get_concerts(zipcode)
		concert_array = []
		response = HTTParty.get('http://api.jambase.com/events?zipCode=95128&radius=50&page=0&api_key=ykjjf37ekp27ykdvs2txe6je')
    	p response
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
	end
end