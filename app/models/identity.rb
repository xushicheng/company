class Identity < OmniAuth::Identity::Models::ActiveRecord
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
  validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
end
