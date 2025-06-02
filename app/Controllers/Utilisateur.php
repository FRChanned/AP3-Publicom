<?php

namespace App\Controllers;

use App\Models\UtilisateurModel;
use App\Models\CommuneModel;
use CodeIgniter\Shield\Entities\User;

class Utilisateur extends BaseController
{
    private $userModel;
    private $communeModel;

    // Constructeur Instanciant les variables userModel et communeModel
    public function __construct()
    {
        $this->userModel = model('UserModel');
        $this->communeModel = model('CommuneModel');
    }

    // Méthode Affichant la liste des utilisateurs
    public function index()
    {
        /* On vérifie si l'utilisateur est authentifié.
        *
        *  Si l'utilisateur ne fait pas partie du groupe admin,
        *  alors il sera redirigé vers la page d'accueil du site.
        */ 
        $user = auth()->user();
        if (! $user->inGroup('admin')) {
            return redirect('index');
        }

        $users = $this->userModel->getAll();

        // var_dump($users);
        // die();

        return view('utilisateurs/gestion_utilisateur', [
            'listeUtilisateur' => $users
        ]);
    }

    // Méthode qui renvoie le formulaire d'ajout d'un utilisateur (avec la liste des communes)
    public function ajout()
    {
        $user = auth()->user();
        if (! $user->inGroup('admin')) {
            return redirect('index');
        }
        $commune = $this->communeModel->findAll();
        return view('utilisateurs/ajout_utilisateur', [
            'listeUtilisateur' => $commune
        ]);
    }

    // Méthode effectuant la création en base de données du compte utilisateur
    public function create()
    {
        // Get the User Provider (UserModel by default)
        $users = auth()->getProvider();

        $user = new User([
            'username' => $this->request->getPost('IDENTIFIANT'),
            'email'    => $this->request->getPost('MAIL'),
            'password' => $this->request->getPost('MOTDEPASSE'),
            'IDCOMMUNE' => $this->request->getPost('IDCOMMUNE'),
        ]);

        // var_dump($userData);
        // die();
        $users->save($user);

        // To get the complete user object with ID, we need to get from the database
        $userId = $users->findById($users->getInsertID());

        // Add to default group
        $users->addToDefaultGroup($userId);

        return redirect('utilisateur');
    }

    // Méthode qui renvoie le formulaire de modification d'un utilisateur (avec la liste des communes)
    public function modif($userId)
    {
        $user = auth()->user();
        if (! $user->inGroup('admin')) {
            return redirect('index');
        }
        $user = $this->userModel->getById($userId);
        $commune = $this->communeModel->findAll();
        $communeDefault = $this->userModel->getCommuneDefault($userId);
        // var_dump($communeDefault);
        // var_dump($users);
        // var_dump($commune);
        // die();
        return view('utilisateurs/modifier_utilisateur', [
            'utilisateurs' => $user,
            'listeCommune' => $commune,
            'commune' => $communeDefault
        ]);
    }

    // Méthode effectuant la mise à jour en base de données du compte utilisateur
    public function update()
    {
        // Get the User Provider (UserModel by default)
        $users = auth()->getProvider();

        $userId = $this->request->getPost(); // Récupère les infos du formulaire de modif

        // var_dump($userId);
        // die();

        $user = $users->getById($userId['IDUTILISATEUR']); // Récupère l'ID de l'utilisateur
        // var_dump($this->request->getPost(['IDCOMMUNE']));
        // die();
        $userIdCommune = $this->request->getPost(['IDCOMMUNE']); // Récupère l'ID de la commune de l'utilisateur
        // var_dump($userIdCommune);
        // die();
        if ($userIdCommune != 0) { // Si l'ID de la commune de l'utilisateur est différent de 0
            $user->fill([
                'username' => $this->request->getPost('IDENTIFIANT'),
                'email' => $this->request->getPost('MAIL'),
                'password' => $this->request->getPost('MOTDEPASSE'),
                'IDCOMMUNE' => $this->request->getPost('IDCOMMUNE'),
            ]);
            $users->save($user);
        }
        return redirect('utilisateur');
    }

    // Méthode effectuant la suppression en base de données du compte utilisateur
    public function delete()
    {
        $idUser = $this->request->getPost(['IDUTILISATEUR']); // Récup ID Utilisateur

        // Get the User Provider (UserModel by default)
        $users = auth()->getProvider();

        $users->delete($idUser['IDUTILISATEUR'], true); // Supprime l'utilisateur en base ayant l'ID récupéré au préalable
        return redirect('utilisateur');
    }
}
