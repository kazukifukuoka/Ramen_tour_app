module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    html = ''
    resource.errors.full_messages.each do |error_message|
      html += <<-HTML
      <div class="alert alert-danger alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
          <span class="sr-only">close</span>
        </button>
        #{error_message}
      </div>
      HTML
    end
    content_tag(:html, html)
  end
end
