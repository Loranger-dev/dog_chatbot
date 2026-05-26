// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


// ========================================================
// LOGIQUE JAVASCRIPT DU CHATBOT (Niveau Débutant / Le Wagon)
// ========================================================

// 1. Sélection et stockage des éléments HTML importants dans des variables
const chatForm = document.getElementById('chatForm');
const userInput = document.getElementById('userInput');
const chatWindow = document.getElementById('chatWindow');

/**
 * Fonction réutilisable pour créer et ajouter une bulle de texte dans le chat
 * @param {string} text - Le texte du message à afficher
 * @param {string} sender - L'expéditeur du message ('user' ou 'ai')
 */
function appendMessage(text, sender) {

    // Étape A : Création de la boîte principale (le conteneur du message)
    const wrapper = document.createElement('div');
    wrapper.classList.add('message-wrapper', 'mb-4');

    // Étape B : Création du petit texte au-dessus de la bulle (le nom)
    const label = document.createElement('small');
    label.classList.add('text-muted', 'd-block', 'mb-1', 'ms-1');

    // Étape C : Création de la bulle de texte colorée
    const bubble = document.createElement('div');
    bubble.classList.add('message', 'p-3', 'rounded-4');
    bubble.textContent = text; // On injecte le texte de manière sécurisée (.textContent)

    // Étape D : Personnalisation selon l'expéditeur (Utilisateur ou IA)
    if (sender === 'user') {
        wrapper.classList.add('user-wrapper'); // Aligne à droite
        label.textContent = 'username';
        bubble.classList.add('user-message');  // Applique le style gris utilisateur
    } else {
        wrapper.classList.add('ai-wrapper');   // Aligne à gauche
        label.textContent = 'ai assistant';
        bubble.classList.add('ai-message');    // Applique le style blanc/gris IA
    }

    // Étape E : Assemblage des éléments créés et insertion dans la fenêtre de chat
    wrapper.appendChild(label);
    wrapper.appendChild(bubble);
    chatWindow.appendChild(wrapper);

    // Étape F : Forcer le défilement automatique vers le bas pour voir le nouveau message
    chatWindow.scrollTop = chatWindow.scrollHeight;
}

// 2. Écouteur d'événement : Déclenché quand l'utilisateur valide le formulaire (Touche Entrée)
chatForm.addEventListener('submit', (event) => {

    // Bloque le rechargement automatique de la page internet
    event.preventDefault();

    // Récupère le texte tapé par l'utilisateur en enlevant les espaces inutiles au début/fin
    const messageText = userInput.value.trim();

    // On vérifie que le message n'est pas vide avant de l'envoyer
    if (messageText !== '') {

        // 1. On affiche immédiatement le message de l'utilisateur
        appendMessage(messageText, 'user');

        // 2. On vide le champ de texte pour le prochain message
        userInput.value = '';

        // 3. On simule un temps de réflexion de l'IA (1 seconde d'attente)
        setTimeout(() => {
            appendMessage("Wouf ! C'est une excellente question pour l'évaluation du Wagon. Mon backend Ruby on Rails sera bientôt connecté !", 'ai');
        }, 1000);
    }
});
// ========================================================
// LOGIQUE JAVASCRIPT DU CHATBOT (Niveau Débutant / Le Wagon)
// ========================================================

// 1. Sélection et stockage des éléments HTML importants dans des variables
const chatForm = document.getElementById('chatForm');
const userInput = document.getElementById('userInput');
const chatWindow = document.getElementById('chatWindow');

/**
 * Fonction réutilisable pour créer et ajouter une bulle de texte dans le chat
 * @param {string} text - Le texte du message à afficher
 * @param {string} sender - L'expéditeur du message ('user' ou 'ai')
 */
function appendMessage(text, sender) {

    // Étape A : Création de la boîte principale (le conteneur du message)
    const wrapper = document.createElement('div');
    wrapper.classList.add('message-wrapper', 'mb-4');

    // Étape B : Création du petit texte au-dessus de la bulle (le nom)
    const label = document.createElement('small');
    label.classList.add('text-muted', 'd-block', 'mb-1', 'ms-1');

    // Étape C : Création de la bulle de texte colorée
    const bubble = document.createElement('div');
    bubble.classList.add('message', 'p-3', 'rounded-4');
    bubble.textContent = text; // On injecte le texte de manière sécurisée (.textContent)

    // Étape D : Personnalisation selon l'expéditeur (Utilisateur ou IA)
    if (sender === 'user') {
        wrapper.classList.add('user-wrapper'); // Aligne à droite
        label.textContent = 'username';
        bubble.classList.add('user-message');  // Applique le style gris utilisateur
    } else {
        wrapper.classList.add('ai-wrapper');   // Aligne à gauche
        label.textContent = 'ai assistant';
        bubble.classList.add('ai-message');    // Applique le style blanc/gris IA
    }

    // Étape E : Assemblage des éléments créés et insertion dans la fenêtre de chat
    wrapper.appendChild(label);
    wrapper.appendChild(bubble);
    chatWindow.appendChild(wrapper);

    // Étape F : Forcer le défilement automatique vers le bas pour voir le nouveau message
    chatWindow.scrollTop = chatWindow.scrollHeight;
}

// 2. Écouteur d'événement : Déclenché quand l'utilisateur valide le formulaire (Touche Entrée)
chatForm.addEventListener('submit', (event) => {

    // Bloque le rechargement automatique de la page internet
    event.preventDefault();

    // Récupère le texte tapé par l'utilisateur en enlevant les espaces inutiles au début/fin
    const messageText = userInput.value.trim();

    // On vérifie que le message n'est pas vide avant de l'envoyer
    if (messageText !== '') {

        // 1. On affiche immédiatement le message de l'utilisateur
        appendMessage(messageText, 'user');

        // 2. On vide le champ de texte pour le prochain message
        userInput.value = '';

        // 3. On simule un temps de réflexion de l'IA (1 seconde d'attente)
        setTimeout(() => {
            appendMessage("Wouf ! C'est une excellente question pour l'évaluation du Wagon. Mon backend Ruby on Rails sera bientôt connecté !", 'ai');
        }, 1000);
    }
});
