$('#q_name_cont').on("input keyup", (e) => {
    if (!e.target.value.length) {
        var elements = document.getElementsByName('commit');
        if (elements.length) {
            elements[0].click();
        }
    } 
}) 

function click_payments(){
    event.preventDefault()
    var elements = document.getElementById('continue_to_payment');
    elements.click();
}