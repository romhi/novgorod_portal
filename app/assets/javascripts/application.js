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
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap/dropdown
//= require turbolinks
//= require maskedinput
//= require bootstrap-wysihtml5
//= require noty/jquery.noty
//= require noty/layouts/topCenter
//= require noty/themes/default
//= require_tree .

function noty_success(message){
    noty_message('success', message);
}

function noty_error(message){
    noty_message('error', message);
}

function noty_message(type, message){
    noty({
        text: message,
        type: type,
        dismissQueue: true,
        timeout: 10000,
        layout: 'topCenter',
        theme: 'defaultTheme'
    });
}