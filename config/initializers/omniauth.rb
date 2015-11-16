=begin
#假如登录时候失败.怎样显示错误.
OmniAuth.config.on_failure do |env|
  [302, {'Location' => "/auth/#{env['omniauth.error.strategy'].name}/failure?message=#{env['omniauth.error.type']}"}, ["Redirecting..."]]
end
=end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2 , '814461523307-sst6fe81c1vk00nssa95r90vi58kfhu8.apps.googleusercontent.com', 'CVLaWSvFSAo9hoa01hhH0wd5'

  #provider :identity, :fields => [:name, :email]#, on_failed_registration: UsersController.action(:new)
end
