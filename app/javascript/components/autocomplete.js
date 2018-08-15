function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var vesselAddress = document.getElementById('vessel_address');

    if (vesselAddress) {
      var autocomplete = new google.maps.places.Autocomplete(vesselAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(vesselAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
