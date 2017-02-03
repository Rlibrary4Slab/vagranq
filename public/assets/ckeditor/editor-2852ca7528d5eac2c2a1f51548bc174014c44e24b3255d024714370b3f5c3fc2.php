<?php
 
	// タイトルと本文を保存するファイルのパス
	$title_file_path    = "/path/to/title.txt";
	$contents_file_path = "/path/to/contents.txt";
	 
	if (!empty($_POST['action']) && $_POST['action'] === "put") {
	    if ($_POST['contents'] !== "" && $_POST['title'] !== "") {
	        $fp = fopen($title_file_path, "w");
	        fwrite($fp, htmlspecialchars($_POST['title']));
	        fclose($fp);
	        $fp = fopen($contents_file_path, "w");
	        fwrite($fp, htmlspecialchars($_POST['contents']));
	        fclose($fp);
	    } else {
	        echo "Error!";
	        exit;
	    }
	}
	 
	// タイトル用ファイルがあれば内容を取得
	if (file_exists($title_file_path)) {
	    $title = file_get_contents($title_file_path);
	} else {
	    $title = "";
	}
	 
	// 本文用ファイルがあれば内容を取得
	if (file_exists($contents_file_path)) {
	    $contents = file_get_contents($contents_file_path);
	} else {
	    $contents = "";
	}
 
?>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Replace Textareas by Class Name - CKEditor Sample</title>
    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
    <script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
    <script type="text/javascript">
CKEDITOR.config.toolbar = [
['Cut','Copy','Paste','PasteText']
,['Undo','Redo','-','SelectAll','RemoveFormat']
,['Bold','Italic','Underline','Strike','-','Subscript','Superscript']
,['NumberedList','BulletedList','-','Outdent','Indent']
,['Link','Unlink']
,'/'
,['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock']
,['Image','Table','HorizontalRule','SpecialChar']
,['Format','FontSize']
,['TextColor','BGColor']
,['ShowBlocks']
];
// テキストエリアの幅
CKEDITOR.config.width  = '600px';
// テキストエリアの高さ
CKEDITOR.config.height = '300px';
// テキストエリアのリサイズ不許可
CKEDITOR.config.resize_enabled = false;
    </script>
</head>
<body>
    <h1>
        My Blog System
    </h1>
<div id="alerts">
<noscript>
  <p>
    <strong>CKEditor requires JavaScript to run</strong>. In a browser with no JavaScript
    support, like yours, you should still see the contents (HTML data) and you should
    be able to edit it normally, without a rich editor interface.
  </p>
</noscript>
</div>
<form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post">
  <p>
  <input type="text" name="title" value="<?php echo $title; ?>" size="95" />
  </p>
  <p>
    <textarea class="ckeditor" cols="80" id="contents" name="contents" rows="10"><?php echo $contents; ?></textarea>
  </p>
  <p>
    <input type="submit" value="Submit" /><br>
    <input type="hidden" name="action" value="put" />
  </p>
</form>
</body>
</html>