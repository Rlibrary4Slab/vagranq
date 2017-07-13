//= require jquery
//= require jquery-selection
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui.min
//= require jquery.Jcrop
//= require jquery.infinitescroll
//= require Chart.bundle
//= require chartkick
//= require twitter/bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require websocket_rails/main
//= require articles_new.js.coffee
//= require articles.js.coffee
//= require static_pages.js.coffee
//= require notifications.js.erb
var data = {'data-format': 'yyyy-MM-dd' };
$(document).on("page:load ready", function(){
    $("input.datepicker").datetimepicker({format: "YYYY-MM-DD"});
});
