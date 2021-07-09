class Archiver
  def self.run(user_id)
    new(user_id: user_id).run
  end

  def initialize(user_id:)
    @user_id = user_id
  end

  def run
    archive
  end

  private

  attr_reader :user_id

  def archive
    archive_discovery_weekly if discover_weekly
    archive_release_radar if release_radar
  end

  def user
    user = User.find(user_id)
    connection = user.settings.to_hash
    RSpotify::User.new(connection)
  end

  def discover_weekly
    user.playlists.select { |pl| pl.name == "Discover Weekly" }.first
  end

  def release_radar
    user.playlists.select { |pl| pl.name == "Release Radar" }.first
  end

  def my_archive_playlist
    user.playlists.select { |pl| pl.name == "My Archive" }.first
  end

  def archive_discovery_weekly
    tracks = discover_weekly.tracks
    add_tracks_to_archive(tracks)
  end

  def archive_release_radar
    tracks = release_radar.tracks
    add_tracks_to_archive(tracks)
  end

  def find_or_create_my_archive_playlist
    my_archive_playlist || create_my_archive_playlist
  end

  def create_my_archive_playlist
    user.create_playlist!('My Archive', description: 'Discover Weekly & Release Radar Archive')
  end

  def add_tracks_to_archive(tracks)
    new_tracks = []
    archive_playlist = find_or_create_my_archive_playlist
    tracks.each do |track|
      next if archive_playlist.tracks.map(&:id).include?(track.id)
      new_tracks << track
    end
    archive_playlist.add_tracks!(new_tracks) if !new_tracks.empty?
  end
end