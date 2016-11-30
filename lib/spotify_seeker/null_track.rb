module SpotifySeeker
  class NullTrack
    def initialize(artist:, track:)
      @artist = artist
      @track = track
    end

    def to_s
      "# not found #{@artist.strip} - #{@track.strip}"
    end
  end
end
