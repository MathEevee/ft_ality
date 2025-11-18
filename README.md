# 🥊 ft_ality

La finalité du projet est de prendre des combinaisons de touches pour fournir le résultat de l'action.

Exemple dans le jeu _**Mortal Kombat**_ avec _**Kitana**_ :

Twisted Edenian: (F+□), Δ 

Donc on appuie sur deux touches en simultanées et après une autre pour que l'action donnée soit _**Twisted Edenian**_

# 🤖 Project

Pour lancer le projet :

```make```

Puis on lance l'exécutable :

```./ft_ality.lopt <grammar_file.gmr>```

# 📍 Objectif du projet :

On doit utiliser un automate fini.

Un automate est un moyen mathématique de définir un processus avec un nombre limité d'états.

Un automate fini est défini avec cette formule : A = ⟨Q, Σ, Q0, F, δ⟩

- Q est l’ensemble des états de l’automate.

- Σ est l’alphabet d’entrée de l’automate.

- Q₀ est l’état initial, avec Q₀ ∈ Q bien sûr.

- F est l’ensemble des états de reconnaissance (ou états finaux), avec F ⊆ Q.

- δ est une fonction qui définit les transitions de l’automate ; une transition est un état associé à une paire composée d’un état et d’un symbole de l’alphabet, ce qui fait que le type de la fonction est Q × Σ → Q.

Version simplifié :

- Un ensemble **fini d’états** (ex. q0,q1,q2q_0, q_1, q_2q0,q1,q2)

- Un **alphabet** (les symboles qu’on peut lire, ex. {a,b}\{a,b\}{a,b})

- Une **fonction de transition** (comment on passe d’un état à un autre quand on lit un symbole)

- Un **état initial** (où on commence toujours)

- Un ou plusieurs **états finaux (ou d’acceptation)**

L'automate utilisé est un automate fini simplifié.

# 🕹️ Utiliser le programme :

1. Choisir les touches liées aux actions.
2. Utiliser les touches choisies pour faire des actions définies dans le "dictionnaire de mouvement" (grammar_file)

Exemples :

| Actions   | Touches clavier |                
|------------|-------------|
| **LEFT**   | ⬅️ |
| **RIGHT**   | ➡️ |
| **UP**   | ⬆️ |
| **DOWN**| ⬇️ |
| **[FP]**   | ⌨️ F |
| **[BP]**   | ⌨️ P |
| **[FK]**   | ⌨️ K |
| **[BK]**  | ⌨️ D |
| **TAG** | ⌨️ A |
| **BLOCK** | ⌨️ B |
| **FLIP STANCE**   | ⌨️ S |
| **Throw**    | ⌨️ T |
---

<img width="161" height="251" alt="Screenshot from 2025-11-18 09-09-56" src="https://github.com/user-attachments/assets/12747955-050a-4012-94a7-9627dbd6ff55" />

Maintenant on va faire des actions :

<img width="442" height="197" alt="Screenshot from 2025-11-18 09-16-30" src="https://github.com/user-attachments/assets/92d2cd73-4f8b-4c28-8937-380995d9fb12" />

<img width="442" height="212" alt="Screenshot from 2025-11-18 09-15-20" src="https://github.com/user-attachments/assets/bcb88dec-b0ba-4a8c-a0e3-baf07834cac1" />


Voilà comment s'affiche les combos trouvés.

# 🗒️ Explications :

<img width="449" height="447" alt="Screenshot from 2025-11-18 09-20-31" src="https://github.com/user-attachments/assets/75d3d07e-5b53-4705-951e-0554c81dac0a" />

On va décomposer les actions :

➡️ : Rien

➡️ ⬇️ : Rien

➡️ ⬇️ ⬅️ : Rien

➡️ ⬇️ ⬅️ ⬆️ : Rien

On arrive au bout, pourquoi ?

Si, au lieu de mettre : ➡️ ⬇️ ⬅️ ⬆️

J'avais mis : ➡️ ⬇️ ⬅️ (⌨️ K) :

<img width="442" height="267" alt="Screenshot from 2025-11-18 09-25-37" src="https://github.com/user-attachments/assets/8e49eecb-2a79-4a1b-8dfb-3bb645b48419" />

J'aurai eu deux combos.

Et ⬇️ ⬆️ donne des combos.

# 💻 📝 Fonctionnement du code :

1. On vérifie les arguments en paramètre.

2. On vérifie le fichier (accès et syntaxe)

3. On lit chaque ligne en vérifiant le format de la ligne qui doit être : "Mouvement avec le combo;action,action(,etc...)".
On peut avoir une ou plusieurs actions, il doit y'avoir une ',' entre chaque action et un ';' entre le combo et les actions.

4. On enregistre dans un "arbre" les différentes suites possibles :
Exemple :

```
LEFT
 ├── [FK]
 │     ├── DOWN
 │     │     ├── [BK]
 │     │     └── LEFT
 │     └── RIGHT
 │           ├── UP
 │           └── BLOCK
 ├── UP
 │     ├── BLOCK
 │     │     └── RIGHT
 │     └── DOWN
 │           ├── UP
 │           └── [FK]
 └── LEFT
       ├── RIGHT
       │     ├── [BK]
       │     └── DOWN
       └── [FK]

RIGHT
 ├── LEFT
 │     ├── [FK]
 │     │     ├── DOWN
 │     │     └── UP
 │     └── BLOCK
 │           └── RIGHT
 ├── UP
 │     ├── LEFT
 │     ├── [BK]
 │     └── DOWN
 │           └── BLOCK
 └── DOWN
       ├── RIGHT
       │     └── UP
       └── [FK]

UP
 ├── RIGHT
 │     ├── [BK]
 │     │     ├── BLOCK
 │     │     └── LEFT
 │     ├── DOWN
 │     └── [FK]
 ├── BLOCK
 │     └── UP
 │           ├── RIGHT
 │           └── [BK]
 └── LEFT
       ├── DOWN
       │     └── [FK]
       └── UP

DOWN
 ├── BLOCK
 │     ├── DOWN
 │     │     ├── LEFT
 │     │     └── RIGHT
 │     └── UP
 │           ├── [BK]
 │           └── BLOCK
 ├── LEFT
 │     ├── [FK]
 │     │     └── DOWN
 │     └── RIGHT
 │           ├── UP
 │           └── LEFT
 └── [FK]
       ├── BLOCK
       ├── UP
       │     └── LEFT
       └── DOWN
             ├── RIGHT
             └── [BK]
```

Quand on enregistre, si en remontant on tombe sur une suite qui existe on ajoute un mouvement de combo qui sera ajouter à une liste de string.

Chaque "node" équivaut à un combo avec une liste de string vide ou avec plusieurs mouvements.

5. On ouvre la fenêtre graphique qui permet de récupérer les touches, on les lie à une action unique.

6. On lance l'automate, les touches sont liées aux actions puis on descend dans les branches de l'arbre jusqu'a ne plus avoir de solution (une erreur ou plus de suite), on affiche le résultat de la combinaison de touche.

7. Quand esc. ou la croix de la fenêtre est utilisée on quitte le programme et la fenêtre se ferme.
