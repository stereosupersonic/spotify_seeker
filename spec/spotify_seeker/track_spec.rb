require "spec_helper"

RSpec.describe SpotifySeeker::Track do
  describe "find track" do
    it "have a valid track" do
      VCR.use_cassette("valid_track", record: :once) do
        track = SpotifySeeker::Track.find(artist: "Metallica", track: "one")
        expect(track.spotify_id).to eq("64Ret7Tf2M8pDE4aqbW2tX")
        expect(track.name).to eq("One")
        expect(track.popularity).to eq(69)
        expect(track.album).to eq("...And Justice For All")
        expect(track.artist).to eq("Metallica")
        expect(track.year).to eq(1988)
        expect(track.pic).to eq("https://i.scdn.co/image/c4c28b8d2189aa76c1866d81cabbb29c6de92cc9")
        expect(track.url).to eq("https://open.spotify.com/track/64Ret7Tf2M8pDE4aqbW2tX")
        expect(track.to_s).to eq("64Ret7Tf2M8pDE4aqbW2tX # Metallica - One | 1988-...And Justice For All")
      end
    end

    it "returns a Null object when track was not found" do
      VCR.use_cassette("not_found", record: :once) do
        track = SpotifySeeker::Track.find(artist: "Huber", track: "Blah")
        expect(track).to be_a(SpotifySeeker::NullTrack)
        expect(track.to_s).to eq("# not found Huber - Blah")
      end
    end
  end
end
