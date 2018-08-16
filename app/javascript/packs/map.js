import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';

const mapElement = document.getElementById('map');
if (mapElement) { // don't try to build a map if there's no div#map to inject in
  const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);

  // markers.forEach((marker) => {
  //   var contentString = '<%= link_to vessel_path(vessel) do %>' +
  // '<div id="content">' +
  //     '<div class="content-title">' +
  //     '<%= marker[:title] %>' +
  //     '</div>' +
  //     '<div class="content-img" style="background-image: linear-gradient(-225deg, rgba(0,0,0,0.5) 0%, rgba(0,0,0,0.5) 50%), url(<%= marker[:photo].url(:card) %>)";></div>' +
  //     '</div>' +
  //     '<% end %>'

  //   var infowindow = new google.maps.InfoWindow({
  //   content: contentString
  //   });

  //   marker.addListener('click', function() {
  //   infowindow.open(map, marker);
  //   });

  // })

  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    console.log("hello");
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(5);
  } else {
    map.fitLatLngBounds(markers);
  }

}

autocomplete();
