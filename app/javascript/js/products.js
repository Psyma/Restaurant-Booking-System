jQuery(document).ready(function(){
    let nav_height = $(".navbar").height();  
    $('#content').css({"height": `calc(100vh - ${nav_height}px)`})   

    $(window).on('resize', function(){
        let nav_height = $(".navbar").height();   
        $('#content').css({"height": `calc(100vh - ${nav_height}px)`})   
    });   
    
     
}); 
    
$('#q_name_cont').on("input keyup", (e) => {
    if (!e.target.value.length) {
        var elements = document.getElementsByName('commit');
        if (elements.length) {
            elements[0].click();
        }
    } 
}) 