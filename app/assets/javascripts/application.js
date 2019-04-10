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
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .

$( document ).ready(function() {
  ymaps.ready(init);
});

function init () {
  var myMap = new ymaps.Map("map_window", {
      center: [55.753215, 37.622504],
      zoom: 15
  });

  myMap.events.add('click', function (e) {
    var coords = e.get('coords');
    $.ajax({
      url: window.location.href + "/show_distance" ,
      data: { latitude: coords[0].toPrecision(6), longitude: coords[1].toPrecision(6) },
      type: "GET",
      dataType: "json",
      success: function(data){
        build_distance_table(data.building_distance)
      },
      error: function(data){
        console.log(data);
        alert('smtng went wrong;');
      }
    });
  });
}

function build_distance_table(building_distances) {
  var tbody = document.getElementsByTagName('TBODY')[0];
  if (tbody)
    tbody.remove();

  var table = document.getElementById("distance");

  var tableBody = document.createElement('TBODY');
  table.appendChild(tableBody);

  for (var i = 0; i < building_distances.length - 1; i++) {
    var tr = document.createElement('TR');
    tableBody.appendChild(tr);

    append_cell_to_row(tr, i + 1);
    append_cell_to_row(tr, building_distances[i].address);
    append_cell_to_row(tr, building_distances[i].distance);
  }
}

function append_cell_to_row(tr, text){
  var td = document.createElement('TD');
  td.appendChild(document.createTextNode(text));
  tr.appendChild(td);
}
