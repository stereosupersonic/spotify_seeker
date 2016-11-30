module SpotifySeeker
  class TrackFinder
    EXCLUDED_TRACK_WORDS = %w(
      [Explicit]
    )

    EXCLUDED_ARTIST_WORDS = %w(
    )

    def initialize(artist:, track:)
      @artist = artist
      @track = track
    end

    def find
      # you can also use this for better search
      # RSpotify::Base.search 'queen artist:abba album:gold', 'track'
      # https://developer.spotify.com/web-api/search-item/
      SpotifySeeker.logger.info "search fo artist: #{normalized_artist} track: #{normalized_track}"

      tracks = []
      if !normalized_track.empty? && !normalized_artist.empty?
        SpotifySeeker.logger.info "search query #{seach_str}"
        tracks = find_rspotify
      end
      tracks[0] || NullTrack.new(artist: normalized_artist, track: normalized_track)
    end

    private

    def find_rspotify
      result = RSpotify::Track.search(seach_str, limit: 3, market: "DE").map { |t| Track.new(t) }

      result.sort do |a, b|
        if a.year == b.year
          b.popularity <=> a.popularity
        else
          a.year <=> b.year
        end
      end
    end

    def normalized_track
      @normalized_track ||= normalize(@track).gsub(Regexp.union(EXCLUDED_TRACK_WORDS), "").strip
    end

    def normalized_artist
      @normalized_artist ||= normalize(@artist).gsub(Regexp.union(EXCLUDED_ARTIST_WORDS), "").strip
    end

    def normalize(str)
      str.to_s.gsub(/(\(.+\))/, "").delete("’").delete('\'').encode("UTF-8")
    end

    def seach_str
      @seach_str ||= "artist:#{normalized_artist.tr(' ', '+')} track:#{normalized_track.tr(' ', '+')}"
    end
  end
end
