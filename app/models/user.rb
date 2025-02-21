class User < ApplicationRecord
    has_secure_password
  
    # Define custom roles (lower number = higher in hierarchy)
    ROLE_VALUES = {
      manager:   0,
      tech_lead: 1,
      sde2:      2,
      sde1:      3,
      other:     4
    }.freeze
  
    validates :role, inclusion: { in: ROLE_VALUES.values }
    validates :name,  presence: true
    validates :email, presence: true, uniqueness: true
  
    # Associations for sending and receiving kudos.
    has_many :kudos_sent,     class_name: 'Kudo', foreign_key: 'sender_id', dependent: :destroy
    has_many :kudos_received, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :destroy
  
    # Return the role as a symbol (e.g., :manager)
    def role_name
      ROLE_VALUES.key(role)
    end
  
    # Compare hierarchy: lower integer means higher in hierarchy.
    def higher_or_equal_than?(other)
      self.role <= other.role
    end
  
    # Check if this user can send kudos to another.
    def can_send_kudos_to?(other)
      higher_or_equal_than?(other)
    end
  end
  