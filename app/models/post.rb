class Post < ActiveRecord::Base
  belongs_to :user

  scope :ordering, ->{order(:created_at)}

  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  validates :user, presence: true
end
