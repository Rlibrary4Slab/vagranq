(function() {
  $(window).on("load", function() {
    var aaaa, cccc, idNum, maxf, red;
    idNum = 0;
    aaaa = 1;
    cccc = 0;
    red = 0;
    maxf = 0;
    $('div.article_content h2').each(function() {
      $(this).find(".ranking-icon").text(aaaa);
      return aaaa++;
    });
    return $('div.article_content h2').each(function() {
      if ($("#checkAgree").text() === "true") {
        aaaa--;
        return $(this).find(".ranking-icon").text(aaaa);
      }
    });
  });

}).call(this);
