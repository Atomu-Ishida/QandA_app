class Question < ApplicationRecord
    validates :title, presence: true, length: { maximum:30 }
    validates :description, presence: true
    
    belongs_to :user

    has_many :answers, dependent: :destroy
end
