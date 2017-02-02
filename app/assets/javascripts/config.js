/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	 config.language = 'ja';
	 config.uiColor = '#AADC6E';
	//config.ignoreEmptyParagraph = true;
	//config.extraPlugins = 'wordcount';
	config.extraPlugins = 'youtube';
        config.toolbar = [["Image","Link","Youtube"]];	
	config.wordcount = {
	
	    // Whether or not you want to show the Word Count
	    //showWordCount: true,
	
	    // Whether or not you want to show the Char Count
	    //showCharCount: false,
	    
	    // Maximum allowed Word Count
	    //maxWordCount: 4,
	
	    // Maximum allowed Char Count
	    //maxCharCount: 10,
	    showParagraphs: false,// 段落カウント表示する・しない
		showWordCount: false, // 単語カウント表示する・しない
		showCharCount: true, // 文字数カウント表示する・しない
		countSpacesAsChars: false,// スペースカウントする・しない
		countHTML: false, // HTMLタグカウントする・しない
		maxWordCount: -1, // 最大単語数設定(無制限の場合は-1)
		maxCharCount: -1// 最大文字数設定(無制限の場合は-1)
	    
	};	
};
