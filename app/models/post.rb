class Post < ActiveRecord::Base
  belongs_to :user
  has_many :attachments, ->{ordering}, dependent: :destroy, inverse_of: :post

  scope :ordering, ->{order(created_at: :desc)}
  scope :full, ->{includes(:attachments)}

  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  validates :user, presence: true

  attr_reader :files

  def self.create_by?(user, current_user)
    current_user && (user == current_user || current_user.admin?)
  end

  def edit_by?(u)
    self.class.create_by?(user, u)
  end

  def files=(val)
    val.each_with_index do |file, i|
      self.attachments.build(image: file, position: attachments.maximum(:position).to_i + i + 1)
    end
  end
end
