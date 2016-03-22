class Attachment < ActiveRecord::Base
  belongs_to :post, inverse_of: :attachments

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }

  scope :ordering, ->{ order(:position) }
  scope :full, ->{ includes(post: :user) }

  validates :post, presence: true
  validates :position, presence: true, uniqueness: {scope: :post}, numericality: {only_integer: true}

  validates_attachment :image, presence: true, content_type: { content_type: /\Aimage/ },
  size: { in: 0..10.megabytes }

  before_validation :set_default_position


  def set_default_position
    if self.post
      self.position ||= self.post.attachments.maximum(:position).to_i + 1
    end
    true
  end

  def edit_by?(u)
    post.edit_by?(u)
  end

  def title
    comment.present? ? comment : image_file_name
  end

end
