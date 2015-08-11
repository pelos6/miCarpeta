/**
 * Desarrollo Web en Entorno Servidor
 * Proyecto MiCarpeta:
 * codigo.js 
 */
window.onload = mostrarActoEleccionMapa;
function mostrarActoEleccionMapa(idActoEleccion) {
    console.log('en mostrarActoEleccionMapa ----' + idActoEleccion);
    // tomo la información de la pantalla
    latitud = $('input[name="latitud"]');
    longitud = $('input[name="longitud"]');
    descripcion = $('input[name="descripcion"]');

    vacantes = [];
    inputs = $('input[name="vacantes"]');
    vacantes = [];
          
    for(var i=0, len=latitud.length; i<len; i++){

        if(latitud[i].type === "hidden"){
            vacante = {latitud: latitud[i].value, longitud: longitud[i].value, descripcion: descripcion[i].value};
            vacantes.push(vacante);
        }
    }
      
    //console.log(vacantes);
    // zaragoza
    var myCenter = new google.maps.LatLng(41.65, -0.883333);
    var bounds = new google.maps.LatLngBounds();
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
            $.each(vacantes, function(key, value) {
               // console.log('en el loop de las vacantes '+ key + '  '+ value['latitud'] + '  '+ value['longitud']);
                var myLatLng = new google.maps.LatLng(value['latitud'], value['longitud']);
                var marker = new google.maps.Marker({
                    position: myLatLng,
                    title: value['descripcion'],
                    map: map,
                });
                // calcula los límites
                bounds.extend(myLatLng);
            });
        });
    }
    /**/
    var mapProp = {
        center: myCenter,
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
