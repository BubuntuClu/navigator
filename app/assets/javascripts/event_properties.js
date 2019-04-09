ymaps.ready(init);
var myMap;

function init () {
  myMap = new ymaps.Map("map_window", {
      center: [55.753215, 37.622504],
      zoom: 15
  });
}
