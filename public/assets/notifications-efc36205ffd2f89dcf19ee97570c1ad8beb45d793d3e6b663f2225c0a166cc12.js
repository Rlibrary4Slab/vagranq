  //var dispatcher = new WebSocketRails("localhost:3000/websocket");			//  ソケット通信開始
  //var dispatcher = new WebSocketRails("192.168.1.22:3000/websocket");			//  ソケット通信開始
  var dispatcher = new WebSocketRails("192.168.33.10:3000/websocket");			//  ソケット通信開始
  //var dispatcher = new WebSocketRails("ranq-media.com/websocket");			//  ソケット通信開始

  var toaster = function(info, msg) {									                              //  トースター通知
    if($('toaster-box').length==0)
    var item1 = $('<toaster-box position="top-right"><toaster-start class="like-info" ></toaster-start></toaster-box>');
    $('body').append(item1);
    var item2 = '<toaster class='+info+'><button type="button" class="close" data-dismiss="like_comment">×</button>'+msg+'</toaster>';
    var toaster = $(item2).insertAfter('toaster-box > toaster-start').hide().fadeIn(800).delay(3000).fadeOut(1000);
    $('.close').click(function() {
      $(this).fadeOut(500, function() {
        $(this).parent().remove();
      });
    });
  };

  var note_center = function(msg,data) {                                                   //  センター通知
    $('#notification_count').text(data);
    $("#notifications").prepend(msg);
    $("#notification_count").fadeIn("slow");
  };

  dispatcher.bind("notification_event", function(data){
    switch (data['category']) {			                                                       	//  新着の種類によってトースター&通知センター表示
      case 1:
        var toaster_msg = '<img alt="いいね" src="/assets/notification_heart-4f7981b3b98081be7933181924c19c95fc26d3287fa2201f70b546cb032170bd.png" width="30" height="30" />あなたの記事が<strong>いいね！</strong>されました';
        var center_msg = "<div class='notification-false notification-content'>あなたの記事がいいね！されました </br>"+"『"+data['article_title']+"』<div>";
        var info = "like-info"
      break;
      case 2:
        var toaster_msg = '<img alt="いいね" src="/assets/notification_heart-4f7981b3b98081be7933181924c19c95fc26d3287fa2201f70b546cb032170bd.png" width="30" height="30" />あなたの記事が<strong>'+data['content']+'いいね！</strong>獲得しました';
        var center_msg = "<div class='notification-false notification-content'>あなたの記事が"+data['content']+'回いいね！されました </br>『'+data['article_title']+"』<div>";
        var info = "like-info"
      break;
      case 3:
        var toaster_msg = '<img alt="いいね" src="/assets/notification_heart-4f7981b3b98081be7933181924c19c95fc26d3287fa2201f70b546cb032170bd.png" width="30" height="30" /><strong>総いいね！数'+data['content']+'回</strong>を達成しました';
        var center_msg = "<div class='notification-false notification-content'>総獲得いいね！数"+data['content']+"回を達成しました！";
        var info = "like-info"
      break;
      case 4:
        var toaster_msg = '<img alt="閲覧" src="/assets/notification_view-dcb2f6517f5428233cbca3ca31f008b560c64d521f1aad5615133c22e444f5f4.png" width="30" height="30" />あなたの記事が'+data['content']+'回<strong>閲覧</strong>されました';
        var center_msg = "<div class='notification-false notification-content'>あなたの記事が"+data['content']+'回閲覧されました </br>『'+data['article_title']+"』<div>";
        var info = "view-info"
      break;
      case 5:
        var toaster_msg = '<img alt="閲覧" src="/assets/notification_view-dcb2f6517f5428233cbca3ca31f008b560c64d521f1aad5615133c22e444f5f4.png" width="30" height="30" /><strong>総View数</strong>'+data['content']+'回を達成しました';
        var center_msg = "<div class='notification-false notification-content'>総閲覧数"+data['content']+"回を達成しました！<div>";
        var info = "view-info"
      break;
    }
      
  	note_center(center_msg, data['notification_counts']);										       //  センター通知
    toaster(info, toaster_msg);                                                    //  トースター通知
     
  });
  
  $(function(){
//    
  	$(document).on('click touchend', function(e) {			//クリックしたら通知領域が隠れる
	  	if (!$(e.target).closest('#notificationContainer').length) {
	  		$("#notificationContainer").hide();
	  	}
	  });

  	var num = 0;
  	$('#notificationLink').on('click', function(){
  		$.ajax({											        	        	//いいね！されたカウント数をリセット
            url: "../notifications/flag_off",
            type: "GET",
        });
      $("#notificationContainer").fadeToggle(300);
  		$("#notification_count").fadeOut("slow");
        $(this).data("click", ++num); 					    		//通知センターを偶数回押したら新着通知がホワイトアウト
        var click = $(this).data("click");
        if(click%2==0){
        	$(".notification-false").removeClass("notification-false").addClass("notification-true");
        }
  		return false;
    });
  });
