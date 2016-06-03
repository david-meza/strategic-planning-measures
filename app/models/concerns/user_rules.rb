module UserRules
  extend ActiveSupport::Concern

  included do
    belongs_to  :author, 
                foreign_key: :created_by_user_id, 
                class_name: "User"
      
    belongs_to  :last_editor, 
                foreign_key: :last_updated_by_user_id, 
                class_name: "User"
  end

  def author_is_admin
    unless author.try(:admin?)
      errors.add(:permission, "error: Only admins can create a #{self.class.model_name.human}")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def editor_is_admin
    unless last_editor.try(:admin?)
      errors.add(:permission, "error: Only admins can update a #{self.class.model_name.human}")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def editor_is_admin_or_author
    unless last_editor.try(:admin?) || last_editor.id == author.id
      errors.add(:permission, "error: You don't have permission to update this #{self.class.model_name.human}")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  module ClassMethods
    
  end

end