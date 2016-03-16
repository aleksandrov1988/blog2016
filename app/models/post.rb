class Post < ActiveRecord::Base
  belongs_to :user

  scope :ordering, ->{order(created_at: :desc)}

  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  validates :user, presence: true

  def edit_by?(u)
    user.post_editor?(u)
  end
end
