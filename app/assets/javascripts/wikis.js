
$(document).ready( function() {
  var opts = {
    textarea: 'epiceditor-body',
    clientSideStorage: false,
    button: {
      fullscreen: false,
    }
  }
  var editor = new EpicEditor(opts).load();

});