CKEDITOR.dialog.add("ranqlinkDialog", function(editor) {
	return {
		allowedContent: "a[href,target]",
		title: "Insert Link",
		minWidth: 550,
		minHeight: 100,
		resizable: CKEDITOR.DIALOG_RESIZE_NONE,
		contents:[{
			id: "ranqLink",
			label: "ranqLink",
			elements:[{
				type: "text",
				label: "URL",
				id: "edp-URL",
				validate: CKEDITOR.dialog.validate.notEmpty( "URLを記述してください" ),
        setup: function( element ) {
        	var href = element.getAttribute("href");
        	var isExternalURL = /^(http|https):\/\//;
        	if(href) {
        			if(!isExternalURL.test(href)) {
        				href = "http://" + href;
        			}
	            this.setValue(href);
	        }
        },
        commit: function(element) {
        	var href = this.getValue();
        	var isExternalURL = /^(http|https):\/\//;
	        var title,oimage,outimage;
	        var urlReg = /^http:\/\/ranq-media\.com\/articles\/([0-9+]+)$/;
	        //$(".lists").append("<div style="height:999999px; width:999999px; background-color: #000000; z-index: 999;"></div>");
	        $("body").before('<div id="loadingajax" style="opacity:0.5; height:999999px; width:999999px; background-color: #FFFFFF; z-index: 10000; position:absolute;"></div>');
	        $("#loadingajax").append('<img src="http://www.mytreedb.com/uploads/mytreedb/loader/ajax_loader_blue_48.gif" style="position: fixed; bottom: 0; top: 0; left: 0; right: 0; margin: auto; z-index: 10000;"></div>');
                var ajaxend  = function(){
                      if(title == undefined){
		       console.log("koreha");
	               title = "ページを取得できませんでした";
		      }
                      if(urlReg.test(href)){ 
                        var loglog = title.replace(" | RanQ [ランク]","")
			console.log("true")
                        console.log(href)
                        console.log(oimage)
                        console.log(loglog)
		        element.setHtml('<div class="article_list_content clearfix link_card"><a href="'+href+'"><img class="s_eyecatch_img s_article_thumbnail" id="s_article_thumbnail article_list_thumb" src='+oimage+' alt="'+oimage+'" /></a><div class="article_list_text"><p class="article_list_title"><a style="" href="'+href+'">'+ loglog +'</a></p></div></div>');
		      }else{   
			console.log("none")
		        if (oimage != undefined){
			console.log("inimage")
  			 element.setHtml('<div class="out_embed"><div class="out_embed_image_box"><a href="'+href+'"><img class="out_embed_image" src="'+oimage+'" /></a></div><p class="out_article_title"><a style="" href="'+href+'">'+title+'</a></p></div>');
			}else if(outimage != undefined){ 
			console.log("outimage")
			console.log(outimage)
	                var srcroot;
  			 element.setHtml('<div class="out_embed"><div class="out_embed_image_box"><a href="'+href+'"><img class="out_embed_image" src="'+outimage+'" /></a></div><p class="out_article_title"><a style="" href="'+href+'">'+title+'</a></p></div>');
			}else{
			console.log("nonimage")
	                var nonimage = "/assets/l_e_others_500.png"
  			 //element.setHtml('<div class="out_embed"><div class="out_embed_image_box"><a href="'+href+'"><img class="out_embed_image" src="'+assets/l_e_others_500.png+'" /></a></div><p class="out_article_title"><a style="" href="'+href+'">'+title+'</a></p></div>');
  			 element.setHtml('<div class="out_embed"><div class="out_embed_image_box"><a href="'+href+'"><img class="out_embed_image" src="'+nonimage+'" /></a></div><p class="out_article_title"><a style="" href="'+href+'">'+title+'</a></p></div>');
		        }
                      }
		      $("#loadingajax").remove()
 		    };

        	if(href) {
			
                    if(!isExternalURL.test(href)) {
        		href = "http://" + href;
	 		console.log("end")
	 		console.log(href)
        	    }
	            element.setAttribute("href", href);
                    $.ajax({
                     url: "http://cors-proxy.htmldriven.com/?url=http:ranq-media.com/items/"+href,
         	     type: 'GET',
         	     cache: false,
         	     dataType: "json",
         	     success: function(res){ 
                      r = $("<div/>").text(res.body).html();
                      ten= r.replace(/&lt;/g,"<").replace(/&gt;/g,">");
                      var dom_parser = new DOMParser();
		      xmls = dom_parser.parseFromString(ten , "text/html");
                      r = $(xmls.documentElement);
		      title = r.find("title").html();
 	              console.log("<div>"+title+"</div>");
                      oimage = r.find("meta[property="+'"og:image"'+"]").attr("content");
                      outimage = r.find('img').attr("src");
 	              ajaxend(); 
		      console.log("通信");
		     },
                     error: function(jqXHR, textStatus, errorThrown){
		      console.log("ひどい")
		      console.log(jqXHR)
		      console.log(textStatus)
		      console.log("ひどい")
		      $("#loadingajax").remove()
		       
 	             }
	 	    });


		    
	        }        	
        }				
	}, {
	type: "text",
        label: "Text to display",
	id: "edp-text-display",
        setup: function( element ) {
            this.setValue( element.getText() );
        },
        commit: function(element) {
        	var currentValue = this.getValue();
        	if(currentValue !== "" && currentValue !== null) {
	        	element.setText(currentValue);
	        }
        }	
			}, {
				type: "html",
				html: "<p>The Link will be opened in another tab.</p>"
			}]
		}],
		onShow: function() {
			var selection = editor.getSelection();
			var selector = selection.getStartElement()
			var element;
			
			if(selector) {
				 element = selector.getAscendant( 'a', true );
			}
			
			if ( !element || element.getName() != 'a' ) {
				element = editor.document.createElement( 'a' );
				console.log("create")
				element.setAttribute("target","_blank");
				if(selection) {
					element.setText(selection.getSelectedText());
				}
                this.insertMode = true;
			}
			else {
				this.insertMode = false;
			}
			
			this.element = element;

			
			this.setupContent(this.element);
		},
		onOk: function() {
			var dialog = this;
			var anchorElement = this.element;
			
			this.commitContent(this.element);

			if(this.insertMode) {
				editor.insertElement(this.element);
			}
		}
	};
});

