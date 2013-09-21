$(document).ready( function() {


    $('.toggle-switch span').click( function() {
        if($(this).attr("id").toLowerCase() == "on"){
            $(this).addClass("active-toggle-btn");
            $(".toggle-switch span#off").removeClass("active-toggle-btn");
        }else{
            $(".toggle-switch span#on").removeClass("active-toggle-btn");
            $(this).addClass("active-toggle-btn");
        }
    })
    $('#sharing-status').click( function() {
        fbid = $(this).attr('data');
        $.get('/change_sharing_status?fb_id='+fbid, function(data) {
            $('#sharing-status').removeClass('sharing-btn');
            if (!data.response){
                $('#sharing-status').removeClass('sharing-on').addClass('sharing-btn');
            }else{
                $('#sharing-status').removeClass('sharing-btn').addClass('sharing-on');
            }
        });
    });

});
