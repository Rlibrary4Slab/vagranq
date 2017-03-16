# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  
aaaa=0

arth=0
arlt=0 
#priority = "none"
#regz=new RegExp('^cke_article_contents_attributes_([0-9+])_description$')
regz=new RegExp('^cke_article_contents_attributes_([0-9+]+)_description$')
#regst=new RegExp('^article_contents_attributes_([0-9+])_title$')
regst=new RegExp('^article_contents_attributes_([0-9+]+)_title$')
regz2=new RegExp('^article_contents_attributes_([0-9+]+)_description$')
$(window).on "load" , ->
  CKEDITOR.replaceAll("ckeditor")
  console.log("load") 
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
        ##console.log(z[1]+":"+$(this).val()) 
        aaaa=z[1]
  console.log("ロード="+aaaa)
  $('p img').css({"height":"auto","width":"auto"})
  #$('p img').css({"height":"28.2%","width":"100%"})
  $("div.s_article_thumbnail").each ->
    arth++
    console.log("arth"+arth)
    #if document.getElementById("s_eyecatch_img:nth-child("+arth+")").width() > document.getElementById("s_eyecatch_img:nth-child("+arth+")").height()
    thisimg = $(this)
    #console.log(thisimg.html())
    thichil = $(this).children().eq(1)
    console.log("nW"+thichil.naturalheight)
    if thichil.naturalWidth < thichil.naturalHeight
       #console.log("ifarth")
       thichil.css("height":"auto","width":"100%")
       #$("#s_eyecatch_img:nth-child("+arth+")").css("height":"auto","width":"100%")

    $(".s_article_thumbnail").css("display":"")
  #console.log($("#article_title").val())  
  #if $("#article_title").val() != null
  $('#spsubmit').click()
  if $("#csubmit").length ==1 
   console.log("csubmit")
   document.getElementById("csubmit").click() 
  #iButton++
  if $("#showsubmit").length ==1
   console.log("showsub")
   document.getElementById("showsubmit").click() 
red=0
priorityStyle = 'none'
idNum = 0
cccc=0
ls=[]
jam=[]
#regsd=new RegExp('^user_addresses_attributes_([0-9]+)_zipcode$')

  
$(document).on 'ready page:load', ->
  $("p img").css("height":"","width":"")

  console.log("どくめんｔ"+arth)
  #if document.getElementById("s_eyecatch_img").naturalWidth() < document.getElementById("s_eyecatch_img").naturalHeight()
  #  $(".s_eyecatch_img").css("height":"auto","width":"100%")
  $(".s_article_thumbnail").css("display":"")
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      ##console.log(z[1]+":"+$(this).val()) 
      aaaa=z[1]
      #console.log("ロード="+aaaa)
  $('#spsubmit').click()
  #$('form').on "click", ->
  #  dsds=$("#user_name").val()
    #console.log(dsds)
  #  $("#user_user_name").val(dsds).change()  
  #  return
  $("div.s_article_thumbnail").each ->
    #arth++
    #console.log("arth"+arth)
    #if document.getElementById("s_eyecatch_img:nth-child("+arth+")").width < document.getElementById("s_eyecatch_img:nth-child("+arth+")").height
     # $("#s_eyecatch_img:nth-child("+arth+")").css("height":"auto","width":"100%")
    #$(".s_article_thumbnail").css("display":"")
  console.log($("#article_title").val())
  #if $("#article_title").val() != null
  $('#spsubmit').click()

#$('')
  
$(document).on "click", '#spsubmit',->
  $(".psubmit").click()

$(document).on 'click', '.remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  #$(this).closest('fieldset').hide()
  $(this).closest('li').remove()
  $(".add_fields").css("display","");
  document.getElementById("tansubmit").click()
  console.log("removed="+aaaa)
  console.log("twice="+aaaa)
  event.preventDefault()

$(document).on 'click', '.add_fields', (event) ->
 
  time = new Date().getTime()
  #document.getElementById("tansubmit").click()
  #document.getElementById("dansubmit").click()
  #document.getElementById("dansubmit").click()
  #document.getElementById("tansubmit").click()
  #$('fieldset div input').each ->
  #('fieldset input[type=text]').each ->
    #console.log("field")   
    #if z=$(this).prop('name').match(regst)
    #if z=$(this).prop('id').match(regst)
    #  console.log("2name"+z[1]+":"+$(this).val()) 
      #aaaa=z[1]
  #console.log("aaaa=z[1]"+aaaa)
  #aaaa++ 
  console.log("addfielud:"+aaaa) 
  regexp = new RegExp($(this).data('id'), 'g')
  #$(this).before($(this).data('fields').replace(regexp, parseInt(aaaa)+1))
  $(this).before($(this).data('fields').replace(regexp, time))
  CKEDITOR.replaceAll("ckeditor")
  document.getElementById("tansubmit").click()
  document.getElementById("dansubmit").click()
  document.getElementById("dansubmit").click()
  document.getElementById("tansubmit").click()
  $(this).parents("ul").find("li").last().find("fieldset").find(".toplinkmove").click()
  #CKEDITOR.replaceAll("ckeditor")
  
  event.preventDefault()
  
  ###################
    #テキストエディタ閉じ内容を移設
  ####################
#$("#titem").click ->
#  #console.log("ttiwt")
#  #$('fieldset div#cke_article_contents_attributes_0_description div div iframe').contents().find("html body").css("background":"gray")
#  sand=$('fieldset div#cke_article_contents_attributes_0_description div div iframe').contents().find("html body").html()
#  #$("iframe").contents().find("html body").css("background":"gray")
#  #$("iframe #document html").contents().css("background":"gray")
#  $('.cke_editable').css("background","green")
#  $(".t1").html(sand) 

$(document).on "click" ,".pdsubmit", -> 
   divf = $(this).parents(".description_field").find(".field")
   divf.css("display","none")

   $(this).parents(".description_field").find(".afsubmits").css("display","")
   $(this).parents(".description_field").find(".pdsubmit").css("display","none")
   $(this).parents(".description_field").find(".esubmit").css("display","")

   cabf=$(this).parents(".description_field").find(".field").find(".cke_ltr").first().find(".cke_inner").find(".cke_contents").find(".cke_wysiwyg_frame").contents().find("html body")
   jjjf=cabf.html()
   $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf)
   if salf != ""
    $(this).parents(".description_field").find(".afsubmits").find(".afd").html(salf)
   else
    $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf)
   
#新しく所説明専用のクラスを作る
$(document).on "click" ,".psubmit", ->   
  #console.log("ckssd")
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
 # document.getElementById("csubmit").click()
  #$(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf)
  #if salf != ""
  #  $(this).parents(".description_field").find(".afsubmits").find(".afd").html(salf)
  #else  
  #  $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf)


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
  #$(".afsubmits").css("display","none")
  #$(".ckeditors").css("display","")
  #$(this).parents("fieldset").find(".tdsubmit").css("display","")
  $(this).parents("fieldset").find(".ckeditors").css("display","")
  $(this).parents("fieldset").find(".afsubmits").css("display","none")
  $(this).parents("fieldset").find(".psubmit").css("display","")
  $(this).parents("fieldset").find(".esubmit").css("display","none")
  $(this).parents(".description_field").find(".field").css("display","")
  $(this).parents(".description_field").find(".afsubmits").css("display","none")
  $(this).parents(".description_field").find(".psubmit").css("display","")
  $(this).parents(".description_field").find(".esubmit").css("display","none")
#0202

  $(this).parents("fieldset").find(".toplinkmove").click()
   #alert(sd)

tsubmit=0  

############################################################################################################################
#  input[class=cke_dialog_ui_input_text]'                                                     画像処理
############################################################################################################################

  
    

    

$(document).on 'click' ,-> #clicked
  #document.getElementsByClassName("tdsubmit")[0].click() 
  if $("#csubmit").length ==1 
   console.log("csubmit")
   document.getElementById("csubmit").click()  
  console.log("befaa:"+titz)
  $(".pup").css("display":"initial")
  $(".pdown").css("display":"initial")
  $("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").css("display":"none")
  $("input#article_contents_attributes_"+aaaa+"_title").parents("fieldset").find(".pdown").css("display":"none")


  
  $('div.ImagePreviewBox table tbody tr td a img').css({"height":"100%","width":"100%"})
  if $("#user_name").length <1 
  else
    dsds=$("#user_name").val()
    $("#user_user_name").val(dsds).change() 
  if $("#csubmit").length==1   
   $('p img').css({"height":"28.2%","width":"100%"})

  if $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val() != ""  
    $('p img').css({"height":"auto","width":"auto"})
    $('.cke_dialog_ui_button_ok').css("display":"")
    #console.log("textinput")
  else
    #$('.cke_dialog_ui_button_ok').css("display":"none")
    #console.log("null")
  #$('p img').css({"height":"28.2%","width":"100%"})
  #$('fieldset div').each ->
    #if z=$(this).prop('id').match(regz)
        ##console.log(z[1]+":"+$(this).val()) 
        #aaaa=z[1]
        #console.log("ロード="+aaaa)
  $(".pup").css("display":"initial")
  $(".pdown").css("display":"initial")
  $("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").css("display":"none")
  $("input#article_contents_attributes_"+titz+"_title").parents("fieldset").find(".pdown").css("display":"none")
  #$('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:nth-child(2) td div table tbody tr td div div div input').val("")
  #$("body div.cke_dialog_background_cover").remove()
  #何かクリックすれば反映される  
  $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input').val("100%")
  $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input').val("100%")
  #$('.cke_btn_reset').click()
   
  eyeimg= $("div div div iframe").contents().find("html body p img")
  ym=eyeimg.first().prop("src")
  #console.log("ym"+ym)
  #yms=$(yal+" p img").prop("src")
  ##console.log("yms"+yms)
  if ym != undefined
    #$("#eyecatch_img").val('<img src="'+ym+'"/>')
    $("#eyecatch_img").val(ym) 
    #ここで画像をな切り取る
    #$("#eyecatch_img").val('<img src="'+ym+'" style="height: 75px; width: 75px;" />')#切り撮った画像を圧縮
  else
    
    $("#eyecatch_img").val('l_e_others_500.png')
$(document).on 'click', '.cke_btn_reset' ,->
  #$('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input
#').val("300")
  #$('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input
#').val("340")
    #$("table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input").val("322") 
    
    #if $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val() != "" 
      
    #  $('.cke_dialog_ui_button_ok').css("display":"")
    #  #console.log("textinput")
    #else
    #  $('.cke_dialog_ui_button_ok').css("display":"none")
    #  #console.log("null")
  
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:nth-child(2) td div table tbody tr td div div div input').val("")
    
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input').val("100%")
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input').val("100%")
    
    $('img').css({"height":"28.2%","width":"100%"})
    
  

$(document).on 'click','.cke_button__image',->
  #alert($(this).parents('div').children().eq(3).attr('id'))
  iurtmp =$(this).parents('div').children().eq(3).attr('id')
  
  $("#iurtmp").val(iurtmp.replace("_arialbl",""))
  #0 span]cke_top1 div]cke_content span]cke_bottom 3 span[contents_arialbl 4
  #cke_article_contents_attributes_1_title_arialbl
  $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val("")
  $("html body").append('<div tabindex="-1" style="position: fixed; z-index: 5000; top: 0px; left: 0px; background-color: white; opacity: 0.5; width: 100%; height: 100%;" class="cke_dialog_background_cover"></div>')
  $("body div.cke_reset_all").css("display":"")
  $('.cke_dialog_footer table tbody tr td a.cke_btn_reset').remove()
  #$('.cke_dialog_ui_button_ok').css("display":"none")
  #$('.cke_btn_reset').remove()　こいつがonメソッドを消すkor
  if $('.cke_dialog_ui_hbox_first').has("a:nth-child(3)")
    $('.cke_dialog_ui_hbox_first').append('<a href="javascript:void(0)" tabindex="-1" title="サイズをリセット" class="cke_btn_reset" id="cke_213_btnResetSize" style="" role="button"><span class="cke_label">サイズをリセット</span></a>')
  else
    ##console.log("a:first-chilid2")              
  $('.cke_dialog_footer table tbody tr td a.cke_btn_reset').remove()
  #$('fieldset div#cke_article_contents_attributes_0_title div div iframe').contents().find("html body").append("<p>"+quote+"<p>"+"<br />")
  
  #lab.value += "adsadsad" 
$(document).on 'click','.cke_dialog_ui_button_cancel',->
  $('.cke_btn_reset').remove()

  $('html body div.cke_reset_all').remove()
  $("body div.cke_dialog_background_cover").remove()
  
  #$('.cke_dialog_ui_hbox_first').append('<a href="javascript:void(0)" tabindex="-1" title="サイズをリセット" class="cke_btn_reset" id="cke_213_btnResetSize" style="" role="button"><span class="cke_label">サイズをリセット</span></a>')      
  $('.cke_dialog_footer table tbody tr td a.cke_btn_reset').remove()
  
$(document).on 'click','.cke_dialog_close_button',->
  $('a.cke_btn_reset').remove()
  $('body div.cke_reset_all').remove()
  
  #$('.cke_dialog_ui_hbox_first').append('<a href="javascript:void(0)" tabindex="-1" title="サイズをリセット" class="cke_btn_reset" id="cke_213_btnResetSize" style="" role="button"><span class="cke_label">サイズをリセット</span></a>')      
  $('.cke_dialog_footer table tbody tr td a.cke_btn_reset').remove()
  $("body div.cke_dialog_background_cover").remove()
  
$(document).on 'click','.cke_dialog_ui_button_ok',->
  $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input').val("100%")
  $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input').val("100%")      
  $("body div.cke_dialog_background_cover").remove()
  $('.cke_btn_reset').remove()
  $('.cke_dialog_footer table tbody tr td a.cke_btn_reset').remove()
  $('html body div.cke_reset_all').remove()
  

############################################################################################################################
#                                                       //画像処理
############################################################################################################################  
$(document).on "click", ".tdsubmit", ->
   if $("#checkAgree").prop("checked") == true
    console.log("teee")
    $("#checkAgree").prop("checked",false)  
   else if $("#checkAgree").prop("checked") == false
    console.log("faa")
    $("#checkAgree").prop("checked",true)
   
   document.getElementById("tsubmit").click()  
   document.getElementById("dsubmit").click()  
   document.getElementById("tansubmit").click()  
   document.getElementById("dansubmit").click()  
$(document).on "click","#tansubmit", ->    
   idNum=0
   #console.log("スイッチ="+aaaa)
   aaaa=0
   ##console.log(ls1+"/"+ls2)
   cccc=0
   dddd=0
   red=0
   maxf=0
   $('fieldset div input').each ->
        if z=$(this).prop('id').match(regst)
          console.log("titz="+z[1])
          ##console.log(z[1]+":"+$(this).val())
          $this = $(this)
          $parentDiv = $this.parents('fieldset')
          aaaa=z[1]
          #console.log("aaaa"+z[1])
          #if $parentDiv.css('display') == priorityStyle
          #     red++
          #     $this.removeAttr("id")
          #     #console.log("ret="+red)
          #     return true #これで、除外したいやつから抜らけれる
    
          #cke_article_contents_attributes_idNum_description
          $this.attr({id: "article_contents_attributes_"+idNum+"_title"})
          #console.log("dancer"+$this.parents("fieldset").find(".afsubmit").find(".aft"))
          $parentDiv.find(".afsubmits").find(".aft").attr({id: "article_contents_attributes_"+idNum+"_title"})
          ##console.log("idNum"+idNum)
          #dddd++
          idNum++
          #console.log("iba")
          aaaa=z[1]
          #console.log("last="+aaaa)
          #console.log("lastid="+idNum)
    
   $('fieldset div input').each ->
         if z=$(this).prop('id').match(regst)
           $this = $(this)
           $parentDiv = $this.parents('fieldset')
           aaaa=z[1]
           console.log("dos"+aaaa)
           if aaaa == "99"
            console.log("disadd")
            $(".add_fields").css("display","none");
$(document).on "click","#dansubmit", ->
  idNum=0
  #console.log("スイッチ="+aaaa)
  aaaa=0
  ##console.log(ls1+"/"+ls2)
  cccc=0
  dddd=0
  red=0
  maxf=0
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      #console.log("z="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
      #console.log("aaaa"+z[1])
      #if $parentDiv.css('display') == priorityStyle
      #    red++
      #    $this.removeAttr("id")
          #console.log("ret="+red)
      #    return true #これで、除外したいやつから抜らけれる

      #cke_article_contents_attributes_idNum_description
      $this.attr({id: "cke_article_contents_attributes_"+idNum+"_description"})
      ##console.log("idNum"+idNum)
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      #dddd++
      idNum++

      aaaa=z[1]
      #console.log("last="+aaaa)
      #console.log("lastid="+idNum)

  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      #console.log("z="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
  idNum=0
  $('fieldset div textarea').each ->
    if z=$(this).prop('id').match(regz2)
      #console.log("z="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
      #console.log("aaaa"+z[1])
      #if $parentDiv.css('display') == priorityStyle
      #    red++
      #    $this.removeAttr("id")
          #console.log("ret="+red)
      #    return true #これで、除外したいやつから抜らけれる

      #cke_article_contents_attributes_idNum_description
      $this.attr({id: "article_contents_attributes_"+idNum+"_description"})
      ##console.log("idNum"+idNum)
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      #dddd++
      idNum++

      aaaa=z[1]
      #console.log("last="+aaaa)
      #console.log("lastid="+idNum)

  $('fieldset div textarea').each ->
    if z=$(this).prop('id').match(regz2)
      #console.log("z="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
$(document).on "click", ".pup", ->
  
  document.getElementById("dansubmit").click()
  console.log("pup")
  inpup=$(this).parents('fieldset').children().find("textarea").attr("id")
  idNum=0
  console.log(inpup)
  rep1 = inpup.replace("_description","")
  rep2 = rep1.replace("article_contents_attributes_","")
  console.log(rep2+"!!rep2")
  #console.log("スイッチ="+aaaa)
  #aaaa=0
  ##console.log(ls1+"/"+ls2)
  cccc=0
  dddd=0
  red=0
  maxf=0
  rept11=$("input#article_contents_attributes_"+rep2+"_title").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
  console.log("rept11"+rept11)
  rept12=$("input#article_contents_attributes_"+(rep2-1)+"_title").val()
  console.log("rept12"+rept12)
  $("input#article_contents_attributes_"+rep2+"_title").val(rept12)
  $("h2#article_contents_attributes_"+rep2+"_title").html('<span class="ranking-icon"></span>'+rept12)
     #console.log("jif"+$("#article_contents_attributes_"+j+"_title").val(tmp))
  $("input#article_contents_attributes_"+(rep2-1)+"_title").val(rept11)
  $("h2#article_contents_attributes_"+(rep2-1)+"_title").html('<span class="ranking-icon"></span>'+rept11)
     #console.log("jif"+$("#article_contents_attributes_"+j+"_title").val(tmp))
 
  #description
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
  console.log("pdown")
  #inpup=$(this).parents('fieldset').children().eq(1).children().children().parents("div").find("input").attr("id")
  inpup=$(this).parents('fieldset').children().find("textarea").attr("id")
  idNum=0
  console.log(inpup)
  rep1 = inpup.replace("_description","")
  rep2 = rep1.replace("article_contents_attributes_","")
  console.log(rep2+"!!rep2")
  #aaaa=0
  cccc=0
  dddd=0
  red=0
  maxf=0
  rept11=$("input#article_contents_attributes_"+rep2+"_title").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
  console.log("rept11"+rept11)
  console.log("rep2+1="+(Number(rep2)+1)) 
  rept12=$("input#article_contents_attributes_"+(Number(rep2)+1)+"_title").val()
  
  console.log("rept12"+rept12)
  $("input#article_contents_attributes_"+rep2+"_title").val(rept12)
  $("h2#article_contents_attributes_"+rep2+"_title").html('<span class="ranking-icon"></span>'+rept12)
     #console.log("jif"+$("#article_contents_attributes_"+j+"_title").val(tmp))
  $("input#article_contents_attributes_"+(Number(rep2)+1)+"_title").val(rept11)
  $("h2#article_contents_attributes_"+(Number(rep2)+1)+"_title").html('<span class="ranking-icon"></span>'+rept11)
     #console.log("jif"+$("#article_contents_attributes_"+j+"_title").val(tmp))

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
     #$(".pup").css("display":"initial")
     #$(".pdown").css("display":"initial")
     #$("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").first().css("display":"none")
     #$("input#article_contents_attributes_"+aaaa+"_title").parents("fieldset").find(".pdown").first().css("display":"none")
     if z=$(this).prop('id').match(regst)
      titz=z[1]
      console.log("titz="+titz)
      
       
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      #aaaa=z[1]
      #console.log("aaaa"+z[1])
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          #console.log("ret="+red)
          return true #これで、除外したいやつから抜らけれる

      #$this.attr({id: "article_contents_attributes_"+idNum+"_title"})
      $parentDiv.find(".afsubmits").find(".aft").attr({id: "article_contents_attributes_"+idNum+"_title"})
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      red = Number(titz)+1
      $parentDiv.find(".ckeditors").find(".ranking-icon").text(red)
      $parentDiv.find(".afsubmits").find(".aft").find(".ranking-icon").text(red)
      idNum++
      #aaaa=z[1]
  console.log("endp"+red)
  if $("#checkAgree").prop("checked") == true
    console.log("teee")
    #$("#checkAgree").prop("checked",false)
    $('fieldset div input').each ->
     if z=$(this).prop('id').match(regst)
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      $parentDiv.find(".ckeditors").find(".ranking-icon").text(red)
      $parentDiv.find(".afsubmits").find(".aft").find(".ranking-icon").text(red)
      red--
  #else if $("#checkAgree").prop("checked") == false
    #console.log("faa")
    #$("#checkAgree").prop("checked",true)
$(document).on "click", "#showsubmit", ->


  idNum=0
  aaaa=1
  cccc=0
  red=0
  maxf=0
 
  $('div.article_content h2').each ->
   $(this).find(".ranking-icon").text(aaaa)   
   console.log("endp"+titz)
   aaaa++
  
  $('div.article_content h2').each ->
   if $("#checkAgree").text() == "true" 
    console.log("teeee"+$(this))
    #$('div.article_content h2').each ->
    aaaa--
    $(this).find(".ranking-icon").text(aaaa)   

$(document).on "click", "#tsubmit", ->

  console.log("ts")
  idNum=0
  #console.log("スイッチ="+aaaa)
  aaaa=0
  ##console.log(ls1+"/"+ls2)
  cccc=0
  dddd=0
  red=0
  maxf=0
  $('fieldset div input').each ->
    if z=$(this).prop('id').match(regst)
      console.log("titz="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
      #console.log("aaaa"+z[1])
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          #console.log("ret="+red)
          return true #これで、除外したいやつから抜らけれる
          
      #cke_article_contents_attributes_idNum_description
      $this.attr({id: "article_contents_attributes_"+idNum+"_title"})
      #console.log("dancer"+$this.parents("fieldset").find(".afsubmit").find(".aft"))
      $parentDiv.find(".afsubmits").find(".aft").attr({id: "article_contents_attributes_"+idNum+"_title"})
      ##console.log("idNum"+idNum)
      #dddd++
      idNum++
      #console.log("iba")
      aaaa=z[1]
      #console.log("last="+aaaa)
      #console.log("lastid="+idNum)
      
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regst)
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
      #console.log("aaaa"+z[1])
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          #console.log("ret="+red)
          return true #これで、除外したいやつから抜らけれる
          
      #console.log("after ifz="+z[1])
     
      aaaa=z[1]
  for i in [0..aaaa]
    if i==0
     tmp=ls[i]
     console.log("iif"+ls[i])
    ls[i]=$("input#article_contents_attributes_"+i+"_title").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
    console.log("nonei"+ls[i]) #tmp=ls0
        
  for j in [0..aaaa]
   
    if j==aaaa
     $("input#article_contents_attributes_"+j+"_title").val(tmp)
     $("h2#article_contents_attributes_"+j+"_title").html('<span class="ranking-icon"></span>'+tmp)
     #console.log("jif"+$("#article_contents_attributes_"+j+"_title").val(tmp))
    else
     $("input#article_contents_attributes_"+j+"_title").val(ls[aaaa-j]) #name0.val(ls3) name1.val(ls2) name2.val(ls1) name3.val(ls0)
     #console.log("jls"+$("#article_contents_attributes_"+j+"_title").val(ls[aaaa-j]))
     $("h2#article_contents_attributes_"+j+"_title").html('<span class="ranking-icon"></span>'+ls[aaaa-j])
    
        
$(document).on "click", "#dsubmit", ->

  idNum=0
  #console.log("スイッチ="+aaaa)
  aaaa=0
  ##console.log(ls1+"/"+ls2)
  cccc=0
  dddd=0
  red=0
  maxf=0
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      #console.log("z="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
      #console.log("aaaa"+z[1])
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          #console.log("ret="+red)
          return true #これで、除外したいやつから抜らけれる
          
      #cke_article_contents_attributes_idNum_description
      $this.attr({id: "cke_article_contents_attributes_"+idNum+"_description"})
      ##console.log("idNum"+idNum)
      $parentDiv.find(".afsubmits").find(".afd").attr({id: "article_contents_attributes_"+idNum+"_description"})
      #dddd++
      idNum++
      
      aaaa=z[1]
      #console.log("last="+aaaa)
      #console.log("lastid="+idNum)
      
  $('fieldset div').each ->
    if z=$(this).prop('id').match(regz)
      #console.log("z="+z[1])
      ##console.log(z[1]+":"+$(this).val())
      $this = $(this)
      $parentDiv = $this.parents('fieldset')
      aaaa=z[1]
      #console.log("aaaa"+z[1])
      if $parentDiv.css('display') == priorityStyle
          red++
          $this.removeAttr("id")
          #console.log("ret="+red)
          return true #これで、除外したいやつから抜らけれる
          
      #console.log("after ifz="+z[1])
     
      aaaa=z[1]
      #console.log("last="+aaaa)
      #console.log("lastid="+idNum)
  #lab=$("fieldset div#cke_article_contents_attributes_"+0+"_description div div iframe").contents().find("html body")
  #lam=lab.html() #別途HTML内容を取得する必要がある
  #mab=$("fieldset div#cke_article_contents_attributes_"+1+"_description div div iframe").contents().find("html body")
  #mam=mab.html()
  #lab.html(mam)
  #mab.html(lam)
  for i in [0..aaaa]
    lab=$("fieldset div#cke_article_contents_attributes_"+i+"_description div div iframe").contents().find("html body") #HTML場所取得
    if i==0
     jam[0]=lab.html()
     tmp=jam[0]
     #console.log("NO."+i+".tmp"+tmp)
    #lab.html("aaaaaaaaaaaaaa")
    
    #ls[i]=$("#cke_article_contents_attributes_"+i+"_description").val() #ls0=name0 ls1=name1 ls2=name2 ls3=name3
    jam[i]=lab.html() #こいつに取得した場所の内容を格納
    
    #console.log("NO."+i+".inone"+jam[i])
    #ls[i]=jam #ls0=name0 ls1=name1 ls2=name2 ls3=name3
    
     #tmp=ls0
  #  #console.log(ls[i])
      ##console.log(tmp)
  kml=[]
  for j in [0..aaaa]
    kml[j]=$("fieldset div#cke_article_contents_attributes_"+j+"_description div div iframe").contents().find("html body")
    if j==aaaa
      #console.log("NO."+j+".inone"+jam[j])
      #console.log("aaaaNO."+j+".inone"+jam[aaaa-j])
      kml[j].html(tmp)
      $("div#article_contents_attributes_"+j+"_description").html(tmp)
    else
        
     #$("#cke_article_contents_attributes_"+j+"_description").val(ls[aaaa-j]) #name0.val(ls3) name1.val(ls2) name2.val(ls1) name3.val(ls0)
      #console.log(j+"の場合aaaa-j="+(aaaa-j))
      kml[j].html(jam[aaaa-j])
      $("div#article_contents_attributes_"+j+"_description").html(jam[aaaa-j])
      # #console.log("jels"+jam[j])
      #console.log("AfterNO."+j+".inone"+jam[j])
      ##console.log("jend"+jam[j])
     ##console.log(i)$('fieldset input[type=text]').each ->
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


  
    
 

