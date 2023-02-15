$('#q_first_name_cont').on("input keyup", (e) => {
    if (!e.target.value.length) {
        var elements = document.getElementsByName('commit');
        if (elements.length) {
            elements[0].click();
        }
    } 
}) 