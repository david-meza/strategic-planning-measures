module UserRules
  extend ActiveSupport::Concern

  included do
    belongs_to :author, foreign_key: :created_by_user_id, class_name: "User"
    
    belongs_to :last_editor, foreign_key: :last_updated_by_user_id, class_name: "User"
  end

  def author_is_admin
    unless author.try(:admin?)
      errors.add(:permission, "only admins can create a #{self.class.model_name.human}")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def editor_is_admin
    unless author.try(:admin?)
      errors.add(:permission, "only admins can update a #{self.class.model_name.human}")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  module ClassMethods
    
  end

end