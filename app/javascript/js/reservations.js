document.getElementById('q_name_cont').addEventListener('keyup', function(e) { 
    if (!e.target.value.length) {
        var elements = document.getElementsByName('commit');
        if (elements.length) {
            elements[0].click();
        }
    } 
});  