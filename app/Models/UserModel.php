<?php

declare(strict_types=1);

namespace App\Models;

use CodeIgniter\Shield\Models\UserModel as ShieldUserModel;

class UserModel extends ShieldUserModel
{

    protected function initialize(): void
    {
        parent::initialize();

        $this->allowedFields = [
            ...$this->allowedFields,
            'IDCOMMUNE',

        ];
    }

    /* Retourne la liste des utilisateurs
    *
    *  @param none
    */
    public function getAll() //pour index utilisateur
    {
        return $this->select('commune.NOM, commune.DEPARTEMENT, auth_identities.secret AS user_mail, users.id')
            ->join('auth_identities', 'users.id = auth_identities.user_id')
            ->join('auth_groups_users', 'users.id = auth_groups_users.user_id AND auth_groups_users.group <> "admin"')
            ->join('commune', 'users.IDCOMMUNE = commune.IDCOMMUNE')
            ->findAll();
    }

    /* Retourne l'utilisateur selon l'id donné en paramètre
    *
    *  @param $userId
    */
    public function getById($userId) //pour modif
    {
        return $this->select('users.id, users.IDCOMMUNE, users.username, auth_identities.secret AS user_mail, auth_identities.secret2 as passwd')
        ->join('auth_identities', 'users.id = auth_identities.user_id')
        ->join('auth_groups_users', 'users.id = auth_groups_users.user_id AND auth_groups_users.group <> "admin"')
        ->join('commune', 'users.IDCOMMUNE = commune.IDCOMMUNE')
        ->where('users.id = '. $userId)
        ->find($userId);
    }

    /* Retourne la commune auquel l'utilisateur fait partie
    *
    *  @param $userId
    */
    public function getCommuneDefault($userId) //aussi pour modif car besoin de l'idcommune
    {
        return $this->select('*')
        ->join('commune', 'commune.IDCOMMUNE = users.IDCOMMUNE')
        ->where('users.id = ' .$userId)
        ->find();
    }

    /* Retourne les données de l'utilisateur selon
    *  l'id de la commune (l'utilisateur est la commune)
    *
    *  @param $IDCOMMUNE
    */
    public function getIdUser($IDCOMMUNE){
        return $this->select('*')
        ->where('users.IDCOMMUNE', $IDCOMMUNE);
        
    }

    /* Retourne la liste des utilisateurs selon l'id de la commune donné en paramètre
    *
    *  @param $IDCOMMUNE
    */
    public function getAllByIdCommune($IDCOMMUNE) //pour index utilisateur
    {
        return $this->select('commune.NOM, commune.DEPARTEMENT, auth_identities.secret AS user_mail, users.id, users.IDCOMMUNE')
            ->join('auth_identities', 'users.id = auth_identities.user_id')
            ->join('auth_groups_users', 'users.id = auth_groups_users.user_id AND auth_groups_users.group <> "admin"')
            ->join('commune', 'users.IDCOMMUNE = commune.IDCOMMUNE')
            ->where('users.IDCOMMUNE', $IDCOMMUNE)
            ->findAll();
    }

    /* Supprimme la donnée 'AuthIdentities' de la commune de la table auth_identities
    *
    *  @param $idUser
    */
    public function deleteAuthIdentities($idUser){
        $db = \Config\Database::Connect(); // Connexion à la base de données
        $builder = $db->table('auth_identities'); // Récupère la table 'auth_identities'
        $builder->where('auth_identities.user_id', $idUser); // Récupération de la donnée avec l'id de l'utilisateur
        $builder->delete();
    }

    /* Supprimme la donnée 'AuthPermissionsUser' de la commune de la table auth_permissions_users
    *
    *  @param $idUser
    */
    public function deleteAuthPermissionsUsers($idUser){
        $db = \Config\Database::Connect();
        $builder = $db->table('auth_permissions_users');
        $builder->where('auth_permissions_users.user_id', $idUser);
        $builder->delete();
    }
    
    /* Supprimme la donnée 'AuthGroupsUsers' de la commune de la table auth_groups_users
    *
    *  @param $idUser
    */
    public function deleteAuthGroupsUsers($idUser){
        $db = \Config\Database::Connect();
        $builder = $db->table('auth_groups_users');
        $builder->where('auth_groups_users.user_id', $idUser);
        $builder->delete();
    }
    
    /* Supprimme la donnée 'AuthRememberTokens' de la commune de la table auth_remember_tokens
    *
    *  @param $idUser
    */
    public function deleteAuthRememberTokens($idUser){
        $db = \Config\Database::Connect();
        $builder = $db->table('auth_remember_tokens');
        $builder->where('auth_remember_tokens.user_id', $idUser);
        $builder->delete();
    }

    /* Supprimme l'utilisateur après que les méthodes deleteAuthIdentities, deleteAuthPermissionsUsers,
    *  deleteAuthGroupsUsers, deleteAuthRememberTokens soient exécutées.
    *
    *  @param $IDCOMMUNE
    */
    public function deleteUsers($IDCOMMUNE){
        $db = \Config\Database::Connect();
        $builder = $db->table('users');
        $builder->where('users.IDCOMMUNE', $IDCOMMUNE);
        $builder->delete();
    }
}
