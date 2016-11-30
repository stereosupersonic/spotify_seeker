$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "spotify_seeker"
require "spotify_seeker/track"
require "spotify_seeker/null_track"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/cassettes"
  config.hook_into :webmock
end
