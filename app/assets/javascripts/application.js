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
//= require bootstrap-select
//= require commontator/application
//= require_tree .


function init_views() {
  console.log("init_views");

  $("#sidebar").mCustomScrollbar({
      theme: "minimal"
  });


  $('#sidebarCollapse').on('click', function () {
      $('#sidebar, #content').toggleClass('active');
      $('.collapse.in').toggleClass('in');
      $('a[aria-expanded=true]').attr('aria-expanded', 'false');
  });


  $('#roomsSubmenu').collapse('show');

  $('.timepicker').datetimepicker({format: 'HH:mm', stepping: "5", useCurrent: false});
  $('.weekpicker').datetimepicker({format: 'YYYY-MM-DD', inline: true, sideBySide: true});
  $('#datetimepicker-todo-date').datetimepicker({format: 'YYYY-MM-DD HH:mm', inline: true, sideBySide: true});

  $('input[type=checkbox][data-toggle^=toggle]').bootstrapToggle();

  $(function () {
    $('[data-toggle="popover"]').popover({container: 'body'})

    $("[data-toggle='popover']").on('shown.bs.popover', function(){
      $('#todo_notify').bootstrapToggle()
    });
  })
}

$(document).ready(function () {
	//init_views();
});

$(document).on('turbolinks:load', function() {
   $(window).trigger('load.bs.select.data-api');
});

$(document).on("turbolinks:load", function() {
	init_views();
});

$(document).on('nested:fieldAdded', function(event){
  init_views();
})