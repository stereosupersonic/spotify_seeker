module SpotifySeeker
  class Track
    attr_reader :name, :popularity, :album, :artist, :year, :spotify_id, :pic, :url

    def initialize(rspotify_track)
      @name         = rspotify_track.name
      @popularity   = rspotify_track.popularity
      @album        = rspotify_track.album.name
      @year         = rspotify_track.album.release_date[/\d{4}/].to_i
      @artist       = rspotify_track.artists.map(&:name).join(", ")
      @spotify_id   = rspotify_track.id
      @pic          = rspotify_track.album.images.last["url"] unless rspotify_track.album.images.empty?
      @url          = rspotify_track.external_urls["spotify"]
    end

    def to_s
      "#{spotify_id} # #{artist} - #{name} | #{year}-#{album}"
    end

    def self.find(artist:, track:)
      ::SpotifySeeker::TrackFinder.new(artist: artist, track: track).find
    end

    def self.find(spotify_id)
      rspotify_track = RSpotify::Track.find(spotify_id)
      ::SpotifySeeker::Track.new(rspotify_track) if rspotify_track
    end
  end
end
