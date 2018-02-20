# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

  
aaaa=0
linkman=0
arth=0
arlt=0
jihi="" 
red=0
priorityStyle = 'none'
idNum = 0
cccc=0
ls=[]
jam=[]
  

$(document).on 'ready page:load', ->
  $('img').on "error",->
   $(this).attr('src','/assets/l_e_others_500.png')
    # いいねボタンといいね総数をwrapしている.js-article-likesをすべて取得
    # ループ回して一個一個インスタンス生成
  if $("#item_category").length == -1
   for like_item in gon.like_items
      $('#itemlike'+like_item.item_id).removeClass('icon-fav-off').addClass('icon-fav-on')
      $('#itemlike'+like_item.item_id).html('<img alt="" border="0" height="30" src="/assets/heart_1.png" width="30">')
  favButtons = document.querySelectorAll('.js-item-likes')
  for favButton in favButtons
      new FavArticle(favButton)
  if $("input#pac-input").length == 1
   $("form").on "keypress", (e) ->
    if e.keyCode == 13 
        return false;
   
  if $('#item-tags').length == 1
   $('#item-tags').tagit
    fieldName:   'item[tag_list]'
    singleField: true
    availableTags: gon.available_tags 
    placeholderText: "スポットを入力"
    tagLimit: 1
    beforeTagAdded: (ev,ui) ->
     $("#item_add").val("")
     if $.inArray(ui.tagLabel, gon.available_tags) == -1 
      return false
    afterTagAdded: (ev,ui) ->
      $("#item_add").val(ui.tagLabel)
 
   for tag in gon.item_tags
      $('#item-tags').tagit 'createTag', tag 
  if $("#showsubmit").length ==1
   document.getElementById("showsubmit").click() 
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

  
$(document).on "click", '#spsubmit',->
  $(".psubmit").click()
  $(".pdsubmit").click()
  


  ###################
    #テキストエディタ閉じ内容を移設
  ####################


tsubmit=0  

############################################################################################################################
#  input[class=cke_dialog_ui_input_text]'                                                     画像処理
############################################################################################################################

  
    
$(document).on 'click' ,-> #clicked
  if $("#map").attr("style") != undefined
   document.getElementById("item_cat").click()
  if $("#csubmit").length ==1 
   document.getElementById("csubmit").click()  
     
      

   
  $('div.ImagePreviewBox table tbody tr td a img').css({"height":"100%","width":"100%"})
   
  if $("#csubmit").length==1   
   $('p img').css({"height":"28.2%","width":"100%"})

  if $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val() != ""  
    $('p img').css({"height":"auto","width":"auto"})
    $('.cke_dialog_ui_button_ok').css("display":"")

   
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
  
  
  
  

############################################################################################################################
#                                                       //画像処理
############################################################################################################################  
$(document).on "click", ".tdsubmit", ->
   if $("#checkAgree").prop("checked") == true
    $("#checkAgree").prop("checked",false)  
   else if $("#checkAgree").prop("checked") == false
    $("#checkAgree").prop("checked",true)
   
$(document).on "click", "#showsubmit", ->


  idNum=0
  aaaa=1
  cccc=0
  red=0
  maxf=0
 
  $('div.article_content h2.rankingh2').each ->
   $(this).find(".ranking-icon").text(aaaa)   
   aaaa++
  
  $('div.article_content h2.rankingh2').each ->
   if $("#checkAgree").text() == "true" 
    aaaa--
    $(this).find(".ranking-icon").text(aaaa)   

$ ->

  $("#relation_list .pop_list").infinitescroll
      loading: {
        img:     "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif"
        msgText: "ロード中..."
      }
      navSelector: "nav.pagination" # selector for the paged navigation (it will be hidden)
      nextSelector: "nav.pagination a[rel=next]" # selector for the NEXT link (to page 2)
      itemSelector: "#relation_list .article_list.pickup_list" # selector for all items you'll retrieve
  
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
  

class FavArticle
    constructor: ($el) ->
      # インスタンス作成したときの引数をコンストラクタで受け取ってjqueryobjにして$el変数に格納
      @$el = $($el)
      # いいねボタン探して$likesButton変数に格納
      @$likesButton = @$el.find('.js-item_likes-button')
      # いいね総数表示要素を取得して$likesCount変数に格納
      #@$likesCount = @$el.find('.js-item_likes-count')
      # イベントリスナー呼び出し
      @setEventListener()

    setEventListener: ->
      # ボタンをクリックした際のイベントリスナー
      @$likesButton.on 'click', (e) =>
        # Ajax呼び出し
        if gon.logged_in != false
          @_setLikesAjax(e)
        else
          window.location.href = "http://ranq-media.com/users/sign_up"
        
    _setLikesAjax: (e)->
      $this = $(e.currentTarget)
      
      
      # 記事idを取得
      articleId = location.pathname.replace("\/articles\/","")
      # destroyアクションへのリクエストURL
      unLikeURL = '/unitemlike/' + e.currentTarget.id.replace("itemlike","") 
      # createアクションへのリクエストURL
      likeURL = '/itemlike/' + e.currentTarget.id.replace("itemlike","") 
      # もしクリックした要素がいいねされてなかったら
      if $this.hasClass('icon-fav-off')
        $.ajax({
          # createアクションにリクエスト飛ばす
          url: likeURL
          # POSTメソッドで
          type: 'POST'
          # キャッシュは保持しない
          cache: false
          # 記事idを送る
          data: {
            'article_id': articleId,
            'item_id': e.currentTarget.id.replace("itemlike","") 
          }
          # 帰ってくるデータはjson形式で
          datatype: 'json'
        })
        # Ajax通信が成功した場合
        .done (data) =>
          # 灰色ハートのクラスを削除し赤いハートのクラスを付与
          $this.removeClass('icon-fav-off').addClass('icon-fav-on')
          $this.html('<img alt="" border="0" height="30" src="/assets/heart_1.png" width="30">')
          # いいね総数を表示
          #@$likesCount.text(data[0].likes_count)
      else
        $.ajax({
          url: unLikeURL
          type: 'DELETE'
          cache: false
          data: {
            'article_id': articleId,
            'item_id': e.currentTarget.id.replace("itemlike","")
          }
          datatype: 'json'
        })
        .done (data) =>
          $this.removeClass('icon-fav-on').addClass('icon-fav-off')
          $this.html('<img alt="" border="0" height="30" src="/assets/heart_0.png" width="30">')
          #@$likesCount.text(data[0].likes_count)
  
    
 

