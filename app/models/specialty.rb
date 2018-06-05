class Specialty < ApplicationRecord

	has_many :moving_tasks, dependent: :nullify
	validates :name, presence: true
end
