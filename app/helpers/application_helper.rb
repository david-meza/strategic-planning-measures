module ApplicationHelper

  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym]
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade-in", role: 'alert') do
        concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
          concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
          concat content_tag(:span, 'Close', class: 'sr-only')
        end)
        concat content_tag(:strong, message.html_safe)
      end)
    end
    nil
  end

  def info_box
    content_tag(:div, class: "alert info-box layout-row layout-align-center-center", role: 'alert') do
      yield
      concat( content_tag(:button, class: "close spaced-items", data: { dismiss: 'alert' }) do
        concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
        concat content_tag(:span, 'Close', class: 'sr-only')
      end)
    end
  end

  def admin_content(options = {})
    if (current_user.try(:admin?) && !session[:view_as_user]) || (current_user == options[:exception_user] && controller_name == options[:exception_controller])
      yield
    end
  end

  def is_admin?(options = {})
    (current_user.try(:admin?) && !session[:view_as_user]) || (current_user == options[:exception_user] && controller_name == options[:exception_controller])
  end

  def cancel_user_view
    if session[:view_as_user]
      content_tag(:div, class: "container-fluid") do
        info_box do
          concat content_tag(:span, "This is what the application looks like to users", class: "spaced-items")
          concat link_to "Back to Admin view", admin_cancel_view_as_user_path, method: :delete, class: "spaced-items"
        end
      end
    end
  end

end
