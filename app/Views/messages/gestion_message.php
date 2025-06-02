<?= $this->extend('layout')  ?>

<?= $this->section('contenu') ?>

<?php

use \CodeIgniter\View\Table;

$table = new Table();

?>

<a class="button" href="<?= url_to('ajoutMessage') ?>">Ajouter un message</a>

<?php

$table->setHeading('État', 'Texte', 'Caractéristiques', 'Prestataire', 'Modifier', 'Supprimer');



foreach ($messages as $message) {
    // var_dump($message);
    // die();
    $table->addRow(
        $message['ETAT'],
        $message['TEXTE'],
        $message['COULEUR'],
        $message['NOMPRESTATAIRE'],
        // $message['TAILLE'],
        '<a class="button" href="' . url_to('modifMessage', $message['IDMESSAGE']) . '">Modifier</a>',
        '<form method="post" class="form" action="' . url_to('supprMessage', $message['IDMESSAGE']) . '">
            <input type="hidden" name="IDMESSAGE" value="' . $message['IDMESSAGE'] . '">
            <input type="submit" value="Supprimer">
        </form>'
    );
}

echo $table->generate();

?>

<?= $this->endSection() ?>