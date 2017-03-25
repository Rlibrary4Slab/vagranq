  $(function(){
      $.each($(".js-socialActionArea").find("li"), function(index, target){
      getSocialCount(target);
    });

    function getSocialCount(target){
      var provider = $(target).attr("class");
      var url = $(target).data('url');
      $.ajax({
        method: "get",
        url: "/api/get_social_count?url="+url+"&provider="+provider
      }).done(function(data,status){
        $("<span class='top-social-count'>"+data.count+"</span>").appendTo($(target));
      });
    }