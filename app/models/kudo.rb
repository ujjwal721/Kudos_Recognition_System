class Kudo < ApplicationRecord
  belongs_to :sender,   class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :message, presence: true
  validates :points,  presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :points_within_allowed_range
  validate :valid_hierarchy

  # Define allowed point ranges for each sender role.
  ALLOWED_POINT_RANGES = {
    manager:   (40..50),
    tech_lead: (30..40),
    sde2:      (20..30),
    sde1:      (10..20),
    other:     (1..10)
  }.freeze

  # Scope to return kudos where the receiver is in the same or lower hierarchy than the given user.
  scope :visible_to, ->(user) {
    joins("INNER JOIN users ON kudos.receiver_id = users.id")
      .where("users.role >= ?", user.role)
  }

  private

  def points_within_allowed_range
    return unless sender && points

    sender_role = sender.role_name
    allowed_range = ALLOWED_POINT_RANGES[sender_role]
    unless allowed_range.include?(points)
      errors.add(:points, "must be within #{allowed_range} for a #{sender_role}")
    end
  end

  def valid_hierarchy
    return unless sender && receiver

    unless sender.can_send_kudos_to?(receiver)
      errors.add(:base, "You can only send kudos to someone at your level or lower in the hierarchy")
    end
  end
end
