// 最初にダイアログの定義時のイベントにフックする関数を定義する
CKEDITOR.on( 'dialogDefinition', function( ev ){
 // 表示されたダイアログの名前を取得
 var dialogName = ev.data.name;
 // 表示されたダイアログの定義を取得
 var dialogDefinition = ev.data.definition;
 // リンクのダイアログの場合
  // ダイアログコンテンツから、advanced(高度な設定)を削除する
  dialogDefinition.removeContents( 'advanced' );
  dialogDefinition.removeContents( 'Upload' );
  dialogDefinition.removeContents( 'Link' );
  // ダイアログコンテンツから、target(ターゲット)を削除する
  dialogDefinition.removeContents( 'target' );
  
});
CKEDITOR.on('instanceReady', function(ev) 
{
        var dragSrc =null;
	ev.editor.document.on('dragstart', function (evt) 	
	{
                dragSrc=this;
                e.dataTransfer.setData('text/html', this.innerHTML);
		/*var draggedtext = evt.data.$.dataTransfer.getData("text/html");
        	draggedtext = draggedtext.replace('http://domain.com/','');
		evt.data.$.dataTransfer.setData("text/html",draggedtext);
	        */
        });
        ev.editor.document.on('drop', function (evt) {
          
           console.log($("#dragSrc").val());
           evt.data.$.dataTransfer.setData("text/html", $("#dragSrc").val());

          
        });
});
