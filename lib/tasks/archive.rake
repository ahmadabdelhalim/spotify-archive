desc 'Archive playlists'
task :archive => :environment do
  User.all.find_each do |u|
    ArchiverWorker.perform_async(u.id)
    sleep(0.01) # throttle
  end
end