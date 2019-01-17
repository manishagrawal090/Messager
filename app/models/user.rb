class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :personal_messages, dependent: :destroy

  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy


  has_many :friendships
  has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
  has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
  has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
  has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user

# to call all your friends

  def friends
    active_friends | received_friends
  end

  def pending
    pending_friends | requested_friendships
  end


  def name
    email.split('@')[0]
  end

  def friends?(user)
    self.friends.include?(user)
  end


  def contacted?(user)
    friends?(user) || pending_friends?(user)
  end

  def friends?(user)
    self.friends.include?(user)
  end

  def pending_friends?(user)
    self.pending.include?(user)
  end
end


