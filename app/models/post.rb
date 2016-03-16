class Post < ActiveRecord::Base
  belongs_to :user

  scope :ordering, ->{order(created_at: :desc)}

  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  validates :user, presence: true

  def self.create_by?(user, current_user)
    current_user && (user == current_user || current_user.admin?)
  end

  def edit_by?(u)
    self.class.create_by?(user, u)
  end
end
