<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
$this->title = 'Conversión';
$this->params['breadcrumbs'][] = $this->title;
//$url="especificar la ubicación absoluta del fichero que contiene el objeto SoapServer";
//$uri="especificar el directorio donde está el fichero"
//$url = "http://localhost/cicloFormativoGradoSuperior/DAW_DWES/tema_6_serviciosWeb/practica9_1/servicio.php";
//$uri = "http://localhost/cicloFormativoGradoSuperior/DAW_DWES/tema_6_serviciosWeb/practica9_1";
$url = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta/servicio.php";
$uri = "http://localhost/CicloFormativoGradoSuperior/practicas_propias/php/serviciosMiCarpeta";
//Creamos un cliente para llamar a esa URL. 
//Es obligatorio establecer el parámetro 'uri' al no tener WSDL , igual que ocurría al instanciar el objeto SoapServer
$cliente = new SoapClient(null, array('location' => $url, 'uri' => $uri));
echo 'Ahora por ejemplo podemos consumir el servicio contra la base de datos serviciosMiCarpeta';

//echo $cliente->getPVP('KSTDTG332GBR');
?>
   <div class="alert alert-success">
       <?php
       echo $cliente->getEstaConvocado('KSTDTG332GBR');
       ?>
    </div>
<?php
/*echo "probando lo de la isla ";
print("la ultima peticion" . $cliente->__getLastRequest() . "<br>");
print("la ultima respuesta" . $cliente->__getLastResponse() . "<br>");
print("cabecera de la ultima peticion" . $cliente->__getLastRequestHeaders() . "<br>");
print("cabecera de la ultima respuesta" . $cliente->__getLastResponseHeaders() . "<br>");
echo $cliente->login('isla@hotmail.com', 'Visual12');
 * */

?>
<!DOCTYPE html>
<html>
    <head>
        <title>conversion de monedas</title>
        <meta charset="UTF-8">
        <meta name="viewport"content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h1>Actividad conversión de monedas con WSDL </h1>
        <form action=""method ="POST">
            Importe en euros <input type="text"name="euros">
            selecciona importe destino
            <select name="moneda"id="">
                <option value ="ALL">ALL</option>
                <option value ="DZD">DZD</option>
                <option value ="ARS">ARS</option>
                <option value ="AWG">AWG</option>
                <option value ="AUD">AUD</option>
                <option value ="BSD">BSD</option>
                <option value ="BHD">BHD</option>
                <option value ="BDT">BDT</option>
                <option value ="BBD">BBD</option>
                <option value ="BZD">BZD</option>
                <option value ="BMD">BMD</option>
                <option value ="BTN">BTN</option>
                <option value ="BOB">BOB</option>
                <option value ="BWP">BWP</option>
                <option value ="BRL">BRL</option>
                <option value ="GBP">GBP</option>
                <option value ="BND">BND</option>
                <option value ="BIF">BIF</option>
                <option value ="XOF">XOF</option>
                <option value ="XAF">XAF</option>
                <option value ="KHR">KHR</option>
                <option value ="CAD">CAD</option>
                <option value ="CVE">CVE</option>
                <option value ="KYD">KYD</option>
                <option value ="CLP">CLP</option>
                <option value ="CNY">CNY</option>
                <option value ="COP">COP</option>
                <option value ="KMF">KMF</option>
                <option value ="CRC">CRC</option>
                <option value ="HRK">HRK</option>
                <option value ="CUP">CUP</option>
                <option value ="CYP">CYP</option>
                <option value ="CZK">CZK</option>
                <option value ="DKK">DKK</option>
                <option value ="DJF">DJF</option>
                <option value ="DOP">DOP</option>
                <option value ="XCD">XCD</option>
                <option value ="EGP">EGP</option>
                <option value ="SVC">SVC</option>
                <option value ="EEK">EEK</option>
                <option value ="ETB">ETB</option>
                <option value ="EUR">EUR</option>
                <option value ="FKP">FKP</option>
                <option value ="GMD">GMD</option>
                <option value ="GHC">GHC</option>
                <option value ="GIP">GIP</option>
                <option value ="XAU">XAU</option>
                <option value ="GTQ">GTQ</option>
                <option value ="GNF">GNF</option>
                <option value ="GYD">GYD</option>
                <option value ="HTG">HTG</option>
                <option value ="HNL">HNL</option>
                <option value ="HKD">HKD</option>
                <option value ="HUF">HUF</option>
                <option value ="ISK">ISK</option>
                <option value ="INR">INR</option>
                <option value ="IDR">IDR</option>
                <option value ="IQD">IQD</option>
                <option value ="ILS">ILS</option>
                <option value ="JMD">JMD</option>
                <option value ="JPY">JPY</option>
                <option value ="JOD">JOD</option>
                <option value ="KZT">KZT</option>
                <option value ="KES">KES</option>
                <option value ="KRW">KRW</option>
                <option value ="KWD">KWD</option>
                <option value ="LAK">LAK</option>
                <option value ="LVL">LVL</option>
                <option value ="LBP">LBP</option>
                <option value ="LSL">LSL</option>
                <option value ="LRD">LRD</option>
                <option value ="LYD">LYD</option>
                <option value ="LTL">LTL</option>
                <option value ="MOP">MOP</option>
                <option value ="MKD">MKD</option>
                <option value ="MGF">MGF</option>
                <option value ="MWK">MWK</option>
                <option value ="MYR">MYR</option>
                <option value ="MVR">MVR</option>
                <option value ="MTL">MTL</option>
                <option value ="MRO">MRO</option>
                <option value ="MUR">MUR</option>
                <option value ="MXN">MXN</option>
                <option value ="MDL">MDL</option>
                <option value ="MNT">MNT</option>
                <option value ="MAD">MAD</option>
                <option value ="MZM">MZM</option>
                <option value ="MMK">MMK</option>
                <option value ="NAD">NAD</option>
                <option value ="NPR">NPR</option>
                <option value ="ANG">ANG</option>
                <option value ="NZD">NZD</option>
                <option value ="NIO">NIO</option>
                <option value ="NGN">NGN</option>
                <option value ="KPW">KPW</option>
                <option value ="NOK">NOK</option>
                <option value ="OMR">OMR</option>
                <option value ="XPF">XPF</option>
                <option value ="PKR">PKR</option>
                <option value ="XPD">XPD</option>
                <option value ="PAB">PAB</option>
                <option value ="PGK">PGK</option>
                <option value ="PYG">PYG</option>
                <option value ="PEN">PEN</option>
                <option value ="PHP">PHP</option>
                <option value ="XPT">XPT</option>
                <option value ="PLN">PLN</option>
                <option value ="QAR">QAR</option>
                <option value ="ROL">ROL</option>
                <option value ="RUB">RUB</option>
                <option value ="WST">WST</option>
                <option value ="STD">STD</option>
                <option value ="SAR">SAR</option>
                <option value ="SCR">SCR</option>
                <option value ="SLL">SLL</option>
                <option value ="XAG">XAG</option>
                <option value ="SGD">SGD</option>
                <option value ="SKK">SKK</option>
                <option value ="SIT">SIT</option>
                <option value ="SBD">SBD</option>
                <option value ="SOS">SOS</option>
                <option value ="ZAR">ZAR</option>
                <option value ="LKR">LKR</option>
                <option value ="SHP">SHP</option>
                <option value ="SDD">SDD</option>
                <option value ="SRG">SRG</option>
                <option value ="SZL">SZL</option>
                <option value ="SEK">SEK</option>
                <option value ="CHF">CHF</option>
                <option value ="SYP">SYP</option>
                <option value ="TWD">TWD</option>
                <option value ="TZS">TZS</option>
                <option value ="THB">THB</option>
                <option value ="TOP">TOP</option>
                <option value ="TTD">TTD</option>
                <option value ="TND">TND</option>
                <option value ="TRL">TRL</option>
                <option value ="USD">USD</option>
                <option value ="AED">AED</option>
                <option value ="UGX">UGX</option>
                <option value ="UAH">UAH</option>
                <option value ="UYU">UYU</option>
                <option value ="VUV">VUV</option>
                <option value ="VEB">VEB</option>
                <option value ="VND">VND</option>
                <option value ="YER">YER</option>
                <option value ="YUM">YUM</option>
                <option value ="ZMK">ZMK</option>
                <option value ="ZWD">ZWD</option>
                <option value ="_TRY">TRY</option>
            </select>
            <input type="submit"name ="enviar"/>
        </form>
    </body>
</html>
<?php
error_log('DEBUG: 0');
if (isset($_POST['enviar'])) {
    if ($_POST['enviar']) {
        error_log('DEBUG: 1');
        $cliente = new SoapClient("http://www.webservicex.net/CurrencyConvertor.asmx?WSDL", array('trace' => true));
        error_log('DEBUG: 2');
        $parametros = array("FromCurrency" => "EUR", "ToCurrency" => $_POST['moneda']);
        error_log('DEBUG: 3');
        $tasa = $cliente->ConversionRate($parametros);
// $tasa  es  un objeto de una clase predefinida en PHP llamada StdClass. Para utilizar el valor devuelto, puedes hacer:
        error_log('DEBUG: 4');
        $cantidad = $_POST['euros'];
        print("Resultado: $cantidad=" . ($cantidad * $tasa->ConversionRateResult) . "<br>");
        print("la ultima peticion" . $cliente->__getLastRequest() . "<br>");
        print("la ultima respuesta" . $cliente->__getLastResponse() . "<br>");
        print("cabecera de la ultima peticion" . $cliente->__getLastRequestHeaders() . "<br>");
        print("cabecera de la ultima respuesta" . $cliente->__getLastResponseHeaders() . "<br>");
    }
}
?>
