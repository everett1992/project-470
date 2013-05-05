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

  def avatar_image_tag(user, options={})
    options.reverse_merge!(alt: user.name, size: '64x64')
      link_to user do
      if user.avatar_url?
          image_tag user.avatar_url, options
      else
          image_tag 'default_user.png', options
      end
    end

  end
end
