// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails 
//= require jquery   
//= require popper  
//= require bootstrap   
//= require jquery-ui 
//= require jquery_ujs    

import "@hotwired/turbo-rails";   
import "controllers";   
import LocalTime from "local-time";   

LocalTime.start() 
jQuery(document).ready(function(){
    let nav_height = $(".navbar").height();  
    $('#content').css({"height": `calc(100vh - ${nav_height}px)`})   

    $(window).on('resize', function(){
        let nav_height = $(".navbar").height();   
        $('#content').css({"height": `calc(100vh - ${nav_height}px)`})   
    });    

    $(".toast").show()  
});  
