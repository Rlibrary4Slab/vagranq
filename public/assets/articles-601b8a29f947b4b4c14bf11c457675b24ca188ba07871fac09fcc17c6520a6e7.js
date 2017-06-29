(function() {
  var ImageCropper, aaaa, arlt, arth, cccc, idNum, jam, jihi, linkman, ls, priorityStyle, red, reglink, regst, regz, regz2, titz, tsubmit,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  aaaa = 0;

  linkman = 0;

  arth = 0;

  arlt = 0;

  jihi = "";

  regz = new RegExp('^cke_article_contents_attributes_([0-9+]+)_description$');

  regst = new RegExp('^article_contents_attributes_([0-9+]+)_title$');

  regz2 = new RegExp('^article_contents_attributes_([0-9+]+)_description$');

  reglink = new RegExp('^http:\/\/192.168.33.10:3000\/articles\/([0-9+]+)$');

  $(document).on({
    "mouseenter": function() {
      var imgidaf, imgidbe;
      document.getElementById("tansubmit").click();
      document.getElementById("dansubmit").click();
      console.log("hover");
      if ($(this).parents(".ckeditors").find("textarea").attr("id") !== void 0) {
        imgidbe = $(this).parents(".ckeditors").find("textarea").attr("id");
        imgidaf = imgidbe.replace("article_contents_attributes_", "").replace("_description", "");
        $("#mouseOverSum").val(Number(imgidaf) + 1);
        return console.log($("#mouseOverSum").val());
      } else {
        console.log("pi");
        return $("#mouseOverSum").val("0");
      }
    },
    "mouseleave": function() {
      console.log("off");
      $("#mouseOverSumOff").val($("#mouseOverSum").val());
      return console.log($("#mouseOverSumOff").val());
    }
  }, "div.cke_ltr");

  $(window).on("beforeunload", function() {
    if ($("#csubmit").length === 1) {
      return "このページから離れると入力が無効になります";
    }
  });

  $(document).on('submit', function() {
    return $(window).off('beforeunload');
  });

  $(window).on("load", function() {
    CKEDITOR.replaceAll("ckeditor");
    $('div p a[class="jihi"]').each(function() {
      var attrlink;
      $(this).html("ork");
      $(this).hide();
      attrlink = $(this).attr("href");
      return $("#getattrlink").val(attrlink);
    });
    $('fieldset div').each(function() {
      var z;
      if (z = $(this).prop('id').match(regz)) {
        return aaaa = z[1];
      }
    });
    console.log("ロード=" + aaaa);
    $('p img').css({
      "height": "auto",
      "width": "auto"
    });
    $("div.s_article_thumbnail").each(function() {
      var thichil, thisimg;
      arth++;
      console.log("arth" + arth);
      thisimg = $(this);
      thichil = $(this).children().eq(1);
      console.log("nW" + thichil.naturalheight);
      if (thichil.naturalWidth < thichil.naturalHeight) {
        thichil.css({
          "height": "auto",
          "width": "100%"
        });
      }
      return $(".s_article_thumbnail").css({
        "display": ""
      });
    });
    $('#spsubmit').click();
    if ($("#csubmit").length === 1) {
      console.log("csubmit");
      document.getElementById("csubmit").click();
    }
    if ($("#showsubmit").length === 1) {
      console.log("showsub");
      return document.getElementById("showsubmit").click();
    }
  });

  red = 0;

  priorityStyle = 'none';

  idNum = 0;

  cccc = 0;

  ls = [];

  jam = [];

  $(document).on('ready page:load', function() {
    $("p img").css({
      "height": "",
      "width": ""
    });
    $('div p a[class="jihi"]').each(function() {
      var attrlink;
      $(this).html("ork");
      $(this).hide();
      attrlink = $(this).attr("href");
      return $("#getattrlink").val(attrlink);
    });
    console.log("どくめんｔ" + arth);
    $(".s_article_thumbnail").css({
      "display": ""
    });
    $('fieldset div').each(function() {
      var z;
      if (z = $(this).prop('id').match(regz)) {
        return aaaa = z[1];
      }
    });
    $('#spsubmit').click();
    $("div.s_article_thumbnail").each(function() {});
    console.log($("#article_title").val());
    return $('#spsubmit').click();
  });

  $(document).on("click", '#spsubmit', function() {
    $(".psubmit").click();
    return $(".pdsubmit").click();
  });

  $(document).on('click', '.remove_fields', function(event) {
    $(this).parents("fieldset").find('._destroy').val('1');
    $(this).closest('li').hide();
    $(".add_fields").css("display", "");
    document.getElementById("tansubmit").click();
    document.getElementById("dansubmit").click();
    console.log("removed=" + aaaa);
    console.log("twice=" + aaaa);
    return event.preventDefault();
  });

  $(document).on('click', '.add_fieldsl', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    CKEDITOR.replaceAll("ckeditor");
    document.getElementById("tansubmit").click();
    document.getElementById("dansubmit").click();
    document.getElementById("dansubmit").click();
    document.getElementById("tansubmit").click();
    $(this).parents("ul").find("li").last().find("fieldset").find(".toplinkmove").click();
    return event.preventDefault();
  });

  $(document).on('click', '.add_fieldsf', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).after($(this).data('fields').replace(regexp, time));
    CKEDITOR.replaceAll("ckeditor");
    document.getElementById("tansubmit").click();
    document.getElementById("dansubmit").click();
    document.getElementById("dansubmit").click();
    document.getElementById("tansubmit").click();
    $(this).parents("ul").find("li").first().find("fieldset").find(".toplinkmove").click();
    return event.preventDefault();
  });

  $(document).on("click", ".pdsubmit", function() {
    var cabf, divf, jjjf, salf;
    divf = $(this).parents(".description_field").find(".field");
    divf.css("display", "none");
    salf = $(this).parents(".description_field").find(".field").find(".form-control").val();
    console.log("salve=" + salf);
    $(this).parents(".description_field").find(".afsubmits").css("display", "");
    $(this).parents(".description_field").find(".pdsubmit").css("display", "none");
    $(this).parents(".description_field").find(".esubmit").css("display", "");
    cabf = $(this).parents(".description_field").find(".field").find(".cke_ltr").first().find(".cke_inner").find(".cke_contents").find(".cke_wysiwyg_frame").contents().find("html body");
    jjjf = cabf.html();
    console.log("jjjf=" + jjjf);
    if (salf !== "") {
      $(this).parents(".description_field").find(".afsubmits").find(".afd").html(salf);
      return $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf);
    } else {
      return $(this).parents(".description_field").find(".afsubmits").find(".afd").html(jjjf);
    }
  });

  $(document).on("click", ".psubmit", function() {
    var cabd, cabt, divs, iii, jjj, sall;
    divs = $(this).parents("fieldset").find(".ckeditors");
    sall = $(this).parents("fieldset").find(".ckeditors").find(".form-control").last().val();
    divs.css("display", "none");
    $(this).parents("fieldset").find(".afsubmits").css("display", "");
    $(this).parents("fieldset").find(".psubmit").css("display", "none");
    $(this).parents("fieldset").find(".esubmit").css("display", "");
    cabt = $(this).parents("fieldset").find(".ckeditors").find(".form-control").first().val();
    cabd = $(this).parents("fieldset").find(".ckeditors").find(".cke_ltr").first().find(".cke_inner").find(".cke_contents").find(".cke_wysiwyg_frame").contents().find("html body");
    iii = cabt;
    jjj = cabd.html();
    $(this).parents("fieldset").find(".toplinkmove").click();
    $(this).parents("fieldset").find(".afsubmits").find(".aft").html('<span class="ranking-icon"></span>' + iii);
    $(this).parents("fieldset").find(".afsubmits").find(".afd").html(jjj);
    if (sall !== "") {
      $(this).parents("fieldset").find(".afsubmits").find(".afd").html(sall);
    } else {
      $(this).parents("fieldset").find(".afsubmits").find(".afd").html(jjj);
    }
    return $(this).parents("fieldset").find(".toplinkmove").click();
  });

  $(document).on("click", "a[href^=#].toplinkmove", function() {
    var target, targetY;
    target = $(this);
    if (!target.length) {
      return;
    }
    targetY = target.offset().top;
    $('html,body').animate({
      scrollTop: targetY
    }, 300, 'swing');
    return false;
  });

  $(document).on("click", ".esubmit", function() {
    $(this).parents("fieldset").find(".ckeditors").find(".form-control").last().val("");
    $(this).parents(".description_field").find(".field").find(".form-control").val();
    $(this).parents(".description_field").find(".pdsubmit").css("display", "");
    $(this).parents("fieldset").find(".ckeditors").css("display", "");
    $(this).parents("fieldset").find(".afsubmits").css("display", "none");
    $(this).parents("fieldset").find(".psubmit").css("display", "");
    $(this).parents("fieldset").find(".esubmit").css("display", "none");
    $(this).parents(".description_field").find(".field").css("display", "");
    $(this).parents(".description_field").find(".afsubmits").css("display", "none");
    $(this).parents(".description_field").find(".psubmit").css("display", "");
    $(this).parents(".description_field").find(".esubmit").css("display", "none");
    return $(this).parents("fieldset").find(".toplinkmove").click();
  });

  tsubmit = 0;

  $(document).on('click', function() {
    var dsds, eyeimg, ym;
    if ($("#csubmit").length === 1) {
      console.log("csubmit");
      document.getElementById("csubmit").click();
    }
    console.log("befaa:" + titz);
    $(".pup").css({
      "display": "initial"
    });
    $(".pdown").css({
      "display": "initial"
    });
    $("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").css({
      "display": "none"
    });
    $("input#article_contents_attributes_" + aaaa + "_title").parents("fieldset").find(".pdown").css({
      "display": "none"
    });
    if ($("#csubmit").length !== 1) {
      $('div p a[class="jihi"]').each(function() {
        var athis, attrlink;
        athis = $(this);
        $(this).hide();
        attrlink = $(this).attr("href");
        return $("#getattrlink").val(attrlink);
      });
    }
    $('div.ImagePreviewBox table tbody tr td a img').css({
      "height": "100%",
      "width": "100%"
    });
    if ($("#user_name").length < 1) {

    } else {
      if ($("#user_user_image").length < 1) {
        console.log("ando");
        dsds = $("#user_name").val();
        $("#user_user_name").val(dsds).change();
      }
    }
    if ($("#csubmit").length === 1) {
      $('p img').css({
        "height": "28.2%",
        "width": "100%"
      });
    }
    if ($('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val() !== "") {
      $('p img').css({
        "height": "auto",
        "width": "auto"
      });
      $('.cke_dialog_ui_button_ok').css({
        "display": ""
      });
    } else {

    }
    $(".pup").css({
      "display": "initial"
    });
    $(".pdown").css({
      "display": "initial"
    });
    $("input#article_contents_attributes_0_title").parents("fieldset").find(".pup").css({
      "display": "none"
    });
    $("input#article_contents_attributes_" + titz + "_title").parents("fieldset").find(".pdown").css({
      "display": "none"
    });
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input').val("100%");
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input').val("100%");
    eyeimg = $("div div div iframe").contents().find("html body p img");
    ym = eyeimg.first().prop("src");
    if (ym !== void 0) {
      return $("#eyecatch_img").val(ym);
    } else {
      return $("#eyecatch_img").val('l_e_others_500.png');
    }
  });

  $(document).on('click', '.cke_btn_reset', function() {
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:nth-child(2) td div table tbody tr td div div div input').val("");
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input').val("100%");
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr:first-child td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input').val("100%");
    return $('img').css({
      "height": "28.2%",
      "width": "100%"
    });
  });

  $(document).on('click', '.cke_button__image', function() {
    var iurtmp;
    iurtmp = $(this).parents('div').children().eq(3).attr('id');
    $("#iurtmp").val(iurtmp.replace("_arialbl", ""));
    $('table tbody tr td div table tbody tr:first-child td div table tbody tr td table tbody tr td div div div input').val("");
    return $("body div.cke_reset_all").css({
      "display": ""
    });
  });

  $(document).on('click', '.cke_dialog_ui_button_ok', function() {
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:first-child td div div div input').val("100%");
    $('table tbody tr:nth-child(3) td table tbody tr td.cke_dialog_ui_hbox_first div.cke_dialog_ui_vbox table tbody tr td table tbody tr .cke_dialog_ui_hbox_first div table tbody tr:nth-child(2) td div div div input').val("100%");
    return $('.cke_btn_reset').remove();
  });

  $(document).on("click", ".tdsubmit", function() {
    if ($("#checkAgree").prop("checked") === true) {
      console.log("teee");
      $("#checkAgree").prop("checked", false);
    } else if ($("#checkAgree").prop("checked") === false) {
      console.log("faa");
      $("#checkAgree").prop("checked", true);
    }
    document.getElementById("tsubmit").click();
    document.getElementById("dsubmit").click();
    document.getElementById("tansubmit").click();
    return document.getElementById("dansubmit").click();
  });

  $(document).on("click", "#tansubmit", function() {
    var dddd, maxf;
    idNum = 0;
    aaaa = 0;
    cccc = 0;
    dddd = 0;
    red = 0;
    maxf = 0;
    $('li fieldset div input').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regst)) {
        console.log("titz=" + z[1]);
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          console.log("Tanret=" + red);
          return true;
        }
        $this.attr({
          id: "article_contents_attributes_" + idNum + "_title"
        });
        $parentDiv.find(".afsubmits").find(".aft").attr({
          id: "article_contents_attributes_" + idNum + "_title"
        });
        idNum++;
        return aaaa = z[1];
      }
    });
    return $('li fieldset div input').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regst)) {
        $this = $(this);
        $parentDiv = $this.parents('fieldset');
        aaaa = z[1];
        console.log("dos" + aaaa);
        $(".add_fieldsf").css("display", "");
        if (aaaa === "0") {
          $(".add_fieldsf").css("display", "none");
        }
        if (aaaa === "99") {
          console.log("disadd");
          return $(".add_fields").css("display", "none");
        }
      }
    });
  });

  $(document).on("click", "#dansubmit", function() {
    var dddd, maxf;
    idNum = 0;
    aaaa = 0;
    cccc = 0;
    dddd = 0;
    red = 0;
    maxf = 0;
    $('li fieldset div').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regz)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        $this.attr({
          id: "cke_article_contents_attributes_" + idNum + "_description"
        });
        $parentDiv.find(".afsubmits").find(".afd").attr({
          id: "article_contents_attributes_" + idNum + "_description"
        });
        idNum++;
        aaaa = z[1];
        console.log("danlast=" + aaaa);
        return console.log("lastid=" + idNum);
      }
    });
    $('li fieldset div').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regz)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        return aaaa = z[1];
      }
    });
    idNum = 0;
    $('li fieldset div textarea').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regz2)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        $this.attr({
          id: "article_contents_attributes_" + idNum + "_description"
        });
        $parentDiv.find(".afsubmits").find(".afd").attr({
          id: "article_contents_attributes_" + idNum + "_description"
        });
        idNum++;
        return aaaa = z[1];
      }
    });
    return $('li fieldset div textarea').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regz2)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        return aaaa = z[1];
      }
    });
  });

  $(document).on("click", ".pup", function() {
    var dddd, inpup, jam1, jam2, kml1, kml2, lab1, lab2, maxf, rep1, rep2, rept11, rept12, tmp1, tmp2;
    document.getElementById("dansubmit").click();
    console.log("pup");
    inpup = $(this).parents('fieldset').children().find("textarea").attr("id");
    idNum = 0;
    console.log(inpup);
    rep1 = inpup.replace("_description", "");
    rep2 = rep1.replace("article_contents_attributes_", "");
    console.log(rep2 + "!!rep2");
    cccc = 0;
    dddd = 0;
    red = 0;
    maxf = 0;
    rept11 = $("input#article_contents_attributes_" + rep2 + "_title").val();
    console.log("rept11" + rept11);
    rept12 = $("input#article_contents_attributes_" + (rep2 - 1) + "_title").val();
    console.log("rept12" + rept12);
    $("input#article_contents_attributes_" + rep2 + "_title").val(rept12);
    $("h2#article_contents_attributes_" + rep2 + "_title").html('<span class="ranking-icon"></span>' + rept12);
    $("input#article_contents_attributes_" + (rep2 - 1) + "_title").val(rept11);
    $("h2#article_contents_attributes_" + (rep2 - 1) + "_title").html('<span class="ranking-icon"></span>' + rept11);
    lab1 = $("fieldset div#cke_article_contents_attributes_" + rep2 + "_description div div iframe").contents().find("html body");
    jam1 = lab1.html();
    tmp1 = jam1;
    lab2 = $("fieldset div#cke_article_contents_attributes_" + (rep2 - 1) + "_description div div iframe").contents().find("html body");
    jam2 = lab2.html();
    tmp2 = jam2;
    kml1 = $("fieldset div#cke_article_contents_attributes_" + rep2 + "_description div div iframe").contents().find("html body");
    kml1.html(tmp2);
    $("div#article_contents_attributes_" + rep2 + "_description").html(tmp2);
    kml2 = $("fieldset div#cke_article_contents_attributes_" + (rep2 - 1) + "_description div div iframe").contents().find("html body");
    kml2.html(tmp1);
    return $("div#article_contents_attributes_" + (rep2 - 1) + "_description").html(tmp1);
  });

  $(document).on("click", ".pdown", function() {
    var dddd, inpup, jam1, jam2, kml1, kml2, lab1, lab2, maxf, rep1, rep2, rept11, rept12, tmp1, tmp2;
    document.getElementById("dansubmit").click();
    console.log("pdown");
    inpup = $(this).parents('fieldset').children().find("textarea").attr("id");
    idNum = 0;
    console.log(inpup);
    rep1 = inpup.replace("_description", "");
    rep2 = rep1.replace("article_contents_attributes_", "");
    console.log(rep2 + "!!rep2");
    cccc = 0;
    dddd = 0;
    red = 0;
    maxf = 0;
    rept11 = $("input#article_contents_attributes_" + rep2 + "_title").val();
    console.log("rept11" + rept11);
    console.log("rep2+1=" + (Number(rep2) + 1));
    rept12 = $("input#article_contents_attributes_" + (Number(rep2) + 1) + "_title").val();
    console.log("rept12" + rept12);
    $("input#article_contents_attributes_" + rep2 + "_title").val(rept12);
    $("h2#article_contents_attributes_" + rep2 + "_title").html('<span class="ranking-icon"></span>' + rept12);
    $("input#article_contents_attributes_" + (Number(rep2) + 1) + "_title").val(rept11);
    $("h2#article_contents_attributes_" + (Number(rep2) + 1) + "_title").html('<span class="ranking-icon"></span>' + rept11);
    lab1 = $("fieldset div#cke_article_contents_attributes_" + rep2 + "_description div div iframe").contents().find("html body");
    jam1 = lab1.html();
    tmp1 = jam1;
    lab2 = $("fieldset div#cke_article_contents_attributes_" + (Number(rep2) + 1) + "_description div div iframe").contents().find("html body");
    jam2 = lab2.html();
    tmp2 = jam2;
    kml1 = $("fieldset div#cke_article_contents_attributes_" + rep2 + "_description div div iframe").contents().find("html body");
    kml1.html(tmp2);
    $("div#article_contents_attributes_" + rep2 + "_description").html(tmp2);
    kml2 = $("fieldset div#cke_article_contents_attributes_" + (Number(rep2) + 1) + "_description div div iframe").contents().find("html body");
    kml2.html(tmp1);
    return $("div#article_contents_attributes_" + (Number(rep2) + 1) + "_description").html(tmp1);
  });

  titz = 0;

  $(document).on("click", "#csubmit", function() {
    var maxf;
    idNum = 0;
    aaaa = 0;
    cccc = 0;
    red = 0;
    maxf = 0;
    $('fieldset div input').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regst)) {
        titz = z[1];
        console.log("titz=" + titz);
        $this = $(this);
        $parentDiv = $this.parents('fieldset');
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        $parentDiv.find(".afsubmits").find(".aft").attr({
          id: "article_contents_attributes_" + idNum + "_title"
        });
        $parentDiv.find(".afsubmits").find(".afd").attr({
          id: "article_contents_attributes_" + idNum + "_description"
        });
        red = Number(titz) + 1;
        $parentDiv.find(".ckeditors").find(".ranking-icon").text(red);
        $parentDiv.find(".afsubmits").find(".aft").find(".ranking-icon").text(red);
        return idNum++;
      }
    });
    console.log("endp" + red);
    $(".add_fieldsf").css("display", "");
    if (red === 0) {
      $(".add_fieldsf").css("display", "none");
    }
    if ($("#checkAgree").prop("checked") === true) {
      console.log("teee");
      return $('fieldset div input').each(function() {
        var $parentDiv, $this, z;
        if (z = $(this).prop('id').match(regst)) {
          $this = $(this);
          $parentDiv = $this.parents('fieldset');
          $parentDiv.find(".ckeditors").find(".ranking-icon").text(red);
          $parentDiv.find(".afsubmits").find(".aft").find(".ranking-icon").text(red);
          return red--;
        }
      });
    }
  });

  $(document).on("click", "#showsubmit", function() {
    var maxf;
    idNum = 0;
    aaaa = 1;
    cccc = 0;
    red = 0;
    maxf = 0;
    $('div.article_content h2').each(function() {
      $(this).find(".ranking-icon").text(aaaa);
      console.log("endp" + titz);
      return aaaa++;
    });
    return $('div.article_content h2').each(function() {
      if ($("#checkAgree").text() === "true") {
        console.log("teeee" + $(this));
        aaaa--;
        return $(this).find(".ranking-icon").text(aaaa);
      }
    });
  });

  $(document).on("click", "#tsubmit", function() {
    var dddd, i, j, k, l, maxf, ref, ref1, results, tmp;
    console.log("ts");
    idNum = 0;
    aaaa = 0;
    cccc = 0;
    dddd = 0;
    red = 0;
    maxf = 0;
    $('li fieldset div input').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regst)) {
        console.log("titz=" + z[1]);
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        $this.attr({
          id: "article_contents_attributes_" + idNum + "_title"
        });
        $parentDiv.find(".afsubmits").find(".aft").attr({
          id: "article_contents_attributes_" + idNum + "_title"
        });
        idNum++;
        return aaaa = z[1];
      }
    });
    $('li fieldset div').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regst)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        return aaaa = z[1];
      }
    });
    for (i = k = 0, ref = aaaa; 0 <= ref ? k <= ref : k >= ref; i = 0 <= ref ? ++k : --k) {
      if (i === 0) {
        tmp = ls[i];
        console.log("iif" + ls[i]);
      }
      ls[i] = $("input#article_contents_attributes_" + i + "_title").val();
      console.log("nonei" + ls[i]);
    }
    results = [];
    for (j = l = 0, ref1 = aaaa; 0 <= ref1 ? l <= ref1 : l >= ref1; j = 0 <= ref1 ? ++l : --l) {
      if (j === aaaa) {
        $("input#article_contents_attributes_" + j + "_title").val(tmp);
        results.push($("h2#article_contents_attributes_" + j + "_title").html('<span class="ranking-icon"></span>' + tmp));
      } else {
        $("input#article_contents_attributes_" + j + "_title").val(ls[aaaa - j]);
        results.push($("h2#article_contents_attributes_" + j + "_title").html('<span class="ranking-icon"></span>' + ls[aaaa - j]));
      }
    }
    return results;
  });

  $(document).on("click", "#dsubmit", function() {
    var dddd, i, j, k, kml, l, lab, maxf, ref, ref1, results, tmp;
    idNum = 0;
    aaaa = 0;
    cccc = 0;
    dddd = 0;
    red = 0;
    maxf = 0;
    $('li fieldset div').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regz)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        $this.attr({
          id: "cke_article_contents_attributes_" + idNum + "_description"
        });
        $parentDiv.find(".afsubmits").find(".afd").attr({
          id: "article_contents_attributes_" + idNum + "_description"
        });
        idNum++;
        return aaaa = z[1];
      }
    });
    $('li fieldset div').each(function() {
      var $parentDiv, $this, z;
      if (z = $(this).prop('id').match(regz)) {
        $this = $(this);
        $parentDiv = $this.parents('li');
        aaaa = z[1];
        if ($parentDiv.css('display') === priorityStyle) {
          red++;
          $this.removeAttr("id");
          return true;
        }
        return aaaa = z[1];
      }
    });
    for (i = k = 0, ref = aaaa; 0 <= ref ? k <= ref : k >= ref; i = 0 <= ref ? ++k : --k) {
      lab = $("fieldset div#cke_article_contents_attributes_" + i + "_description div div iframe").contents().find("html body");
      if (i === 0) {
        jam[0] = lab.html();
        tmp = jam[0];
      }
      jam[i] = lab.html();
    }
    kml = [];
    results = [];
    for (j = l = 0, ref1 = aaaa; 0 <= ref1 ? l <= ref1 : l >= ref1; j = 0 <= ref1 ? ++l : --l) {
      kml[j] = $("fieldset div#cke_article_contents_attributes_" + j + "_description div div iframe").contents().find("html body");
      if (j === aaaa) {
        kml[j].html(tmp);
        results.push($("div#article_contents_attributes_" + j + "_description").html(tmp));
      } else {
        kml[j].html(jam[aaaa - j]);
        results.push($("div#article_contents_attributes_" + j + "_description").html(jam[aaaa - j]));
      }
    }
    return results;
  });

  $(function() {
    var replace_tag_inner;
    $("#shops .page").infinitescroll({
      loading: {
        img: "http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif",
        msgText: "ロード中..."
      },
      navSelector: "nav.pagination",
      nextSelector: "nav.pagination a[rel=next]",
      itemSelector: "#shops tr.shop"
    });
    replace_tag_inner = function(tag, str) {
      var result, selected_str;
      result = tag;
      selected_str = editor.getSelection;
      if (selected_str && selected_str.getNative !== '') {
        result = result.replace(str, selected_str.getNative);
      }
      return result;
    };
    return new ImageCropper();
  });

  ImageCropper = (function() {
    function ImageCropper() {
      this.updatePreview = bind(this.updatePreview, this);
      this.update = bind(this.update, this);
      $('#cropbox').Jcrop({
        aspectRatio: 1,
        setSelect: [0, 0, 600, 600],
        onSelect: this.update,
        onChange: this.update
      });
    }

    ImageCropper.prototype.update = function(coords) {
      $("#user_crop_x").val(coords.x);
      $("#user_crop_y").val(coords.y);
      $("#user_crop_w").val(coords.w);
      $("#user_crop_h").val(coords.h);
      return this.updatePreview(coords);
    };

    ImageCropper.prototype.updatePreview = function(coords) {
      return $("#preview").css({
        width: Math.round(100 / coords.w * $("#cropbox").width()) + "px",
        height: Math.round(100 / coords.h * $("#cropbox").height()) + "px",
        marginLeft: "-" + Math.round(100 / coords.w * coords.x) + "px",
        marginTop: "-" + Math.round(100 / coords.h * coords.y) + "px"
      });
    };

    return ImageCropper;

  })();

}).call(this);
