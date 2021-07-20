desc 'Archive playlists'
task :archive => :environment do
  if Date.today.monday? || Date.today.friday?
    User.all.each do |u|
      Archiver.run(u.id)
      sleep(0.01) # throttle
    end
  end
end