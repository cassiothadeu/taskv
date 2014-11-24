ActionView::Base.field_error_proc = proc do |html, instance|
  %[<span class="field-with-error">#{html}</span>].html_safe
end
