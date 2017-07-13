$ ->
 idNum=0
 aaaa=1
 cccc=0
 red=0
 maxf=0

 $('div.article_content h2').each ->
  $(this).find(".ranking-icon").text(aaaa)
  aaaa++

 $('div.article_content h2').each ->
  if $("#checkAgree").text() == "true"
   #$('div.article_content h2').each ->
   aaaa--
   $(this).find(".ranking-icon").text(aaaa)


