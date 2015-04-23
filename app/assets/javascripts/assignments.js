

$(document).ready(function(){
    return;
  var form = $( "#newAssignmentForm");
  form.hide();
  $( "#newAssignmentButton" ).on( "click", function() {
      toggleButtonValue($(this), form);
  });
});

function toggleButtonValue(element, form) {
  var value = element.val();
  var val1 = "Show form";
  var val2 = "Hide form";
  if (value === val1) {
    element.val(val2);
    form.show();
  } else {
    element.val(val1);
    form.hide();
  }
}
