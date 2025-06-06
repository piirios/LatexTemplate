#!/bin/bash

# Définir le chemin de l'exécutable
EXECUTABLE="../../main"

echo "=== Tests d'Import pour le Projet Template ==="
echo ""

# Compilation du projet
echo "Compilation du projet..."
cd ..
make clean
make depend
make
echo ""

cd tests/imports

# Tests d'import
echo "=== Test 1: Import Simple ==="
echo "Fichier: tests/imports/test_simple_import.template"
echo "Attendu: Succès"
$EXECUTABLE test_simple_import.template
echo ""

echo "=== Test 2: Imports Multiples ==="
echo "Fichier: tests/imports/test_multiple_imports.template"
echo "Attendu: Succès"
$EXECUTABLE test_multiple_imports.template
echo ""

echo "=== Test 3: Détection de Noms Dupliqués ==="
echo "Fichier: tests/imports/test_duplicate_names_importer.template"
echo "Attendu: Échec avec erreur de nom dupliqué"
$EXECUTABLE test_duplicate_names_importer.template
echo ""

echo "=== Test 4: Import Circulaire A ==="
echo "Fichier: tests/imports/test_circular_import_a.template"
echo "Attendu: Peut boucler ou échouer selon l'implémentation"
echo "Note: Ce test peut nécessiter une interruption manuelle si il y a une boucle infinie"
timeout 10s $EXECUTABLE test_circular_import_a.template || echo "Test interrompu après 10 secondes"
echo ""

echo "=== Tests Terminés ==="