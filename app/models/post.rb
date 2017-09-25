class TitleValidator < ActiveModel::Validator
  def validate(record)
    if record.title != nil
      unless record.title.include?("Won't Believe") || record.title.include?("Secret") || record.title.include?("Top #{/[0-9]+/}") || record.title.include?("Guess")
        record.errors[:base] << "This title isn't clickbaity"
      end
    else
      record.errors[:base] << "This title isn't clickbaity"
    end
  end
end

class Post < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with TitleValidator
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    #title must contain "Won't Believe", "Secret", "Top [number]", or "Guess"
    # or return false
end
