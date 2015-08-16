/**
 * Desarrollo Web en Entorno Servidor
 * Proyecto MiCarpeta:
 * codigo.js 
 */

function mostrarActoEleccionMapa(cuerpo_especialidad) {

    console.log('en mostrarActoEleccionMapa ----' + cuerpo_especialidad + ' '+ cuerpo_especialidad.length);
    if (typeof cuerpo_especialidad.length === 'undefined'){
        cuerpo_especialidad = null;
    }
    // tomo la información de la pantalla
    cue_esp = $('input[name="cue_esp"]');
    latitud = $('input[name="latitud"]');
    longitud = $('input[name="longitud"]');
    descripcion = $('input[name="descripcion"]');

    //vacantes = [];
   // inputs = $('input[name="vacantes"]');
    vacantes = [];
          
    for(var i=0, len=latitud.length; i<len; i++){

        if(latitud[i].type === "hidden"){
            console.log('comparando '+ cuerpo_especialidad + ' con  '+ cue_esp[i].value );
            if ((cue_esp[i].value == cuerpo_especialidad) || (cuerpo_especialidad == null)) {
                vacante = {latitud: latitud[i].value, longitud: longitud[i].value, descripcion: descripcion[i].value};
                vacantes.push(vacante);
            }
        }
    }
      
    //console.log(vacantes);
    // zaragoza
    var myCenter = new google.maps.LatLng(41.65, -0.883333);
    var bounds = new google.maps.LatLngBounds();
    var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var labelIndex = 0;
    //http://ex-ample.blogspot.com.es/2011/08/all-url-of-markers-used-by-google-maps.html
 /*   var iconos = 
    ["http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
     "http://maps.google.com/mapfiles/ms/icons/red-dot.png",
     "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
     "http://maps.google.com/mapfiles/ms/icons/green-dot.png",
     "http://maps.google.com/mapfiles/ms/icons/orange-dot.png",
      "http://maps.google.com/mapfiles/ms/icons/purple-dot.png"];*/
          var iconos = 
    ["http://maps.google.com/mapfiles/ms/icons/blue.png",
     "http://maps.google.com/mapfiles/ms/icons/red.png",
     "http://maps.google.com/mapfiles/ms/icons/yellow.png",
     "http://maps.google.com/mapfiles/ms/icons/green.png",
     "http://maps.google.com/mapfiles/ms/icons/orange.png",
      "http://maps.google.com/mapfiles/ms/icons/purple.png"];
      var iconosIndex = 0;
    /**/
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            // myCenter = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
            map.setCenter(myCenter);
            /*var marker = new google.maps.Marker({
                position: myCenter,
                animation: google.maps.Animation.BOUNCE
            });
            marker.setMap(map);*/
            var pinColor = "FEEE69";
             var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + pinColor,
                new google.maps.Size(21, 34),
                new google.maps.Point(0,0),
                new google.maps.Point(10, 34));
            $.each(vacantes, function(key, value) {
               // console.log('en el loop de las vacantes '+ key + '  '+ value['latitud'] + '  '+ value['longitud']);
                var myLatLng = new google.maps.LatLng(value['latitud'], value['longitud']);
                var marker = new google.maps.Marker({
                    position: myLatLng,
                    title: value['descripcion'],
                   // label: labels[labelIndex++ % labels.length],
                    //icon : 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png',
                    icon : iconos[iconosIndex++  % iconos.length],
                    map: map,
                });
                // Zoom to 9 when clicking on marker
                    google.maps.event.addListener(marker,'click',function() {
                      map.setZoom(9);
                      map.setCenter(marker.getPosition());
                      });
                    var infowindow = new google.maps.InfoWindow({
                      content:"Hello World! " + value['descripcion']
                      });

                    google.maps.event.addListener(marker, 'click', function() {
                      infowindow.open(map,marker);
                      });
                // calcula los límites
                bounds.extend(myLatLng);
            });
        });
    }
    /**/
    var mapProp = {
        center: myCenter,
        disableDefaultUI:true,
       // zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
    // centra el mapa en los límites
    map.fitBounds(bounds);

}






function abrirMaps(coordenadas) {
    var url = "http://maps.google.com/maps?hl=es&t=h&z=17&output=embed&ll=";

    if (!coordenadas) {
        // Cogemos las coordenadas del diálogo
        url += $("#latitud").val() + "," + $("#longitud").val();
    } else {
        // Si hay coordenadas, las usamos
        url += coordenadas;
    }
    console.log('la url de la ventana que se va a abrir:' + url);
    window.open(url, 'nuevaventana', 'width=425,height=350');
}

window.onload = mostrarActoEleccionMapa;
