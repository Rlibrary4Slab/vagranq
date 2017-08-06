/*
* Youtube Embed Plugin
*
* @author Jonnas Fonini <contato@fonini.net>
* @version 2.0.9
*/
( function() {
     var code = '<code>強調</code>'
	CKEDITOR.plugins.add( 'code',
	{
		init: function( editor )
		{
			editor.ui.addButton('code', {
      				label: 'code', command: 'code', icon: 'images/code.png'
			});
			editor.addCommand('code', {
			      exec: function(editor) {
				editor.insertHtml(replace_tag_inner(code, "強調"));
				//editor.insertHtml(replace_tag_inner(code, "強調"));
			      }
			});
		    function replace_tag_inner(tag, str) {
		     var result = tag;
			console.log(tag);
		     var selected_str = editor.getSelection();
			console.log(selected_str);
		     // エディタ内で選択中の文字列が存在する場合
		     if (selected_str && selected_str.getNative() != '') {
		      result = result.replace(str, selected_str.getNative());
			console.log("if"+result);
		     }
			console.log("non"+result);
		     return result;
		    }
		}	
	});

})();

