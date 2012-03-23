# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.onload = ->
   prepare_products()

window.prepare_products = ->
   $('#danger-confirm').live('close', -> 
     $(".disabled").removeClass("disabled").show()
   )
   
   $(".pagination a").click = ->
     $.get(this.href, null, null, 'script')
     return false
     
   $("span.label-info").css("cursor", "pointer")
   $(".tabs").button()
   $("input[name=product]").focus()

window.dangerClose = ->
  $("#danger-confirm").hide()
  $("tbody tr td .btn-danger").removeClass("disabled").show()
  return false
  
window.dangerConfirm = (product_path, product_name) ->
  $("#danger-confirm").fadeIn()
  $("tbody tr td .btn-danger").addClass("disabled").hide()
  $("#danger-confirm h4 span").text(product_name)
  $("#danger-confirm a[data-method=delete]").attr("href", product_path)
  
window.remove_filter = (filter_tag) ->
  $("#remove_filter").val($(filter_tag).text())
  parent_form=$(filter_tag).parent("form")
  $(filter_tag).remove()
  parent_form.submit()

window.setup_slider = (min_value,max_value, current_min, current_max) ->
  $( "#slider-range" ).slider({
    range: true,
  	animate: true,
  	min: min_value,
  	max: max_value,
  	values: [ current_min,  current_max ],
  	slide: (event,ui) -> 
  	  $("#amount" ).text( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] )
  	  $("#price").val(ui.values[ 0 ] + ".." + ui.values[ 1 ])
    })
  			
  $( "#amount" ).text( "$" + $( "#slider-range" ).slider( "values", 0 ) + " - $" + $( "#slider-range" ).slider( "values", 1 ) )
  