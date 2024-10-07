# 🎮 Jeu 2️⃣0️⃣4️⃣8️⃣

# 🚀 Introduction

Bienvenue dans le projet **2048** ! Ce jeu captivant met nos compétences à l'épreuve pour fusionner des tuiles et atteindre la fameuse tuile 2048. Ce projet est développé en utilisant **Flutter** pour une expérience utilisateur fluide.

---

# 🔍 Description du Projet

2048 est un jeu vidéo de type puzzle, le but du jeu est de faire glisser des tuiles sur une grille, pour combiner les tuiles de mêmes valeurs et créer ainsi une tuile portant le nombre 2048. Le joueur peut toutefois continuer à jouer après cet objectif atteint pour faire le meilleur score possible.

---

# ⚙️ Structure du Projet

Le code source du projet est organisé de manière logique dans le dossier `lib`, comme suit :


### 1. **base**
- Contient les classes principales qui forment le cœur du jeu.

### 2. **directions**
- **axis_movement.dart** : Gère les mouvements des tuiles selon les axes.
- **gesture_directions.dart** : Gère les gestes tactiles pour déplacer les tuiles.

### 3. **elements**
- **action_button.widget.dart** : Gère le bouton d’action, comme “RESTART”.
- **game_grid.widget.dart** : Représente la grille de jeu.
- **game_over.widget.dart** : Affiche l’écran de fin de jeu.
- **gesture_swipe_detector.widget.dart** : Gère les gestes de glissement.
- **score_container.widget.dart** : Affiche le score actuel.
- **score_display.widget.dart** : Affiche les scores de manière attractive.
- **styled_text.widget.dart** : Gère le style du texte affiché.

### 4. **engine**
- **game_engine.dart** : Contient la logique principale du jeu.

### 5. **interface**
- **defeatscreen.dart** : Affiche l’écran de défaite.
- **gamescreen.dart** : L’écran principal du jeu.
- **victoryscreen.dart** : Affiche l’écran de victoire.

### 6. **main.dart**
- Le point d’entrée de l’application.

---

# 🛠️ Cloner le Projet

**Pré-requis** : Assurez-vous d'avoir un émulateur Android ou iOS et le SDK Flutter installé sur votre machine.

1. **Cloner le projet** : 
   ```bash
   git clone https://github.com/aminajalidy/game2048.git
2.  Aller dans le répertoire du projet cd game2048

3.  Installer les dépendances avec `flutter packages get`

4.  Lancer l'application    

