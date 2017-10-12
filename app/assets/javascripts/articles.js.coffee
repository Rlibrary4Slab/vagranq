# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  
aaaa=0
linkman=0
arth=0
arlt=0
jihi="" 
regz=new RegExp('^cke_article_contents_attributes_([0-9+]+)_description$')
regst=new RegExp('^article_contents_attributes_([0-9+]+)_title$')
regz2=new RegExp('^article_contents_attributes_([0-9+]+)_description$')
reglink=new RegExp('^http:\/\/192.168.33.10:3000\/articles\/([0-9+]+)$')

$(document).on(
  "mouseenter" : -> 
   document.getElementById("tansubmit").click()
   document.getElementById("dansubmit").click()
   if $(this).parents(".ckeditors").find("textarea").attr("id") != undefined
    imgidbe = $(this).parents(".ckeditors").find("textarea").attr("id") 
    imgidaf = imgidbe.replace("article_contents_attributes_","").replace("_description","")
    $("#mouseOverSum").val(Number(imgidaf)+1)
   else
    $("#mouseOverSum").val("0")
  ,"mouseleave" : ->
   $("#mouseOverSumOff").val($("#mouseOverSum").val())
  ,"div.cke_ltr"
)
  

$(window).on "beforeunload", ->
  if $("#csubmit").length ==1
   return "このページから離れると入力が無効になります"
$(document).on 'submit', ->
   $(window).off 'beforeunload'
$(document).on "onload" ,->
  CKEDITOR.replaceAll("ckeditor")
  $('div p a[class="jihi"]').each ->
    $(this).html("ork")
    $(this).hide()
    attrlink = $(this).attr("href")
    $("#getattrlink").val(attrlink)


  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
        aaaa=z[1]
  $('p img').css({"height":"auto","width":"auto"})
  $("div.s_article_thumbnail").each ->
    arth++
    thichil = $(this).children().eq(1)
    if thichil.naturalWidth < thichil.naturalHeight
       thichil.css("height":"auto","width":"100%")

    $(".s_article_thumbnail").css("display":"")
  $('#spsubmit').click()
  if $("#csubmit").length ==1 
   document.getElementById("csubmit").click() 
  if $("#showsubmit").length ==1
   document.getElementById("showsubmit").click() 
  
red=0
priorityStyle = 'none'
idNum = 0
cccc=0
ls=[]
jam=[]

  


$(document).on 'ready page:load', ->
  $("p img").css("height":"","width":"")

  $('div p a[class="jihi"]').each ->
    $(this).html("ork")
    $(this).hide()
    attrlink = $(this).attr("href")
    $("#getattrlink").val(attrlink)

  $(".s_article_thumbnail").css("display":"")
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      aaaa=z[1]
  $('#spsubmit').click()
  $('#spsubmit').click()

  
$(document).on "click", '#spsubmit',->
  $(".psubmit").click()
  $(".pdsubmit").click()
  

$(document).on 'click', '.remove_fields', (event) ->
  $(this).parents("fieldset").find('._destroy').val('1')
  $(this).closest('li').hide()
  $(".add_fields").css("display","");
  document.getElementById("tansubmit").click()
  document.getElementById("dansubmit").click()
  event.preventDefault()

$(document).on 'click', '.add_fieldsl', (event) ->
 
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  CKEDITOR.replaceAll("ckeditor")
  document.getElementById("tansubmit").click()
  document.getElementById("dansubmit").click()
  document.getElementById("dansubmit").click()
  document.getElementById("tansubmit").click()
  $(this).parents("ul").find("li").last().find("fieldset").find(".toplinkmove").click()
  
  event.preventDefault()
  
$(document).on 'click', '.add_fieldsf', (event) ->
 
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).after($(this).data('fields').replace(regexp, time))
  CKEDITOR.replaceAll("ckeditor")
  document.getElementById("tansubmit").click()
  document.getElementById("dansubmit").click()
  document.getElementById("dansubmit").click()
  document.getElementById("tansubmit").click()
  $(this).parents("ul").find("li").first().find("fieldset").find(".toplinkmove").click()

    
  event.preventDefault()

  ###################
    #テキストエディタ閉じ内容を移設
  ####################

$(document).on "click" ,".pdsubmit", -> 
   divf = $(this).parents(".description_field").find(".field")
   divf.css("display","none")
   salf = $(this).parents(".description_field").find(".field").find(".form-control").val()
   $(this).parents(".description_field").find(".afsubmits").css("display","")
   $(this).parents(".description_field").find(".pdsubmit").css("display","none")
   $(this).parents(".description_field").find(".esubmit").css("display","")

   cabf=$(this).parents(".description_field").find(".field").find(".cke_ltr").first().find(".cke_inner").find(".cke_contents").find(".cke_wysiwyg_frame").contents().find("html body")
   jjjf=cabf.html()
   if salf != ""
    $(this).parents(".description_field").find(".afsubmits").find(".afd").html(salf)
    $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf)
   else
    $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf)

#新しく所説明専用のクラスを作る
$(document).on "click" ,".psubmit", ->   
  divs = $(this).parents("fieldset").find(".ckeditors")
  sall = $(this).parents("fieldset").find(".ckeditors").find(".form-control").last().val()
  divs.css("display","none")
  $(this).parents("fieldset").find(".afsubmits").css("display","")
  $(this).parents("fieldset").find(".psubmit").css("display","none")
  $(this).parents("fieldset").find(".esubmit").css("display","")

  cabt=$(this).parents("fieldset").find(".ckeditors").find(".form-control").first().val()
  
  cabd=$(this).parents("fieldset").find(".ckeditors").find(".cke_ltr").first().find(".cke_inner").find(".cke_contents").find(".cke_wysiwyg_frame").contents().find("html body")

   
  iii=cabt
  jjj=cabd.html()

  $(this).parents("fieldset").find(".toplinkmove").click()
  $(this).parents("fieldset").find(".afsubmits").find(".aft").html('<span class="ranking-icon"></span>'+iii)
  $(this).parents("fieldset").find(".afsubmits").find(".afd").html(jjj)
  if sall != ""
    $(this).parents("fieldset").find(".afsubmits").find(".afd").html(sall)
  else  
    $(this).parents("fieldset").find(".afsubmits").find(".afd").html(jjj)


  $(this).parents("fieldset").find(".toplinkmove").click()


$(document).on "click","a[href^=#].toplinkmove", ->
    target = $(this)
    if !target.length
     return 
    # 移動先となる値
    targetY = target.offset().top
    # スクロールアニメーション
    $('html,body').animate({scrollTop: targetY}, 300, 'swing')
    # ハッシュ書き換えとく
    #window.history.pushState(null, null, this.hash)
    # デフォルトの処理はキャンセル
    false

$(document).on "click",".esubmit",->
  $(this).parents("fieldset").find(".ckeditors").find(".form-control").last().val("")
  $(this).parents(".description_field").find(".field").find(".form-control").val()

  $(this).parents(".description_field").find(".pdsubmit").css("display","")
  $(this).parents("fieldset").find(".ckeditors").css("display","")
  $(this).parents("fieldset").find(".afsubmits").css("display","none")
  $(this).parents("fieldset").find(".psubmit").css("display","")
  $(this).parents("fieldset").find(".esubmit").css("display","none")
  $(this).parents(".description_field").find(".field").css("display","")
  $(this).parents(".description_field").find(".afsubmits").css("display","none")
  $(this).parents(".description_field").find(".psubmit").css("display","")
  $(this).parents(".description_field").find(".esubmit").css("display","none")

  $(this).parents("fieldset").find(".toplinkmove").click()

tsubmit=0  

############################################################################################################################
#  input[class=cke_dialog_ui_input_text]'                                                     画像処理
############################################################################################################################

  
    
$(document).on 'click' ,-> #clicked
  if $("#csubmit").length ==1 
   document.getElementById("csubmit").click()  
  $(".pup").css("display":"initial")
  $(".pdown").css("display":"initial")
  $("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").css("display":"none")
  $("input#article_contents_attributes_"+aaaa+"_title").parents("fieldset").find(".pdown").css("display":"none")
  if $("#csubmit").length !=1
   $('div p a[class="jihi"]').each ->
    athis = $(this)
    $(this).hide()
    attrlink = $(this).attr("href")
    $("#getattrlink").val(attrlink)
     
      

   
  $('div.ImagePreviewBox table tbody tr td a img').css({"height":"100%","width":"100%"})
  #if $("#user_name").length <1 
  #else
  # if $("#user_user_image").length <1 
  #  dsds=$("#user_name").val()
  #  $("#user_user_name").val(dsds).change() 
   
  if $("#csubmit").length==1   
   $('p img').css({"height":"28.2%","width":"100%"})

  if $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val() != ""  
    $('p img').css({"height":"auto","width":"auto"})
    $('.cke_dialog_ui_button_ok').css("display":"")

  $(".pup").css("display":"initial")
  $(".pdown").css("display":"initial")
  $("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").css("display":"none")
  $("input#article_contents_attributes_"+titz+"_title").parents("fieldset").find(".pdown").css("display":"none")
   
  eyeimg= $("div div div iframe").contents().find("html body p img")
  ym=eyeimg.first().prop("src")
  ymval=$("#eyecatch_img").prop("value")
  if ym != undefined
    $("#eyecatch_img").val(ym) 
  else if ymval != undefined
    $("#eyecatch_img").val(ymval)
     
  else
    
    $("#eyecatch_img").val('l_e_others_500.png')
$(document).on 'click', '.cke_btn_reset' ,->
  
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:nth-child(2) td div table tbody tr td div div div input').val("")
    
    
    $('img').css({"height":"28.2%","width":"100%"})
    
  

$(document).on 'click','.cke_button__image',->
  iurtmp =$(this).parents('div').children().eq(3).attr('id')
  
  $("#iurtmp").val(iurtmp.replace("_arialbl",""))
  $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val("")
  $("body div.cke_reset_all").css("display":"")
  
  
  
$(document).on 'click','.cke_dialog_ui_button_ok',->
  $('.cke_btn_reset').remove()
  

############################################################################################################################
#                                                       //画像処理
############################################################################################################################  
$(document).on "click", ".tdsubmit", ->
   if $("#checkAgree").prop("checked") == true
    $("#checkAgree").prop("checked",false)  
   else if $("#checkAgree").prop("checked") == false
    $("#checkAgree").prop("checked",true)
   
   document.getElementById("tsubmit").click()  
   document.getElementById("dsubmit").click()  
   document.getElementById("tansubmit").click()  
   document.getElementById("dansubmit").click()  

$(document).on "click","#tansubmit", ->    
   idNum=0
   aaaa=0
   cccc=0
   dddd=0
   red=0
   maxf=0
   $('li fieldset div input').each ->
        if z=$(this).prop('id').match(regst)
          $this = $(this)
          $parentDiv = $this.parents('li')
          aaaa=z[1]
          if $parentDiv.css('display') == priorityStyle
               red++
               $this.removeAttr("id")
               return true #これで、除外したいやつから抜らけれる
    
          $this.attr({id: "article_contents_attributes_"+idNum+"_title"})
          $this.attr({name: "article[contents_attributes]["+idNum+"][title]"})
          $parentDiv.find(".afsubmits").find(".aft").attr({id: "article_contents_attributes_"+idNum+"_title"})
          idNum++
          aaaa=z[1]
    
   $('li fieldset div input').each ->
         if z=$(this).prop('id').match(regst)
           $this = $(this)
           $parentDiv = $this.parents('fieldset')
           aaaa=z[1]
           $(".add_fieldsf").css("display","")
           if aaaa == "0"
            $(".add_fieldsf").css("display","none")
           if aaaa == "99"
            $(".add_fields").css("display","none")
$(document).on "click","#dansubmit", ->
  idNum=0
  aaaa=0
  cccc=0
  dddd=0
  red=0
  maxf=0
  $('li fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる

      $this.attr({id: "cke_article_contents_attributes_"+idNum+"_description"})
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      idNum++

      aaaa=z[1]

  $('li fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
  idNum=0
  $('li fieldset div textarea').each ->
    if z=$(this).prop('id').match(regz2)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる

      $this.attr({id: "article_contents_attributes_"+idNum+"_description"})
      $this.attr({name: "article[contents_attributes]["+idNum+"][description]"})
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      idNum++

      aaaa=z[1]

  $('li fieldset div textarea').each ->
    if z=$(this).prop('id').match(regz2)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
$(document).on "click", ".pup", ->
  
  document.getElementById("dansubmit").click()
  inpup=$(this).parents('fieldset').children().find("textarea").attr("id")
  idNum=0
  rep1 = inpup.replace("_description","")
  rep2 = rep1.replace("article_contents_attributes_","")
  cccc=0
  dddd=0
  red=0
  maxf=0
  rept11=$("input#article_contents_attributes_"+rep2+"_title").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
  rept12=$("input#article_contents_attributes_"+(rep2-1)+"_title").val()
  $("input#article_contents_attributes_"+rep2+"_title").val(rept12)
  $("h2#article_contents_attributes_"+rep2+"_title").html('<span class="ranking-icon"></span>'+rept12)
  $("input#article_contents_attributes_"+(rep2-1)+"_title").val(rept11)
  $("h2#article_contents_attributes_"+(rep2-1)+"_title").html('<span class="ranking-icon"></span>'+rept11)
 
  lab1=$("fieldset div#cke_article_contents_attributes_"+rep2+"_description div div iframe").contents().find("html body") #HTML場所取得
  jam1=lab1.html()
  tmp1=jam1
  
  lab2=$("fieldset div#cke_article_contents_attributes_"+(rep2-1)+"_description div div iframe").contents().find("html body") #HTML場所取得
  jam2=lab2.html()
  tmp2=jam2
  
  kml1=$("fieldset div#cke_article_contents_attributes_"+rep2+"_description div div iframe").contents().find("html body")
  kml1.html(tmp2)
  $("div#article_contents_attributes_"+rep2+"_description").html(tmp2)
  
  kml2=$("fieldset div#cke_article_contents_attributes_"+(rep2-1)+"_description div div iframe").contents().find("html body")
  kml2.html(tmp1)
  $("div#article_contents_attributes_"+(rep2-1)+"_description").html(tmp1)

$(document).on "click", ".pdown", ->
  document.getElementById("dansubmit").click()
  inpup=$(this).parents('fieldset').children().find("textarea").attr("id")
  idNum=0
  rep1 = inpup.replace("_description","")
  rep2 = rep1.replace("article_contents_attributes_","")
  cccc=0
  dddd=0
  red=0
  maxf=0
  rept11=$("input#article_contents_attributes_"+rep2+"_title").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
  rept12=$("input#article_contents_attributes_"+(Number(rep2)+1)+"_title").val()
  
  $("input#article_contents_attributes_"+rep2+"_title").val(rept12)
  $("h2#article_contents_attributes_"+rep2+"_title").html('<span class="ranking-icon"></span>'+rept12)
  $("input#article_contents_attributes_"+(Number(rep2)+1)+"_title").val(rept11)
  $("h2#article_contents_attributes_"+(Number(rep2)+1)+"_title").html('<span class="ranking-icon"></span>'+rept11)

  #description
  lab1=$("fieldset div#cke_article_contents_attributes_"+rep2+"_description div div iframe").contents().find("html body") #HTML場所取得
  jam1=lab1.html()
  tmp1=jam1

  lab2=$("fieldset div#cke_article_contents_attributes_"+(Number(rep2)+1)+"_description div div iframe").contents().find("html body") #HTML場所取得
  jam2=lab2.html()
  tmp2=jam2

  kml1=$("fieldset div#cke_article_contents_attributes_"+rep2+"_description div div iframe").contents().find("html body")
  kml1.html(tmp2)
  $("div#article_contents_attributes_"+rep2+"_description").html(tmp2)
  kml2=$("fieldset div#cke_article_contents_attributes_"+(Number(rep2)+1)+"_description div div iframe").contents().find("html body")
  kml2.html(tmp1)
  $("div#article_contents_attributes_"+(Number(rep2)+1)+"_description").html(tmp1)
titz =0
$(document).on "click", "#csubmit", ->
  
  
  idNum=0
  aaaa=0
  cccc=0
  red=0
  maxf=0
  
  $('fieldset div input').each ->
     if z=$(this).prop('id').match(regst)
      titz=z[1]
       
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる

      $parentDiv.find(".afsubmits").find(".aft").attr({id: "article_contents_attributes_"+idNum+"_title"})
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      red = Number(titz)+1
      $parentDiv.find(".ckeditors").find(".ranking-icon").text(red)
      $parentDiv.find(".afsubmits").find(".aft").find(".ranking-icon").text(red)
      idNum++
      #aaaa=z[1]
  $(".add_fieldsf").css("display","")
  if red == 0
   $(".add_fieldsf").css("display","none")
  if $("#checkAgree").prop("checked") == true
    $('fieldset div input').each ->
     if z=$(this).prop('id').match(regst)
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      $parentDiv.find(".ckeditors").find(".ranking-icon").text(red)
      $parentDiv.find(".afsubmits").find(".aft").find(".ranking-icon").text(red)
      red--
$(document).on "click", "#showsubmit", ->


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
    aaaa--
    $(this).find(".ranking-icon").text(aaaa)   

$(document).on "click", "#tsubmit", ->

  idNum=0
  aaaa=0
  cccc=0
  dddd=0
  red=0
  maxf=0
  $('li fieldset div input').each ->
    if z=$(this).prop('id').match(regst)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる
          
      $this.attr({id: "article_contents_attributes_"+idNum+"_title"})
      $this.attr({name: "article[contents_attributes]["+idNum+"][title]"})
      $parentDiv.find(".afsubmits").find(".aft").attr({id: "article_contents_attributes_"+idNum+"_title"})
      idNum++
      aaaa=z[1]
      
  $('li fieldset div').each ->
    if z=$(this).prop('id').match(regst)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる
          
     
      aaaa=z[1]
  for i in [0..aaaa]
    if i==0
     tmp=ls[i]
    ls[i]=$("input#article_contents_attributes_"+i+"_title").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
        
  for j in [0..aaaa]
   
    if j==aaaa
     $("input#article_contents_attributes_"+j+"_title").val(tmp)
     $("h2#article_contents_attributes_"+j+"_title").html('<span class="ranking-icon"></span>'+tmp)
    else
     $("input#article_contents_attributes_"+j+"_title").val(ls[aaaa-j]) #name0.val(ls3) name1.val(ls2) name2.val(ls1) name3.val(ls0)
     $("h2#article_contents_attributes_"+j+"_title").html('<span class="ranking-icon"></span>'+ls[aaaa-j])
    
        
$(document).on "click", "#dsubmit", ->

  idNum=0
  aaaa=0
  cccc=0
  dddd=0
  red=0
  maxf=0
  $('li fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる
          
      $this.attr({id: "cke_article_contents_attributes_"+idNum+"_description"})
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      idNum++
      
      aaaa=z[1]
      
  $('li fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      $this = $(this)
      $parentDiv = $this.parents('li')
      aaaa=z[1]
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          return true #これで、除外したいやつから抜らけれる
          
     
      aaaa=z[1]
  for i in [0..aaaa]
    lab=$("fieldset div#cke_article_contents_attributes_"+i+"_description div div iframe").contents().find("html body") #HTML場所取得
    if i==0
     jam[0]=lab.html()
     tmp=jam[0]
    
    jam[i]=lab.html() #こいつに取得した場所の内容を格納
    
    
  kml=[]
  for j in [0..aaaa]
    kml[j]=$("fieldset div#cke_article_contents_attributes_"+j+"_description div div iframe").contents().find("html body")
    if j==aaaa
      kml[j].html(tmp)
      $("div#article_contents_attributes_"+j+"_description").html(tmp)
    else
        
      kml[j].html(jam[aaaa-j])
      $("div#article_contents_attributes_"+j+"_description").html(jam[aaaa-j])
  #descriptionendd#
  
  
$ ->

  $("#shops .page").infinitescroll
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif"
        msgText: "ロード中..."
      }
      navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
      nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
      itemSelector: "#shops tr.shop" # selector for all items you'll retrieve
  
  replace_tag_inner = (tag,str) ->
    result = tag
    selected_str = editor.getSelection
    # エディタ内で選択中の文字列が存在する場合
    if selected_str && selected_str.getNative != '' 
      result = result.replace(str, selected_str.getNative)
    
    return result
  
  #$(".sortable").sortable
  #  axis: 'y',
  #  items: '.fields',
  #  update: (e, ui) ->
      # ドラッグ&ドロップしたら各entryのhidden_fieldに現在の位置を入れる
  #    $('.position').each ->
  #      $(this).val($('.position').index($(this)) + 1)
  
  new ImageCropper()
  
class ImageCropper
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update
      #allowResize: true
		  #allowSelect: false
      
  update: (coords) =>
    $("#user_crop_x").val(coords.x)
    $("#user_crop_y").val(coords.y)
    $("#user_crop_w").val(coords.w)
    $("#user_crop_h").val(coords.h)
    @updatePreview(coords)
  
  updatePreview: (coords) =>
    $("#preview").css
      width: Math.round(100/coords.w * $("#cropbox").width()) + "px"
      height: Math.round(100/coords.h * $("#cropbox").height()) + "px"
      marginLeft: "-" + Math.round(100/coords.w * coords.x) + "px"
      marginTop: "-" + Math.round(100/coords.h *coords.y) + "px"


  
    
 

