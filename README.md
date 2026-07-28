
# 🖼️ Application Interactive de Traitement d'Images et Vision

[![Python](https://img.shields.io/badge/Python-3.x-blue.svg)](https://www.python.org/)
[![OpenCV](https://img.shields.io/badge/Library-OpenCV-5C3EE8.svg)](https://opencv.org/)
[![Tkinter](https://img.shields.io/badge/GUI-Tkinter-green.svg)]()



## 📝 Description du Projet
Cette application de bureau, dotée d'une interface graphique intuitive, permet d'appliquer et de visualiser en temps réel des dizaines d'algorithmes de traitement d'images. 

Développée en **Python** (avec une implémentation parallèle en **MATLAB**), elle sert de véritable laboratoire d'analyse visuelle. Elle permet de nettoyer des images, d'isoler des formes, ou d'extraire des données clés grâce à l'analyse spatiale et fréquentielle.

## 🎯 Objectifs
- **Améliorer la qualité des images :** Débruitage, correction du contraste et lissage.
- **Extraire des informations pertinentes :** Segmentation, détection de contours et de points d'intérêt.
- **Créer un outil pratique pour la recherche :** Utile pour des applications concrètes en **imagerie médicale** et en **télédétection**.

## 🛠️ Fonctionnalités Principales

L'application couvre tous les domaines classiques de la vision par ordinateur :

*   🎨 **Transformations de base :** Binarisation, Inversion, Niveaux de gris, Modification du contraste, Calcul d'histogramme.
*   🔍 **Filtrage Spatial :** Filtres Moyenneur, Gaussien et Médian (3x3 et 5x5), Filtres Conique, Pyramidal et Pascale.
*   📐 **Détection de Contours :** Sobel, Prewitt, Laplacien, Robert, Kirsh, Marr-Hildreth, Canny et Transformée de Hough.
*   🌊 **Filtrage Fréquentiel (Transformée de Fourier) :** Filtres Idéal et Butterworth (Passe-bas/Passe-haut), Passe-bande, Coupe-bande, Rehaussement des hautes fréquences et Filtrage Homomorphique.
*   🦠 **Bruitage :** Simulation de bruit Gaussien et Poivre & Sel.
*   🧩 **Morphologie Mathématique :** Érosion, Dilatation, Ouverture, Fermeture, Gradients morphologiques (interne/externe), Top Hat Blanc et Noir.
*   📍 **Points d'Intérêt :** Détecteurs de Harris et SUSAN.

## 💻 Technologies Utilisées (Stack)
- **Langages :** Python 3, MATLAB
- **Interface Graphique :** Tkinter (Python), GUIDE (MATLAB)
- **Traitement Mathématique et Visuel :** 
  - `OpenCV` (cv2)
  - `NumPy` & `SciPy` (Transformées de Fourier, convolution)
  - `Scikit-Image`
  - `Matplotlib` (Génération des histogrammes)
  - `Pillow` (Gestion de l'affichage Tkinter)
## 📸 Démonstration

<p align="center">
  
  <img width="800" height="400" alt="demo" src="https://github.com/user-attachments/assets/8c09e542-ccf3-48a5-a693-5ed3a3a8c03b" />
</p>
<p align="center">
  <em>Exemple d'utilisation de l'application : Ajout d'un bruit et application d'un filtre correctif (Originale à gauche, Traitée à droite).</em>
</p>

## 🚀 Installation & Utilisation (Version Python)

1. Clonez ce dépôt sur votre machine locale :
   ```bash
   git clone [https://github.com/votre-pseudo/nom-du-repo.git](https://github.com/votre-pseudo/nom-du-repo.git)
   cd nom-du-repo
   ```
2. Installez les dépendances requises :
   ```bash
   pip install numpy opencv-python scipy matplotlib scikit-image Pillow
    ```
3. Lancez l'application :

     ```bash
    python main.py
     ```
4. Utilisez le menu Fichier > Ouvrir pour charger une image, puis testez les différents algorithmes via les menus déroulants !
   
## 👥 Auteurs
**Oumniya Moutaouakil**
- Master's Student in Advanced Machine Learning & Multimedia Intelligence.
- GitHub: [@oumniya03](https://github.com/oumniya03)
- Project: [Image_processing](https://github.com/oumniya03/image_processing.git)
