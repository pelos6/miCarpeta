  <div class="alert alert-success">
        <?php
        $solicitudesConcursosPrimaria = $clienteConcursosPrimaria->getSolicitudesConcursos(Yii::$app->user->identity->dni);
        foreach ($solicitudesConcursosPrimaria as $solicitudConcurso) {
            echo $solicitudConcurso->des_con . ' ' . $solicitudConcurso->cod_sol . ' ' . $solicitudConcurso->estado . ' ' . $solicitudConcurso->fechagrabacion . "<br />\n";
        }
        
        $solicitudesConcursosSecundaria = $clienteConcursosSecundaria->getSolicitudesConcursos(Yii::$app->user->identity->dni);
        foreach ($solicitudesConcursosSecundaria as $solicitudConcurso) {
            echo $solicitudConcurso->des_con . ' ' . $solicitudConcurso->cod_sol . ' ' . $solicitudConcurso->estado . ' ' . $solicitudConcurso->fechagrabacion . "<br />\n";
        }

//    echo("<pre>");
//    print_r($solicitudesConcursos);
//    echo ("</pre>");
        ?>