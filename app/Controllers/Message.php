<?php

namespace App\Controllers;

use App\Models\MessageModel;
use App\Models\CommuneModel;

class Message extends BaseController
{
    private $messageModel;
    private $communeModel;
    private $prestataireModel;

    public function __construct()
    {
        $this->messageModel = model('MessageModel');
        $this->communeModel = model('CommuneModel');
        $this->prestataireModel = model('Prestataire');
    }

    // Afficher tous les messages
    public function index(): string
    {
        $user = auth()->user();
        if (!$user->inGroup('admin')) {
            $userId = $user->IDCOMMUNE;
            // dd($userId);
            $listeMessages = $this->messageModel->getAllMessageByCommune($userId);
            // var_dump($user);
            // var_dump($listeMessages);
            // die();
            return view('messages/gestion_message', [
                'messages' => $listeMessages
            ]);
        }

        $messages = $this->messageModel->findJoinAll();

        // var_dump($messages);
        // die();

        return view('messages/gestion_message', [
            'messages' => $messages
        ]);
    }

    // Afficher le formulaire pour ajouter un message
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
            $prestataires = $this->prestataireModel->findAll();


            return view('messages/ajout_message', [
                'communeId' => $userId,
                'nomCommune' => $communeNom,
                'deptNum' => $deptNum,
                'listePrestataires' => $prestataires
            ]);
        } else {

            $communes = $this->communeModel->findAll();
            // dd($communes);
            $prestataires = $this->prestataireModel->findAll();
            return view('messages/ajout_message', [
                'listeCommunes' => $communes,
                'listePrestataires' => $prestataires
            ]);
        }
    }

    // Créer un nouveau message
    public function create()
    {
        $message = $this->request->getPost();
        // dd($message);
        $this->messageModel->insert($message);
        return redirect('message');
    }

    // Afficher le formulaire pour modifier un message
    public function modif($id): string
    {
        $message = $this->messageModel->find($id);
        $prestataires = $this->prestataireModel->findAll();

        return view('messages/modifier_message', [
            'message' => $message,
            'listeCommune' => $this->communeModel->findAll(),
            'listePrestataires' => $prestataires
        ]);
    }

    // Mettre à jour un message
    public function update()
    {
        $messageData = $this->request->getPost();
        // var_dump($messageData);
        // die();
        $this->messageModel->update($messageData['IDMESSAGE'], $messageData);  // Sauvegarde directement les données envoyées
        return redirect('message');
    }

    // Supprimer un message
    public function delete()
    {
        $this->messageModel->delete($this->request->getPost('IDMESSAGE'));  // Suppression du message avec l'ID via POST
        return redirect('message');
    }

    // Afficher les détails d'un message
    public function view($id): string
    {
        $message = $this->messageModel->find($id);
        return view('messages/view_message', [
            'message' => $message
        ]);
    }
}
