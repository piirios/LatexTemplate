# LatexTemplate - Langage de Template LaTeX

**LatexTemplate** est un langage de programmation dédié à la génération dynamique de documents LaTeX. Il combine la logique de programmation avec la puissance typographique de LaTeX.

## 🚀 Compilation et Exécution

```bash
make                              # Compilation
./main fichier.template          # Exécution 
./main fichier.template sortie.tex  # Sauvegarde dans un fichier
./main fichier.template sortie.tex arg1 arg2 arg3 # Sauvegarde dans un fichier avec specification d'argument
DEBUG=1 ./main fichier.template     # Mode debug
```

## 📊 Types de Données

| Type | Exemple | Description |
|------|---------|-------------|
| `int` | `42`, `-10` | Nombres entiers |
| `bool` | `true`, `false` | Booléens |
| `string` | `"texte"` | Chaînes de caractères |
| `array` | `[1, 2, 3]` | Tableaux dynamiques |
| `range` | `1..10`, `5..` | Intervalles (finis/infinis) |
| `template` | `<% template ... %>` | Contenu LaTeX |

## 🎯 Opérateurs

| Catégorie | Opérateurs | Exemple |
|-----------|-----------|---------|
| Arithmétiques | `+`, `-`, `*`, `/`, `%` | `a + b * 2` |
| Comparaisons | `==`, `!=`, `<`, `<=`, `>`, `>=` | `x >= 10` |
| Logiques | `&&`, `\|\|`, `!` | `a && !b` |
| Assignation | `=` | `x = 5` |

## 📝 Syntaxe de Base

### Variables et Types

```javascript
// Déclaration de variables
let nombre = 42;
let texte = "Hello World";
let actif = true;
let tableau = [1, 2, 3, 4, 5];

// Accès aux tableaux
let premier = tableau[0];
tableau[1] = 10;
```

### Structures de Contrôle

```javascript
// Conditions
if nombre > 10 {
    print("Grand nombre");
} else {
    print("Petit nombre");
}

// Boucles
for i in 1..5 {
    print("Itération:", i);
}

while nombre > 0 {
    nombre = nombre - 1;
}

loop {
    print("Boucle infinie");
    break;  // Sortie de boucle
}
```

### Fonctions

```javascript
fn calculer_tva(prix, taux) {
    return prix * taux / 100;
}

fn main(argc, argv) {
    let prix_ht = 100;
    let tva = calculer_tva(prix_ht, 20);
    print("TVA:", tva);
    return 0;
}
```

### Imports et Modularité

```javascript
// Import de fichier
use nom_fichier;              // Importe nom_fichier.template
use ../shared/utils;          // Chemin relatif
use components/header;        // Sous-dossier

fn main(argc, argv) {
    return generer_document();  // Fonction définie dans nom_fichier.template
}
```

**Exemple d'architecture modulaire :**

**`components/footer.template`** :
```javascript
fn generer_footer() {
    return <% template %>
\vfill
\begin{center}
\small Document généré par LatexTemplate
\end{center}
    <% endtemplate %>;
}
```

**`main.template`** :
```javascript
use components/footer;

fn main(argc, argv) {
    let footer = generer_footer();  // Fonction importée
    
    return <% template %>
\documentclass{article}
\begin{document}
Contenu principal...
<% footer %>
\end{document}
    <% endtemplate %>;
}
```

## 🎨 Templates LaTeX

### Syntaxe des Templates

```latex
<% template %>
\documentclass{article}
\begin{document}

\title{Facture n°<% numero_facture %>}
\author{<% nom_entreprise %>}
\date{\today}
\maketitle

Le montant total est de <% total %>€.

\end{document}
<% endtemplate %>
```

### Interpolation et Calculs

```javascript
let prix_unitaire = 50;
let quantite = 3;

<% template %>
Prix unitaire: <% prix_unitaire %>€
Quantité: <% quantite %>
Total: <% prix_unitaire * quantite %>€
<% endtemplate %>
```

### Boucles dans Templates

```javascript
let services = ["Consultation", "Développement", "Formation"];
let tarifs = [100, 80, 120];

<% template %>
\begin{itemize}
<% for i in 0..2 %>
\item <% services[i] %>: <% tarifs[i] %>€
<% endfor %>
\end{itemize}
<% endtemplate %>
```

### Conditions dans Templates

```javascript
let total = 1500;

<% template %>
Montant: <% total %>€

<% if total > 1000 %>
\textbf{Remise entreprise: -10\%}
<% else %>
Tarif standard
<% endif %>
<% endtemplate %>
```

### Utilisation de Composants dans Templates

```javascript
<% template %>
\documentclass{article}
\begin{document}

<% use CompanyHeader(nom_entreprise, adresse, ville) %>

\section{Contenu}
Voici le contenu principal...

<% use CompanyFooter(nom_entreprise, message_footer) %>

\end{document}
<% endtemplate %>
```

## 💼 Exemple Complet : Générateur de Facture

```javascript
// Variables globales
let numero_facture = 2024001;
let entreprise = "TechSoft SARL";
let client = "Université ENSTA";

fn generer_facture(services, tarifs, quantites) {
    let total = 0;
    
    return <% template %>
\documentclass[11pt]{article}
\usepackage[utf8]{inputenc}
\usepackage{array}
\usepackage{longtable}

\begin{document}

\begin{center}
\Large\textbf{FACTURE N° <% numero_facture %>}
\end{center}

\vspace{1cm}

\textbf{Entreprise:} <% entreprise %>\\
\textbf{Client:} <% client %>

\vspace{1cm}

\begin{longtable}{|l|c|c|c|}
\hline
\textbf{Service} & \textbf{Tarif} & \textbf{Qté} & \textbf{Total} \\
\hline
<% for i in 0..2 %>
<% let ligne_total = tarifs[i] * quantites[i] %>
<% total = total + ligne_total %>
<% services[i] %> & <% tarifs[i] %>€ & <% quantites[i] %> & <% ligne_total %>€ \\
\hline
<% endfor %>
\multicolumn{3}{|r|}{\textbf{TOTAL HT:}} & \textbf{<% total %>€} \\
\hline
\multicolumn{3}{|r|}{\textbf{TVA (20\%):}} & \textbf{<% total * 20 / 100 %>€} \\
\hline
\multicolumn{3}{|r|}{\textbf{TOTAL TTC:}} & \textbf{<% total * 120 / 100 %>€} \\
\hline
\end{longtable}

\end{document}
<% endtemplate %>;
}

fn main(argc, argv) {
    let services = ["Développement web", "Formation équipe", "Maintenance"];
    let tarifs = [500, 300, 200];
    let quantites = [3, 2, 1];
    
    return generer_facture(services, tarifs, quantites);
}
```

## 🔧 Fonctionnalités Avancées

### Variables Globales
Les variables déclarées au niveau global sont accessibles dans toutes les fonctions :

```javascript
let taux_tva = 20;  // Variable globale

fn calculer_ttc(prix_ht) {
    return prix_ht * (100 + taux_tva) / 100;  // Accès à taux_tva
}
```

### Gestion d'Erreurs
Le système inclut une gestion d'erreurs complète :
- Erreurs de syntaxe avec position précise
- Variables non définies
- Débordement de tableaux
- Division par zéro
- Erreurs de types
- Conflits de noms entre imports

### Mode Debug
```bash
DEBUG=1 ./main fichier.template
```
Affiche l'AST, l'exécution pas à pas et les états des variables.
