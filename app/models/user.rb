# frozen_string_literal: true

class User < ApplicationRecord
  ROLES = %w[user admin].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:line]

  has_many :favorites, dependent: :destroy
  has_many :favorited_events, through: :favorites, source: :charitable_event
  validates :role, inclusion: { in: ROLES }

  def self.from_omniauth(auth)
    if auth.provider == 'line'
      user = User.find_or_create_by(line_id: auth.uid)
      user.update(name: auth.info.name)
      user
    end
  end

  # params[:source_user_id]
  # params[:profile][:displayName]
  def self.from_kamigo(params)
    return unless params[:profile].present? && params[:source_user_id].present?

    line_id = params[:source_user_id]
    name = params.dig(:profile, :displayName)

    user = User.find_or_create_by(line_id:)
    user.update(name:)
    user
  end

  def email_required?
    false
  end

  def password_required?
    false
  end

  def admin?
    role == 'admin'
  end
end
