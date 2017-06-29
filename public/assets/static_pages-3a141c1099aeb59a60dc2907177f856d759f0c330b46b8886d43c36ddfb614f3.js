(function() {
  var arth;

  arth = 0;

  $(window).on("load", function() {
    return $(".s_article_thumbnail").css({
      "display": ""
    });
  });

  $(document).on('ready page:load', function() {
    console.log("どくめんｔ");
    return $("div.s_article_thumbnail").each(function() {});
  });

}).call(this);
