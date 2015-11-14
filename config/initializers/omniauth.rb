=begin
#假如登录时候失败.怎样显示错误.
OmniAuth.config.on_failure do |env|
  [302, {'Location' => "/auth/#{env['omniauth.error.strategy'].name}/failure?message=#{env['omniauth.error.type']}"}, ["Redirecting..."]]
end
=end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '9f3d9d172c29db104d10', 'c3da6fc9c5ce9bf50522487d2c8abede5366d766'

  provider :identity, :fields => [:name, :email]#, on_failed_registration: UsersController.action(:new)
end
