class User < ActiveRecord::Base
  ROLES = ['Пользователь', 'Администратор']
  has_secure_password
  has_many :posts, ->{ordering}, dependent: :destroy

  scope :ordering, ->{order(:name)}



  validates :name, presence: true, length: {in: 3..200}
  validates :email, presence: true, uniqueness: {case_sensetive: false}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, length: {minimum: 6}, presence: {if: :new_record?}, allow_blank: {unless: :new_record?}
  validates :role, presence: true, inclusion: {in: 0...ROLES.size}

  before_validation :set_default_role

  def set_default_role
    self.role ||= 0
  end

  def post_editor?(u)
    u && (self == u || admin?)
  end

  def admin?
    role == 1
  end


end
