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
  
window.dangerConfirm = (product_id, product_name) ->
  $(".btn-danger").addClass("disabled").hide()
  $("h1").parent().prepend('<div class="alert alert-error" id="danger-confirm" style="display: none">
                            <a class="close" data-dismiss="alert">×</a>
                            <h4 class="alert-heading">'+product_name+' will be gone!</h4>
                            <p id="danger-msg"></p>                            
                            <a class="btn btn-danger" href="/products/'+product_id+'" data-method="delete">Proceed</a> 
                            <a class="btn" href="#" data-dismiss="alert">Cancel</a>
                            </div>')
  $("#danger-confirm").fadeIn().children("#danger-msg").html("What you are about to do is irreversible and your product will be permanently removed");