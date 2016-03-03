module DeviseHelper

  # Hacky way to translate devise error messages into devise flash error messages
  def devise_error_messages!
    return '' unless resource.errors.full_messages.any?
    flash.now[:alert] = resource.errors.full_messages.map { |error| content_tag(:li, error) }.join
  end
end