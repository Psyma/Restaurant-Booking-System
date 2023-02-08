//= require jquery
//= require jquery-ui
document.getElementById('q_name_cont').addEventListener('keyup', function(e) { 
    if (!e.target.value.length) {
        var elements = document.getElementsByName('commit');
        if (elements.length) {
            elements[0].click();
        }
    } 
});  

function test() { 
    $( "#dialog-confirm" ).dialog({
        resizable: false,
        height: "auto",
        width: 400,
        modal: true,
        buttons: {
          "Delete all items": function() {
            $( this ).dialog( "close" );
          },
          Cancel: function() {
            $( this ).dialog( "close" );
          }
        }
      });
} 