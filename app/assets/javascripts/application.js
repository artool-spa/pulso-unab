// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap
//= require rails-ujs
//= require moment
//= require turbolinks
//= require daterangepicker
//= require bootstrap-filestyle
//= require bootstrap-select
// require bootstrap-select/i18n/defaults-es_CL.min
//= require jquery.quicksearch
//= require multi-select
//= require bootstrap-sortable
//= require general
// require cable

$(document).ajaxError(function(event, xhr, options, exc) {
  var errors = JSON.parse(xhr.responseText);
  var er = "<div>Los siguientes errores ocurrieron:</div><ul>";
  for (var i = 0; i < errors.length; i++) {
    var list = errors[i];
    er += "<li>" + list + "</li>";
  }
  er += "</ul>";
  $("#error_explanation").html(er);
});

$(document).ajaxSend(function(event, request, settings) {
  $(".modal-dialog .modal-content .modal-footer").prepend('<div id="loading-spinner"><i class="fa fa-refresh fa-spin"></i> Cargando...</div>');
});
$(document).ajaxComplete(function(event, request, settings) {
  $('#loading-spinner').remove();
});

$('body').on('hidden.bs.modal', '.modal', function() {
  $(this).removeData('bs.modal');
});
