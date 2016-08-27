class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  has_one :cart, dependent: :nullify
  has_many :orders, dependent: :nullify
  after_commit :send_greeting_email, on: :create

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |member|
      member.email = auth.info.email
      member.password = Devise.friendly_token[0,20]
      member.name = auth.info.name
      member.avatar = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |member|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        member.email = data["email"] if member.email.blank?
      end
    end
  end

  def send_greeting_email
    MemberMailer.greeting(self).deliver_later
  end
end
