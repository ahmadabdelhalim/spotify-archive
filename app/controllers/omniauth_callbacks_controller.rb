class OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  def spotify
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user
      auth = request.env["omniauth.auth"]
      spotify_user = RSpotify::User.new(auth).to_hash
      @user.update(settings: spotify_user)
      
      sign_in_and_redirect @user, event: :authentication

      ArchiverWorker.perform_async(@user.id)
    end
  end
end