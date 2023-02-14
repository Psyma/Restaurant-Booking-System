// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery_ujs 
//= require jquery  
//= require jquery-ui
 
import "@hotwired/turbo-rails";
import "controllers";        

jQuery(document).ready(function(){
    let nav_height = $(".navbar").height();  
    $('#content').css({"height": `calc(100vh - ${nav_height}px)`})   

    $(window).on('resize', function(){
        let nav_height = $(".navbar").height();   
        $('#content').css({"height": `calc(100vh - ${nav_height}px)`})   
    });    

    $(".toast").show()  
}); 

 
