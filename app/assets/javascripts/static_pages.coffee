# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).on "load" , ->
  
  if document.getElementById("s_eyecatch_img").naturalWidth < document.getElementById("s_eyecatch_img").naturalHeight
    $("#s_eyecatch_img").css("height":"auto","width":"100%")
  $("#s_article_thumbnail").show()

red=0
priorityStyle = 'none'
idNum = 0
cccc=0
#ls=[]
jam=[]
#regsd=new RegExp('^user_addresses_attributes_([0-9]+)_zipcode$')

  
$(document).on 'ready page:load', ->
  #console.log("どくめんｔ")
  if document.getElementById("s_eyecatch_img").naturalWidth < document.getElementById("s_eyecatch_img").naturalHeight
    $("#s_eyecatch_img").css("height":"auto","width":"100%")
  $("#s_article_thumbnail").show()
