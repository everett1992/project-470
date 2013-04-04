module ApplicationHelper
  def calendar_datepicker(method, builder, html_options={})
    render :partial => 'application/datepicker',
      :locals => {:method => method, :f => builder, :html_options => html_options}
  end
end
