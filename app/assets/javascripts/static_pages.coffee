# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
arth=0
#$(document).on ".date-picker" , ->
#        datetimepicker(pickTime: false)
$(window).on "load" , ->
 #$("div.s_article_thumbnail").each ->
    #arth++
    #console.log("arth"+arth)
    #if document.getElementById("s_eyecatch_img:nth-child("+arth+")").width() > document.getElementById("s_eyecatch_img:nth-child("+arth+")").height()
    #thisimg = $(this)
    #console.log(thisimg.html())
    #thichil = $(this).children().eq(1)
    #console.log("nW"+thichil.naturalheight)
    #if thichil.naturalWidth < thichil.naturalHeight
       #console.log("ifarth")
    #   thichil.css("height":"auto","width":"100%")
       #$("#s_eyecatch_img:nth-child("+arth+")").css("height":"auto","width":"100%")

    $(".s_article_thumbnail").css("display":"")  
  #if document.getElementById("s_eyecatch_img").naturalWidth() < document.getElementById("s_eyecatch_img").naturalHeight()
  #  $("#s_eyecatch_img").css("height":"auto","width":"100%")
  #$("#s_article_thumbnail").show()

#red=0
#priorityStyle = 'none'
#idNum = 0
#cccc=0
#ls=[]
#jam=[]
#regsd=new RegExp('^user_addresses_attributes_([0-9]+)_zipcode$')

  
$(document).on 'ready page:load', ->
  
  console.log("どくめんｔ")
  $("div.s_article_thumbnail").each ->
   #if document.getElementsByClassName("s_eyecatch_img").naturalWidth < document.getElementsByClassName("s_eyecatch_img").naturalHeight

   #$(".s_eyecatch_img").css("height":"auto","width":"100%")
   #$(".s_article_thumbnail").show()
