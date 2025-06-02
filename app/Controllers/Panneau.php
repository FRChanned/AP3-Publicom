<?php

namespace App\Controllers;

class Panneau extends BaseController
{

    private $panneauxModel;
    private $communeModel;

    // Constructeur instanciant les variables panneauxModel et communeModel
    public function __construct()
    {
        $this->panneauxModel = model('PanneauModel');
        $this->communeModel = model('CommuneModel');
    }

    // Méthode renvoyant la liste des panneaux
    public function index(): string
    {
        $user = auth()->user();
        if (!$user->inGroup('admin')) {
            $userId = $user->IDCOMMUNE;
            // dd($userId);
            $listePanneau = $this->panneauxModel->getAllPanneauByCommune($userId);
            // var_dump($user);
            // var_dump($listePanneau);
            // var_dump($panneaux);
            // die();
            return view('panneaux/gestion_panneaux', [
                'listePanneaux' => $listePanneau
            ]);
        } else {

            $panneaux = $this->panneauxModel->findJoinAll();

            return view('panneaux/gestion_panneaux', [
                'listePanneaux' => $panneaux
            ]);
        }
    }

    // Méthode qui renvoie le formulaire d'ajout d'un panneau (avec la liste des communes)
    public function ajout(): string
    {
        $user = auth()->user();
        if (!$user->inGroup('admin')) {
            $userId = $user->IDCOMMUNE;
            // dd($userId);
            $communeData = $this->communeModel->findCommuneNomAndDepart($userId);
            // dd($communeData);
            $communeNom = $communeData[0]['NOM'];
            // dd($communeNom);
            $deptNum = $communeData[0]['DEPARTEMENT'];
            // dd($deptNum);


            return view('panneaux/ajout_panneaux', [
                'communeId' => $userId,
                'nomCommune' => $communeNom,
                'deptNum' => $deptNum
            ]);
        } else {
            $communes = $this->communeModel->findCommune();
            // dd($communes);
            return view('panneaux/ajout_panneaux', [
                'commune' => $communes
            ]);
        }
    }

    // Méthode effectuant la création en base de données du panneau
    public function create()
    {
        $panneauAjout = $this->request->getPost(); // Récupération des données du formulaire

        $this->panneauxModel->save($panneauAjout);
        return redirect('panneaux');
    }

    // Méthode qui renvoie le formulaire de modification d'un panneau (avec la liste des communes)
    public function modif($idPanneau): string
    {
        $panneauId = $this->panneauxModel->find($idPanneau); // Récupération des données du panneau avec son id
        $communes = $this->communeModel->findCommune(); // Récupération de la liste des communes
        return view('panneaux/modifier_panneaux', [
            'panneau' => $panneauId,
            'commune' => $communes
        ]);
    }
    
    // Méthode effectuant la mise à jour en base de données du panneau
    public function update()
    {
        $panneau = $this->request->getPost(); // Récupération des données du formulaire
        // var_dump($panneau);
        // die();
        $this->panneauxModel->save($panneau);

        return redirect('panneaux');
    }

    // Méthode effectuant la suppression en base de données du panneau
    public function delete()
    {
        $idPanneau = $this->request->getPost('IDPANNEAU'); // Récup de l'id du panneau
        $this->panneauxModel->delete($idPanneau); // Suppression du panneau avec l'id du panneau récupéré
        return redirect('panneaux');
    }
}
