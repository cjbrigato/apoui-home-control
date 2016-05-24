$(function() {
    
    var $formLogin = $('#login-form');
    var $formResult = $('#result-form');
    var $divForms = $('#div-forms');
    var $modalAnimateTime = 300;
    var $msgAnimateTime = 150;
    var $msgShowTime = 2000;

    $("#login-form").submit(function () {
        switch(this.id) {
            case "login-form":
                var username=$('#login_username').val();
                var cipher=$('#login_cipher').val();
		var userobj={ "username":username, "cipher":cipher};
                /* if ($lg_username == "ERROR") {
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Login error");
                } else {
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Login OK");
                } */
		$.ajax({
			url: "/keys",
			type: "GET",
			//data: "username="+username+"&cipher="+cipher,
			data: userobj,
			success: function (key) { 
msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Got It !");
modalAnimate($formLogin, $formResult);
msgFade($("#keyresult"), key);

			},
			error: function (request, status, error) {
msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", request.responseText);
                        },

});
                return false;
                break;
            default:
                return false;
        }
        return false;
    });
    
    /*$('#register_lost_btn').click( function () { modalAnimate($formRegister, $formLost); }); */
      $('#return-key-btn').click( function () { modalAnimate($formResult, $formLogin); });   

 
    function modalAnimate ($oldForm, $newForm) {
        var $oldH = $oldForm.height();
        var $newH = $newForm.height();
        $divForms.css("height",$oldH);
        $oldForm.fadeToggle($modalAnimateTime, function(){
            $divForms.animate({height: $newH+50}, $modalAnimateTime, function(){
                $newForm.fadeToggle($modalAnimateTime);
            });
        });
    }
    
    function msgFade ($msgId, $msgText) {
        $msgId.fadeOut($msgAnimateTime, function() {
            $(this).text($msgText).fadeIn($msgAnimateTime);
        });
    }
    
    function msgChange($divTag, $iconTag, $textTag, $divClass, $iconClass, $msgText) {
        var $msgOld = $divTag.text();
        msgFade($textTag, $msgText);
        $divTag.addClass($divClass);
        $iconTag.removeClass("glyphicon-chevron-right");
        $iconTag.addClass($iconClass + " " + $divClass);
        setTimeout(function() {
            msgFade($textTag, $msgOld);
            $divTag.removeClass($divClass);
            $iconTag.addClass("glyphicon-chevron-right");
            $iconTag.removeClass($iconClass + " " + $divClass);
  		}, $msgShowTime);
    }
});
