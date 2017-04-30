// 最初にダイアログの定義時のイベントにフックする関数を定義する
CKEDITOR.on( 'dialogDefinition', function( ev ){
 // 表示されたダイアログの名前を取得
 var dialogName = ev.data.name;
 // 表示されたダイアログの定義を取得
 var dialogDefinition = ev.data.definition;
 // リンクのダイアログの場合
  // ダイアログコンテンツから、advanced(高度な設定)を削除する
  dialogDefinition.removeContents( 'advanced' );
  dialogDefinition.removeContents( 'Link' );
  // ダイアログコンテンツから、target(ターゲット)を削除する
  dialogDefinition.removeContents( 'target' );
  
});
