CKEDITOR.plugins.add( 'RanqLink', {
    icons: 'ranqlink',
    init: function( editor ) {
        editor.addCommand( 'ranqlink', new CKEDITOR.dialogCommand( 'ranqlinkDialog' ) );
        editor.ui.addButton( 'RanqLink', {
            label: 'RAdd a link',
            icons: 'ranqlink',
            command: 'ranqlink'
        });
        
        CKEDITOR.dialog.add( 'ranqlinkDialog', this.path + 'dialogs/ranqlink.js' );
    }
});
