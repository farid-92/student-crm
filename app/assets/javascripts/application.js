// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require semantic-ui
//= require bootstrap-datepicker/core
//= require dropzone
//= require ckeditor/init
//= require_tree .

function printpage()
{
    window.print();
}
//this function calls alert close method to close an alert
function clearFlash() {
    $(".alert").alert('close');
}
//this function calls clearFlash method after 3 seconds
var clearFlashOnReady = function () {
    setTimeout(clearFlash, 3000);
};