/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	config.language = 'ja';
	config.uiColor = '#f5f5f5';
	//config.ignoreEmptyParagraph = true;
	config.extraPlugins = 'SimpleLink,wordcount,youtube,notification,autogrow,uploadwidget';
	//config.extraPlugins = 'wordcount,youtube,notification,autogrow';
        //config.toolbar = [["Image","Link","Youtube"]];	
	config.toolbar= [{name: 'image', items:["Image"]},{name:"link",items:["Link"]},{name:"Yout",items:["Youtube"]},{name:"Sour",items:["Source"]},{name:"Recommend",items:["Bold","SimpleLink"]}];
	//config.toolbar= [{name: 'image', items:["Image"]},{name:"link",items:["Link"]},{name:"Yout",items:["Youtube"]},{name:"Sour",items:["Source"]},{name:"Recommend",items:["Bold"]}];
        config.allowedContent = true;
        config.resize_enabled = false;
        config.resize_dir = 'vertical';
        //config.colorButton_colors = '00923E,F8C100,28166F';
        config.coreStyles_bold = {
          element: 'span',
          attributes: {'class':"markedColor"}
          //styles : {"background": "rgba(255,100,100,0.3)"} 
         
        };
	config.wordcount = {
	
	    // Whether or not you want to show the Word Count
	    //WordCount: true,
	
	    // Whether or not you want to show the Char Count
	    //showCharCount: false,
	    
	    // Maximum allowed Word Count
	    //maxWordCount: 4,
	
	    // Maximum allowed Char Count
	    //maxCharCount: 10,
	    showParagraphs: false,// 段落カウント表示する・しない
	    showWordCount: false, // 単語カウント表示する・しない
		showCharCount: true, // 文字数カウント表示する・しない
		//countSpacesAsChars: false,// スペースカウントする・しない
		countHTML: false, // HTMLタグカウントする・しない
		maxWordCount: -1, // 最大単語数設定(無制限の場合は-1)
		maxCharCount: -1  // 最大文字数設定(無制限の場合は-1)
	    
	};
	
        config.droplerConfig = {
         backend: 'imgur',
         settings: {
          //clientId: '97130997890afe1'
          //clientId: 'bf3f565552854fa'
          clientId: 'efac5e8b88240c9'
          //clientId: 'efac5e8b88240c9'

         }
        };
       


};

