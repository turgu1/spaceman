class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  validates :username, :email, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }
  validates :language, inclusion: { in: %w(en fr) }, unless: -> { self.language.blank? }

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  def self.all_roles
    %w[ admin pilot buildings organisations requirements allocations space_types equipments reports backup import ]
  end

  # Required for i18n translation...
  def self.all_roles_syms
    [ :admin, :pilot, :buildings, :organisations, :requirements, :allocations, :space_types, :equipments, :reports, :backup, :import ]
  end

  def role?(role)
    not self.roles.index(role.to_s).nil?
  end

  def name
    self.username
  end
end
