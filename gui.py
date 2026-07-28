import tkinter as tk
from tkinter import filedialog, messagebox
from PIL import Image, ImageTk
import numpy as np
from image_processing import *


class ImageApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Image Processing App")
        self.original = None
        self.processed = None

        # Canvas d'affichage
        self.panel_frame = tk.Frame(self.root)
        self.panel_frame.pack()

        self.canvas_original = tk.Canvas(self.panel_frame, width=700, height=700)
        self.canvas_processed = tk.Canvas(self.panel_frame, width=700, height=700)
        self.canvas_original.pack(side=tk.LEFT)
        self.canvas_processed.pack(side=tk.RIGHT)

        # Barre de menus
        menu_bar = tk.Menu(self.root)

        # Fichier
        file_menu = tk.Menu(menu_bar, tearoff=0)
        file_menu.add_command(label="Ouvrir", command=self.open_image)
        file_menu.add_command(label="Enregistrer", command=self.save_image)
        file_menu.add_separator()
        file_menu.add_command(label="Quitter", command=self.root.quit)
        menu_bar.add_cascade(label="Fichier", menu=file_menu)

        # Transformations
        transform_menu = tk.Menu(menu_bar, tearoff=0)
        transform_menu.add_command(label="Inversion", command=self.apply_inversion)
        transform_menu.add_command(label="Binarisation", command=self.apply_binarization)
        transform_menu.add_command(label="Contraste", command=self.apply_contrast)
        transform_menu.add_command(label="Niveaux de gris", command=self.apply_grayscale)
        transform_menu.add_command(label="Transformée de Hough", command=self.apply_hough_transform)
        transform_menu.add_command(label="Histogramme", command=self.show_histogram)
        menu_bar.add_cascade(label="Transformations", menu=transform_menu)

        # Filtres
        filter_menu = tk.Menu(menu_bar, tearoff=0)
        filter_menu.add_command(label="Moyenneur 3x3", command=self.apply_mean_3x3)
        filter_menu.add_command(label="Gaussien 3x3", command=self.apply_gaussian_3x3)
        filter_menu.add_command(label="Médian 3x3", command=self.apply_median_3x3)
        filter_menu.add_command(label="Moyenneur 5x5", command=self.apply_mean_5x5)
        filter_menu.add_command(label="Gaussien 5x5", command=self.apply_gaussian_5x5)
        filter_menu.add_command(label="Médian 5x5", command=self.apply_median_5x5)
        filter_menu.add_command(label="Filtre Pascale", command=self.apply_pascale_filter)
        filter_menu.add_command(label="Filtre Pyramidal", command=self.apply_pyramidal_filter)
        filter_menu.add_command(label="Filtre Conique", command=self.apply_conical_filter)
        menu_bar.add_cascade(label="Filtres", menu=filter_menu)

        # Contours
        edge_menu = tk.Menu(menu_bar, tearoff=0)
        edge_menu.add_command(label="Sobel", command=self.apply_sobel)
        edge_menu.add_command(label="Prewitt", command=self.apply_prewitt)
        edge_menu.add_command(label="Laplacien", command=self.apply_laplacian)
        edge_menu.add_command(label="Robert", command=self.apply_robert)
        edge_menu.add_command(label="Kirsh", command=self.apply_kirsh)
        edge_menu.add_command(label="Marr-Hildreth", command=self.apply_marr_hildreth)
        edge_menu.add_command(label="Canny", command=self.apply_canny)
        menu_bar.add_cascade(label="Contours", menu=edge_menu)

        # Filtres fréquentiels
        freq_menu = tk.Menu(menu_bar, tearoff=0)
        freq_menu.add_command(label="Passe-bas idéal", command=self.apply_ideal_lowpass_filter)
        freq_menu.add_command(label="Passe-bas de Butterworth", command=self.apply_butterworth_lowpass_filter)
        freq_menu.add_command(label="Passe-haut idéal", command=self.apply_ideal_highpass_filter)
        freq_menu.add_command(label="Passe-haut de Butterworth", command=self.apply_butterworth_highpass_filter)
        freq_menu.add_command(label="Rehaussement des hautes fréquences", command=self.apply_high_frequency_boosting)
        freq_menu.add_command(label="Passe-bande", command=self.apply_bandpass_filter)
        freq_menu.add_command(label="Rejet de bande", command=self.apply_bandstop_filter)
        freq_menu.add_command(label="Filtrage Homomorphique", command=self.apply_homomorphic_filter)
        menu_bar.add_cascade(label="Filtrage Fréquentiel", menu=freq_menu)
        
        # Bruit
        noise_menu = tk.Menu(menu_bar, tearoff=0)
        noise_menu.add_command(label="Bruit Gaussien", command=self.apply_gaussian_noise)
        noise_menu.add_command(label="Poivre et Sel", command=self.apply_salt_pepper_noise)
        menu_bar.add_cascade(label="Bruit", menu=noise_menu)

        # Morphologie
        morph_menu = tk.Menu(menu_bar, tearoff=0)
        morph_menu.add_command(label="Erosion", command=self.apply_erosion)
        morph_menu.add_command(label="Dilatation", command=self.apply_dilation)
        morph_menu.add_command(label="Ouverture", command=self.apply_opening)
        morph_menu.add_command(label="Fermeture", command=self.apply_closing)
        morph_menu.add_command(label="Gradient interne", command=self.apply_internal_gradient)
        morph_menu.add_command(label="Gradient externe", command=self.apply_external_gradient)
        morph_menu.add_command(label="Gradient morphologique", command=self.apply_morphological_gradient)
        morph_menu.add_command(label="Top Hat Blanc", command=self.apply_white_top_hat)
        morph_menu.add_command(label="Top Hat Noir", command=self.apply_black_top_hat)
        menu_bar.add_cascade(label="Morphologie", menu=morph_menu)

        # Points d'intérêt
        feature_menu = tk.Menu(menu_bar, tearoff=0)
        feature_menu.add_command(label="Harris", command=self.apply_harris)
        feature_menu.add_command(label="SUSAN", command=self.apply_susan)
        menu_bar.add_cascade(label="Points d'intérêt", menu=feature_menu)

        self.root.config(menu=menu_bar)

    def open_image(self):
        path = filedialog.askopenfilename(filetypes=[("Images", "*.png *.jpg *.bmp *.tiff")])
        if path:
            self.original = load_image(path)
            self.processed = self.original.copy()
            self.show_images()

    def save_image(self):
        if self.processed is not None:
            path = filedialog.asksaveasfilename(defaultextension=".png")
            if path:
                save_image(self.processed, path)

    def show_images(self):
        show_image_tk(self.canvas_original, self.original)
        show_image_tk(self.canvas_processed, self.processed)

    def apply_inversion(self):
        if self.original is not None:
            self.processed = invert_image(self.original)
            self.show_images()

    def apply_contrast(self):
        if self.original is not None:
            self.processed = enhance_contrast(self.original)
            self.show_images()

    def apply_grayscale(self):
        if self.original is not None:
            self.processed = to_grayscale(self.original)
            self.show_images()

    def apply_binarization(self):
        if self.original is not None:
            self.processed = binarize_image(self.original)
            self.show_images()

    def apply_hough_transform(self):
        if self.original is not None:
            self.processed = hough_transform(self.original)
            self.show_images()

    def show_histogram(self):
        if self.original is not None:
            plot_histogram(self.original)

    def apply_mean_3x3(self):
        if self.original is not None:
            self.processed = mean_filter_3x3(self.original)
            self.show_images()

    def apply_gaussian_3x3(self):
        if self.original is not None:
            self.processed = gaussian_filter_3x3(self.original)
            self.show_images()

    def apply_median_3x3(self):
        if self.original is not None:
            self.processed = median_filter_3x3(self.original)
            self.show_images()

    def apply_mean_5x5(self):
        if self.original is not None:
            self.processed = mean_filter_5x5(self.original)
            self.show_images()

    def apply_gaussian_5x5(self):
        if self.original is not None:
            self.processed = gaussian_filter_5x5(self.original)
            self.show_images()

    def apply_median_5x5(self):
        if self.original is not None:
            self.processed = median_filter_5x5(self.original)
            self.show_images()

    def apply_pascale_filter(self):
        if self.original is not None:
            self.processed = pascale_filter(self.original)
            self.show_images()

    def apply_pyramidal_filter(self):
        if self.original is not None:
            self.processed = pyramidal_filter(self.original)
            self.show_images()

    def apply_conical_filter(self):
        if self.original is not None:
            self.processed = conical_filter(self.original)
            self.show_images()

    def apply_sobel(self):
        if self.original is not None:
            self.processed = sobel_edge(self.original)
            self.show_images()

    def apply_prewitt(self):
        if self.original is not None:
            self.processed = prewitt_edge(self.original)
            self.show_images()

    def apply_laplacian(self):
        if self.original is not None:
            self.processed = laplacian_edge(self.original)
            self.show_images()

    def apply_robert(self):
        if self.original is not None:
            self.processed = robert_edge(self.original)
            self.show_images()

    def apply_kirsh(self):
        if self.original is not None:
            self.processed = kirsh_edge(self.original)
            self.show_images()

    def apply_marr_hildreth(self):
        if self.original is not None:
            self.processed = marr_hildreth_edge(self.original)
            self.show_images()

    def apply_canny(self):
        if self.original is not None:
            self.processed = canny_edge(self.original)
            self.show_images()

    def apply_fft(image):
        """
        Applique la Transformée de Fourier Discrète (DFT) à une image.
        """
        if len(image.shape) == 3:
            image = rgb2gray(image)
        f = fftpack.fftshift(fftpack.fft2(img_as_float(image)))
        return f

    def apply_ideal_lowpass_filter(self):
        if self.original is not None:
            self.processed = ideal_lowpass_filter(self.original, cutoff=50)
            self.show_images()

    def apply_butterworth_lowpass_filter(self):
        if self.original is not None:
            self.processed = butterworth_lowpass_filter(self.original, cutoff=50, order=2)
            self.show_images()

    def apply_ideal_highpass_filter(self):
        if self.original is not None:
            self.processed = ideal_highpass_filter(self.original, cutoff=50)
            self.show_images()

    def apply_butterworth_highpass_filter(self):
        if self.original is not None:
            self.processed = butterworth_highpass_filter(self.original, cutoff=50, order=2)
            self.show_images()

    def apply_high_frequency_boosting(self):
        if self.original is not None:
            self.processed = high_frequency_boosting(self.original, alpha=1.5, beta=0.5)
            self.show_images()

    def apply_bandpass_filter(self):
        if self.original is not None:
            self.processed = bandpass_filter(self.original, low_cutoff=30, high_cutoff=80)
            self.show_images()

    def apply_bandstop_filter(self):
        if self.original is not None:
            self.processed = bandstop_filter(self.original, low_cutoff=30, high_cutoff=80)
            self.show_images()

    def apply_homomorphic_filter(self):
        if self.original is not None:
            self.processed = homomorphic_filter(self.original, cutoff=30, gamma_low=0.3, gamma_high=1.5)
            self.show_images()

    def apply_gaussian_noise(self):
        if self.original is not None:
            self.processed = add_gaussian_noise(self.original)
            self.show_images()

    def apply_salt_pepper_noise(self):
        if self.original is not None:
            self.processed = add_salt_pepper_noise(self.original)
            self.show_images()


    def apply_erosion(self):
        if self.original is not None:
            self.processed = erosion(self.original)
            self.show_images()

    def apply_dilation(self):
        if self.original is not None:
            self.processed = dilation(self.original)
            self.show_images()

    def apply_opening(self):
        if self.original is not None:
            self.processed = opening(self.original)
            self.show_images()

    def apply_closing(self):
        if self.original is not None:
            self.processed = closing(self.original)
            self.show_images()

    def apply_internal_gradient(self):
        if self.original is not None:
            self.processed = internal_gradient(self.original)
            self.show_images()

    def apply_external_gradient(self):
        if self.original is not None:
            self.processed = external_gradient(self.original)
            self.show_images()

    def apply_morphological_gradient(self):
        if self.original is not None:
            self.processed = morphological_gradient(self.original)
            self.show_images()

    def apply_white_top_hat(self):
        if self.original is not None:
            self.processed = white_top_hat(self.original)
            self.show_images()

    def apply_black_top_hat(self):
        if self.original is not None:
            self.processed = black_top_hat(self.original)
            self.show_images()


    def apply_harris(self):
        if self.original is not None:
            self.processed = harris_corner(self.original)
            self.processed = np.clip(self.processed, 0, 255).astype(np.uint8)
            self.show_images()

    def apply_susan(self):
        if self.original is not None:
            self.processed = susan_corner(self.original)
            self.show_images()
            
def show_image_tk(canvas, img_array):
    """
    Affiche une image numpy array dans un canvas Tkinter.
    """
    # Convertir en uint8 si nécessaire
    if img_array.dtype != np.uint8:
        img_array = np.clip(img_array, 0, 255).astype(np.uint8)

    # Gérer les dimensions
    if len(img_array.shape) == 2:
        img = Image.fromarray(img_array)  # Niveaux de gris
    elif len(img_array.shape) == 3 and img_array.shape[2] in [3, 4]:
        img = Image.fromarray(img_array)  # Couleur (RGB/RGBA)
    else:
        raise ValueError(f"Format d'image non supporté : {img_array.shape}")

    img = img.resize((700, 700))  # Redimensionner
    img_tk = ImageTk.PhotoImage(img)

    canvas.delete("all")  # Effacer contenu précédent
    canvas.create_image(0, 0, anchor="nw", image=img_tk)
    canvas.image = img_tk  # Garder une référence