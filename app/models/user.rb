class User < ActiveRecord::Base
  has_secure_password
  before_create { generate_token(:auth_token) }
  has_many :comments, dependent: :destroy
  has_many :authentications

  before_save { self.email = email.downcase }
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def gravatar
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=512&d=retro"
  end

=begin
  ###备忘: 以下是第三方登录Omniauth相关的代码,具体复习看教程  http://railscasts-china.com/episodes/omniauth-2-identity

  accepts_nested_attributes_for :authentications

  def add_auth(auth)
    authentications.create(:provider => auth[:provider],
                           :uid => auth[:uid])
  end

  class << self
    def from_auth(auth)
      #先找寻 authentication,找到了就返回对应的 user; 找不到就找 email, 找到了就在 user 下建立新的 auth;找不到就自己建立个 auth
      locate_auth(auth) || locate_email(auth) || create_user_with_auth(auth)
    end

    def locate_auth(auth)
      #寻找 auth,找到了就返回对应的 User
      Authentication.find_by_provider_and_uid(auth[:provider],
                                               auth[:uid].try(:user))
    end

    def locate_email(auth)
      #在 auth 里面根据 email 找寻用户,如果没有找到就立即 retun, 如果找到了就在 user上增加一个 add_auth方法,给 user 加一个新的 authentication.最后还要返回 user
      user = find_by_email(auth[:info][:email])
      return unless user
      user.add_auth(auth)
      user
    end

    def create_user_with_auth(auth)
      create!(
        :name => auth[:info][:name],
        :email => auth[:info][:email],
        :authentications_attributes => [
          Authentication.new(:provider => auth[:provider],
                             :uid => auth[:uid]
                            ).attributes
        ])
    end
  end
=end

#备忘:好多视频网的login-with-linkedin教程
  def self.from_auth(auth)
    User.where(auth.slice(:provider)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
    end
  end
end
