$(document).ready( function() {
    
    $(".modal-link").click(function(e) {
       e.preventDefault();
       $("#"+$(this).attr("id")+"_modal").addClass('visible');
    });
   
    $(".field input[disabled] ~ .edit-link, .field textarea[disabled] ~ .edit-link").click(function(e) {
        e.preventDefault
        $(this).siblings("input").removeAttr("disabled").focus();
        $(this).siblings("textarea").removeAttr("disabled").focus();
    });
    
});