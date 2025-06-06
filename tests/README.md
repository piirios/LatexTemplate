# Tests du Projet Template

## Organisation des Tests

### Structure des Dossiers

- `tests/` - Dossier racine des tests
  - `templates/` - Tests des fonctionnalités de templates (anciennement dans exemple/template/)
  - `imports/` - Tests spécifiques aux fonctionnalités d'import
  - `core/` - Tests des fonctionnalités de base (anciennement dans exemple/)

### Tests d'Import

#### Fichiers de Test d'Import

1. **`base_component.template`** - Composant de base avec des fonctions simples
2. **`secondary_component.template`** - Composant secondaire pour tester les imports multiples
3. **`test_simple_import.template`** - Test d'import simple d'un seul fichier
4. **`test_multiple_imports.template`** - Test d'imports multiples
5. **`test_circular_import_a.template`** et **`test_circular_import_b.template`** - Test de détection des imports circulaires
6. **`test_duplicate_names.template`** et **`test_duplicate_names_importer.template`** - Test de détection des noms dupliqués

#### Scénarios de Test

##### Test 1: Import Simple
- **Fichier**: `test_simple_import.template`
- **Objectif**: Vérifier qu'un import simple fonctionne correctement
- **Commande**: `./main test_simple_import`

##### Test 2: Imports Multiples
- **Fichier**: `test_multiple_imports.template`
- **Objectif**: Vérifier que plusieurs imports peuvent être résolus
- **Commande**: `./main test_multiple_imports`

##### Test 3: Détection d'Imports Circulaires
- **Fichier**: `test_circular_import_a.template`
- **Objectif**: Vérifier que les imports circulaires sont détectés (devrait être géré par le système)
- **Commande**: `./main test_circular_import_a`

##### Test 4: Détection de Noms Dupliqués
- **Fichier**: `test_duplicate_names_importer.template`
- **Objectif**: Vérifier que les noms dupliqués sont détectés et qu'une erreur est levée
- **Commande**: `./main test_duplicate_names_importer` (devrait échouer)

### Tests de Templates

Les tests de templates ont été déplacés dans `tests/templates/` et incluent :
- Tests d'expressions simples et complexes
- Tests de boucles (for, while, loops imbriqués)
- Tests de conditions (if/else)
- Tests d'utilisation de composants

### Tests Core

Les tests core incluent les tests d'instructions et d'expressions de base.

## Exécution des Tests

Pour exécuter un test spécifique :
```bash
make
./main <nom_du_fichier_sans_extension>
```

Par exemple :
```bash
./main test_simple_import
./main test_multiple_imports
``` 