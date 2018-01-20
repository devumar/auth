require 'google/api_client'
require 'trollop'

class YoutubeService

	def initialize(seatch_terms)
		@seatch_terms = seatch_terms
		@DEVELOPER_KEY = 'AIzaSyBF0vUCWPugUQaoJW79tlcZXi3GosQ-4UA'
		@YOUTUBE_API_SERVICE_NAME = 'youtube'
		@YOUTUBE_API_VERSION = 'v3'
  end


  	def get_service
	  client = Google::APIClient.new(
	    :key => @DEVELOPER_KEY,
	    :authorization => nil,
	    :application_name => $PROGRAM_NAME,
	    :application_version => '1.0.0'
	  )
	  youtube = client.discovered_api(@YOUTUBE_API_SERVICE_NAME, @YOUTUBE_API_VERSION)

	  return client, youtube
	end


	def main
		seatch_terms = @seatch_terms
	  opts = Trollop::options do
			opt :q, 'Search term', :type => String, :default => seatch_terms
	    opt :max_results, 'ssds', :type => :int, :default => 25
	  end

	  client, youtube = get_service

	  begin
	    # Call the search.list method to retrieve results matching the specified
	    # query term.
	    search_response = client.execute!(
	      :api_method => youtube.search.list,
	      :parameters => {
	        :part => 'snippet',
	        :q => opts[:q],
	        :maxResults => opts[:max_results]
	      }
	    )

	    videos = []

	    # Add each result to the appropriate list, and then display the lists of
	    # matching videos, channels, and playlists.
	    search_response.data.items.each do |search_result|
	      case search_result.id.kind
	        when 'youtube#video'
	          videos << "#{search_result.snippet.title} (#{search_result.id.videoId})"
	      end
	    end
	  return videos

	  rescue Google::APIClient::TransmissionError => e
	    return e.result.body
	  end
	end

end
