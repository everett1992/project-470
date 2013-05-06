module ApplicationHelper
  def calendar_datepicker(method, builder, html_options={})
    default_date = builder.object.method(method).call() || Date.today()
    render partial: 'application/datepicker',
    locals: {
      method: method,
      default_date: default_date,
      builder: builder,
      html_options: html_options
    }
  end

  def profile_picture_tag(user, options = {})
    options.reverse_merge!({:alt => user.name, :size => "64x64"})
    image_tag user.picture_url, options
  end
end
