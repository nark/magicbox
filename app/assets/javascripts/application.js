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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require moment/en-gb.js
//= require tempusdominus-bootstrap-4.js
//= require turbolinks
//= require Chart.bundle
//= require highcharts
//= require highcharts/highcharts-more
//= require chartkick
//= require jquery_nested_form
//= require_tree .


function init_views() {
	$('#sidebarCollapse').on('click', function () {
    $('#sidebar').toggleClass('active');
  });

  $('#roomsSubmenu').collapse('show');

  $('.timepicker').datetimepicker({format: 'hh:mm', stepping: "5"});
  $('.weekpicker').datetimepicker({format: 'YYYY-MM-DD', inline: true, sideBySide: true});

  $('input[type=checkbox][data-toggle^=toggle]').bootstrapToggle();
}

// $(document).ready(function () {
// 	init_views();
// });

$(document).on("turbolinks:load", function() {
	init_views();
});

$(document).on('nested:fieldAdded', function(event){
	console.log("fieldAdded");
  init_views();
})