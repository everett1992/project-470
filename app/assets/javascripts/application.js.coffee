# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require twitter/bootstrap
#= require bootstrap
#= require bootstrap-datepicker
#= require_tree .

$(document).ready ->
  # attatch a datepicker to inputs with the datepicker behavior
  $("[data_behaviour='datepicker']").datepicker(
      format: 'mm/dd/yyyy',
      weekStart: 1,
      autoClose: true
    ).on 'change', (ev) ->
  
      # [month, day, year]
      date_array =  ev.currentTarget.value.split('/')
      input_id = ev.currentTarget.id
      $(ev.currentTarget).siblings("##{input_id}_1i").val(parseInt(date_array[2])) # Year
      $(ev.currentTarget).siblings("##{input_id}_2i").val(parseInt(date_array[0])) # Month
      $(ev.currentTarget).siblings("##{input_id}_3i").val(parseInt(date_array[1])) # Day
