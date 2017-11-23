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
        				href =  href;
        			}
	            this.setValue(href);
	        }
        },
        commit: function(element) {
        	var href = this.getValue();
        	var isExternalURL = /^(http|https):\/\//;
	        var title,oimage,address;
	        var urlReg = /^([0-9+]+)$/;
                console.log("time:"+href)
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
		        element.setHtml('</br><div class="item_card_box"><div class="article_list_content clearfix link_card"><div class="item_card_img"><a href="http://ranq-media.com/items/'+href+'"><img class="s_eyecatch_img s_article_thumbnail" id="s_article_thumbnail article_list_thumb" src='+oimage+' alt="'+oimage+'" /></a></div><div class="article_list_text"><p class="article_list_title"><a style="" href="http://ranq-media.com/items/'+href+'">'+ loglog +'</a></p><p class="spot_list_address_area"><span class="spot_list_address">'+address+'</span></p><div class="js-item-likes"><div class="js-item_likes-button icon-fav-off" rel="nofollow" id="itemlike'+href+'"href="/itemlike/'+href+'"><img border="0" alt="" src="/assets/heart_0.png" width="30" height="30"></div></div></div></div></div></br>');

		      }else{   
			console.log("none")
                      }
		      $("#loadingajax").remove()
 		    };

        	if(href) {
			
                    if(!isExternalURL.test(href)) {
        		href = href;
	 		console.log("end")
        	    }
	            element.setAttribute("href", href);
                    console.log(href)
                    $.ajax({
                     //url: "http://cors-proxy.htmldriven.com/?url=http:ranq-media.com/items/"+href,
                     url: "http://ranq-media.com/items/"+href,
                     //url: "http://192.168.33.10:3000/items/"+href,

         	     type: 'GET',
         	     cache: false,
         	     dataType: "json",
         	     success: function(res){ 
                      console.log(res.image)
		      title = res.title 
		      address = res.address 
                      oimage = res.image.url
          
 	              ajaxend(); 
		      console.log("通信");
		     },
                     error: function(jqXHR, textStatus, errorThrown){
		      console.log(jqXHR)
		      console.log(textStatus)
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

