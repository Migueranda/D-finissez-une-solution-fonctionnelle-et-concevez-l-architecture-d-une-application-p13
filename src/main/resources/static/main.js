/**
Classe pour gérer le chat en ligne : cette  classe gère la connexion au serveur,
l'envoi et la réception des messages, ainsi que la mise à jour de l'interface utilisateur
**/
class ChatClient {
    constructor() {

        this.client = null; // Instance du client STOMP pour gérer la communication via WebSocket
        this.username = "";
        this.serverUrl = "/chat-connection";// URL de l'endpoint WebSocket côté serveur
        this.messageDestination = "/chatroom/updates";// Destination STOMP pour recevoir les messages diffusés par le serveur
        this.sendDestination = "/chat/message";// Destination STOMP pour envoyer les messages au serveur


        // Initialisation des événements
        this.initEventListeners();
        // Mise à jour de l'interface utilisateur
        this.updateUI(false);
    }

    // Méthode pour initialiser les événements des boutons
    initEventListeners() {
        document.querySelector("#connect-button").addEventListener("click", () => this.connect());
        document.querySelector("#disconnect-button").addEventListener("click", () => this.disconnect());
        document.querySelector("#send-button").addEventListener("click", () => this.sendMessage());
    }

    // Met à jour l'interface utilisateur en fonction de l'état de connexion
    updateUI(isConnected) {
        // Avant connexion
        document.querySelector("#username").style.display = isConnected ? "none" : "block";
        document.querySelector("#connect-button").style.display = isConnected ? "none" : "block";

        // Après connexion
        document.querySelector("#message-input").style.display = isConnected ? "block" : "none";
        document.querySelector("#send-button").style.display = isConnected ? "block" : "none";
        document.querySelector("#disconnect-button").style.display = isConnected ? "block" : "none";

        // Zone de chat
        document.querySelector("#chatroom").style.display = isConnected ? "block" : "none";
    }

    // Connexion au serveur
    connect() {
        this.username = document.querySelector("#username").value;
        if (!this.username) {
            alert("Veuillez entrer votre prénom pour vous connecter.");
            return;
        }
        // Initialise une connexion WebSocket via SockJS
        const socket = new SockJS(this.serverUrl);
        // Crée une instance de STOMP pour gérer les messages via WebSocket
        this.client = Stomp.over(socket);

        console.log("Tentative de connexion...");

        // Établit la connexion avec le serveur
        this.client.connect({}, (frame) => {
            console.log("Connecté : ", frame);
            this.updateUI(true);
            // S'abonne à la destination pour recevoir les messages diffusés par le serveur
            this.client.subscribe(this.messageDestination, (response) => {
                console.log("Message reçu : ", response.body);
                const { username, message } = JSON.parse(response.body);
                this.displayMessage(username, message);
            });
        }, (error) => {
            console.error("Erreur de connexion : ", error);
        });
    }

    // Déconnexion du serveur WebSocket
    disconnect() {
        if (this.client) {
            this.client.disconnect(() => {
                console.log("Déconnecté");
            });
        }
        this.updateUI(false); // Mise à jour de l'interface après déconnexion
    }

    // Envoi d'un message au serveur
    sendMessage() {
        const message = document.querySelector("#message-input").value;
        if (!message) {
            alert("Veuillez entrer un message avant d'envoyer.");
            return;
        }

        console.log("Envoi du message : ", message);
        // Envoie le message au serveur (au format JSON) via STOMP
        this.client.send(this.sendDestination, {}, JSON.stringify({ username: this.username, message }));
        document.querySelector("#message-input").value = "";
    }

    // Affichage des messages reçus
    displayMessage(username, message) {
        const chatroom = document.querySelector("#chatroom");
        const messageElement = document.createElement("p");
        messageElement.textContent = `${username}: ${message}`;
        chatroom.appendChild(messageElement);
    }
}

// Initialise l'application lorsqu'elle est entièrement chargée
document.addEventListener("DOMContentLoaded", () => {
    new ChatClient();
});
