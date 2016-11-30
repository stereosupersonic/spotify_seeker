require "spotify_seeker/version"
require "spotify_seeker/track"
require "spotify_seeker/null_track"
require "spotify_seeker/track_finder"

require "rspotify"
require "logger"

module SpotifySeeker
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new("spotify_seeker.log").tap do |log|
        log.progname = name
      end
    end
  end
end
