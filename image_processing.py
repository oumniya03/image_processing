import numpy as np
import cv2
from scipy import ndimage
import matplotlib.pyplot as plt
from skimage.util import img_as_float
from skimage.color import rgb2gray
from scipy import fftpack
from skimage.morphology import disk, opening, closing
from skimage.util import img_as_ubyte
from scipy.fft import fftshift, fft2, ifft2, ifftshift

def load_image(path):
    """Charge une image (RGB ou niveaux de gris)"""
    img = cv2.imread(path, cv2.IMREAD_UNCHANGED)
    if len(img.shape) == 3 and img.shape[2] == 3:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    return img


def save_image(img, path):
    """Sauvegarde une image"""
    if len(img.shape) == 3:
        img = cv2.cvtColor(img, cv2.COLOR_RGB2BGR)
    cv2.imwrite(path, img)


def to_grayscale(img):
    """Convertit une image en niveaux de gris"""
    if len(img.shape) == 3:
        return np.mean(img, axis=2).astype(np.uint8)
    return img


def invert_image(img):
    """Inverse les couleurs d'une image"""
    return 255 - img


def enhance_contrast(img, factor=5):
    """Améliore le contraste d'une image"""
    mean = np.mean(img)
    enhanced = (img - mean) * factor + mean
    return np.clip(enhanced, 0, 255).astype(np.uint8)

def binarize_image(img, threshold=128):
    """
    Binarise une image en niveaux de gris.
    """
    if len(img.shape) == 3:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    _, binary_img = cv2.threshold(img, threshold, 255, cv2.THRESH_BINARY)
    return binary_img

def hough_transform(image, rho=1, theta=np.pi/180, threshold=100, min_line_length=50, max_line_gap=10):
    """
    Applique la Transformée de Hough pour détecter les droites dans une image.
    
    Paramètres :
    - image : image en niveaux de gris (numpy array)
    - rho : résolution en pixels du paramètre rho
    - theta : résolution en radians du paramètre theta (en radians)
    - threshold : seuil pour détecter une droite (plus c'est haut, moins il y a de faux positifs)
    - min_line_length : longueur minimale d'une droite (en pixels)
    - max_line_gap : écart max entre segments pour les fusionner
    
    Retourne :
    - image_droites : image avec les droites détectées
    """

    # Si l'image est en couleur, la convertir en niveaux de gris
    if len(image.shape) == 3:
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Détection des contours (Canny)
    edges = cv2.Canny(image, 50, 150)

    # Appliquer la Transformée de Hough
    lines = cv2.HoughLinesP(edges, rho=rho, theta=theta, threshold=threshold,
                            minLineLength=min_line_length, maxLineGap=max_line_gap)

    # Créer une copie de l'image pour dessiner les droites
    image_droites = cv2.cvtColor(edges, cv2.COLOR_GRAY2BGR)

    # Dessiner les droites détectées
    if lines is not None:
        for line in lines:
            x1, y1, x2, y2 = line[0]
            cv2.line(image_droites, (x1, y1), (x2, y2), (0, 0, 255), 2)  # Ligne en rouge

    return image_droites



def mean_filter_3x3(img):
    """Filtre moyenneur 3x3"""
    kernel = np.ones((3, 3)) / 9
    if len(img.shape) == 2:
        return cv2.filter2D(img, -1, kernel)
    else:
        return np.dstack([cv2.filter2D(img[:, :, c], -1, kernel) for c in range(3)])


def gaussian_filter_3x3(img):
    """Filtre gaussien 3x3"""
    kernel = np.array([[1, 2, 1], [2, 4, 2], [1, 2, 1]]) / 16
    if len(img.shape) == 2:
        return cv2.filter2D(img, -1, kernel)
    else:
        return np.dstack([cv2.filter2D(img[:, :, c], -1, kernel) for c in range(3)])


def median_filter_3x3(img):
    """Filtre médian 3x3"""
    if len(img.shape) == 2:
        return cv2.medianBlur(img, 3)
    else:
        return np.dstack([cv2.medianBlur(img[:, :, c], 3) for c in range(3)])


# Filtre moyenneur 5x5
def mean_filter_5x5(img):
    kernel = np.ones((5, 5)) / 25
    return cv2.filter2D(img, -1, kernel)

# Filtre gaussien 5x5
def gaussian_filter_5x5(img):
    kernel = np.array([
        [1, 2, 3, 2, 1],
        [2, 4, 6, 4, 2],
        [3, 6, 9, 6, 3],
        [2, 4, 6, 4, 2],
        [1, 2, 3, 2, 1]
    ]) / 81
    return cv2.filter2D(img, -1, kernel)

# Filtre médian 5x5
def median_filter_5x5(img):
    return cv2.medianBlur(img, 5)

def pascale_filter(img):
    """
    Applique un filtre Pascale sur l'image.
    Le filtre Pascale est une matrice symétrique centrée.
    """
    kernel = np.array([
        [0, 0, 1, 0, 0],
        [0, 2, 2, 2, 0],
        [1, 2, 5, 2, 1],
        [0, 2, 2, 2, 0],
        [0, 0, 1, 0, 0]
    ]) / 25
    return cv2.filter2D(img, -1, kernel)

def pyramidal_filter(img):
    """
    Applique un filtre Pyramidal sur l'image.
    Le filtre Pyramidal est une matrice symétrique centrée.
    """
    kernel = np.array([
        [1, 2, 3, 2, 1],
        [2, 4, 6, 4, 2],
        [3, 6, 9, 6, 3],
        [2, 4, 6, 4, 2],
        [1, 2, 3, 2, 1]
    ]) / 81
    return cv2.filter2D(img, -1, kernel)

def conical_filter(img):
    """
    Applique un filtre Conique sur l'image.
    Le filtre Conique est une matrice symétrique centrée.
    """
    kernel = np.array([
        [0, 0, 1, 0, 0],
        [0, 2, 2, 2, 0],
        [1, 2, 5, 2, 1],
        [0, 2, 2, 2, 0],
        [0, 0, 1, 0, 0]
    ]) / 25
    return cv2.filter2D(img, -1, kernel)

def sobel_edge(img):
    """Détection de contours par Sobel"""
    if len(img.shape) == 3:
        img = to_grayscale(img)
    sobelx = cv2.Sobel(img, cv2.CV_64F, 1, 0, ksize=3)
    sobely = cv2.Sobel(img, cv2.CV_64F, 0, 1, ksize=3)
    return np.hypot(sobelx, sobely).astype(np.uint8)


def prewitt_edge(img):
    """Détection de contours par Prewitt"""
    if len(img.shape) == 3:
        img = to_grayscale(img)
    kernelx = np.array([[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]])
    kernely = np.array([[1, 1, 1], [0, 0, 0], [-1, -1, -1]])
    prewittx = cv2.filter2D(img, -1, kernelx)
    prewitty = cv2.filter2D(img, -1, kernely)
    return np.hypot(prewittx, prewitty).astype(np.uint8)


def laplacian_edge(img):
    """Détection de contours par Laplacien"""
    if len(img.shape) == 3:
        img = to_grayscale(img)
    laplacian = cv2.Laplacian(img, cv2.CV_64F)
    return np.absolute(laplacian).astype(np.uint8)


def robert_edge(img):
    """Détection de contours par Robert"""
    if len(img.shape) == 3:
        img = to_grayscale(img)
    kernelx = np.array([[1, 0], [0, -1]])
    kernely = np.array([[0, 1], [-1, 0]])
    robertx = cv2.filter2D(img, -1, kernelx)
    roberty = cv2.filter2D(img, -1, kernely)
    return np.hypot(robertx, roberty).astype(np.uint8)


def kirsh_edge(img):
    if len(img.shape) == 3:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    kernels = [
        np.array([[-3, -3, 5], [-3, 0, 5], [-3, -3, 5]]),
        np.array([[-3, 5, 5], [-3, 0, 5], [-3, -3, -3]]),
        np.array([[5, 5, 5], [-3, 0, -3], [-3, -3, -3]]),
        np.array([[5, -3, -3], [5, 0, -3], [5, -3, -3]]),
        np.array([[-3, -3, -3], [-3, 0, -3], [5, 5, 5]]),
        np.array([[-3, -3, -3], [5, 0, -3], [5, 5, -3]]),
        np.array([[5, -3, -3], [-3, 0, -3], [-3, -3, 5]]),
        np.array([[-3, 5, -3], [-3, 0, 5], [-3, -3, -3]])
    ]
    responses = []
    for kernel in kernels:
        response = cv2.filter2D(img, -1, kernel)
        responses.append(response)
    edge_response = np.max(responses, axis=0)
    return np.uint8(edge_response)

def marr_hildreth_edge(img):
    from scipy.ndimage import gaussian_laplace
    if len(img.shape) == 3:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(img, (5, 5), 0)
    laplacian = gaussian_laplace(blurred, sigma=1)
    return np.uint8(np.abs(laplacian) * 255)

def canny_edge(img):
    if len(img.shape) == 3:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(img, 100, 200)
    return edges



def apply_fft(image):
    """
    Applique la Transformée de Fourier Discrète (DFT) à une image.
    """
    if len(image.shape) == 3:
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    return np.fft.fftshift(np.fft.fft2(image))


def ideal_lowpass_filter(image, cutoff=30):
    """
    Filtre passe-bas idéal.
    """
    f = apply_fft(image)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask = np.zeros((rows, cols), dtype=np.float32)
    mask[crow - cutoff:crow + cutoff, ccol - cutoff:ccol + cutoff] = 1
    filtered = f * mask
    img_back = np.abs(np.fft.ifft2(np.fft.ifftshift(filtered)))
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
    return img_back


def ideal_highpass_filter(image, cutoff=30):
    """
    Filtre passe-haut idéal.
    """
    f = apply_fft(image)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask = np.ones((rows, cols), dtype=np.float32)
    mask[crow - cutoff:crow + cutoff, ccol - cutoff:ccol + cutoff] = 0
    filtered = f * mask
    img_back = np.abs(np.fft.ifft2(np.fft.ifftshift(filtered)))
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
    return img_back


def butterworth_lowpass_filter(image, cutoff=30, order=2):
    """
    Filtre passe-bas de Butterworth.
    """
    f = apply_fft(image)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask = np.zeros((rows, cols), dtype=np.float32)
    epsilon = 1e-8  # Pour éviter la division par zéro
    for i in range(rows):
        for j in range(cols):
            d = np.sqrt((i - crow) ** 2 + (j - ccol) ** 2) + epsilon
            mask[i, j] = 1 / (1 + (d / cutoff) ** (2 * order))
    filtered = f * mask
    img_back = np.abs(np.fft.ifft2(np.fft.ifftshift(filtered)))
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
    return img_back


def butterworth_highpass_filter(image, cutoff=30, order=2):
    """
    Filtre passe-haut de Butterworth.
    """
    f = apply_fft(image)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask = np.ones((rows, cols), dtype=np.float32)
    epsilon = 1e-8  # Pour éviter la division par zéro
    for i in range(rows):
        for j in range(cols):
            d = np.sqrt((i - crow) ** 2 + (j - ccol) ** 2) + epsilon
            mask[i, j] = 1 / (1 + (cutoff / d) ** (2 * order))
    filtered = f * mask
    img_back = np.abs(np.fft.ifft2(np.fft.ifftshift(filtered)))
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
    return img_back


def bandpass_filter(image, low_cutoff=30, high_cutoff=80):
    """
    Filtre passe-bande.
    """
    f = apply_fft(image)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask = np.zeros((rows, cols), dtype=np.float32)
    for i in range(rows):
        for j in range(cols):
            d = np.sqrt((i - crow) ** 2 + (j - ccol) ** 2)
            if low_cutoff <= d <= high_cutoff:
                mask[i, j] = 1
    filtered = f * mask
    img_back = np.abs(np.fft.ifft2(np.fft.ifftshift(filtered)))
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
    return img_back


def bandstop_filter(image, low_cutoff=30, high_cutoff=80):
    """
    Filtre à rejet de bande.
    """
    f = apply_fft(image)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask = np.ones((rows, cols), dtype=np.float32)
    for i in range(rows):
        for j in range(cols):
            d = np.sqrt((i - crow) ** 2 + (j - ccol) ** 2)
            if low_cutoff <= d <= high_cutoff:
                mask[i, j] = 0
    filtered = f * mask
    img_back = np.abs(np.fft.ifft2(np.fft.ifftshift(filtered)))
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)
    return img_back

def high_frequency_boosting(image, alpha=1.5, beta=0.5):
    """
    Applique un rehaussement des hautes fréquences à l'image.
    """
    # Convertir l'image en float
    image_float = img_as_float(image)

    # Appliquer la Transformée de Fourier
    f = fftshift(fft2(image_float))

    # Créer un masque haute fréquence (combinaison de passe-haut et passe-bas)
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2

    mask = np.zeros((rows, cols), dtype=np.float32)
    cutoff = 30
    for i in range(rows):
        for j in range(cols):
            d = np.sqrt((i - crow) ** 2 + (j - ccol) ** 2)
            mask[i, j] = 1 - np.exp(-d**2 / (2 * (cutoff**2)))  # Filtre passe-haut gaussien

    # Appliquer le filtre haute fréquence avec boosting
    filtered = f * mask
    img_back = np.abs(ifft2(ifftshift(filtered)))

    # Boosting des hautes fréquences
    boosted = image_float + alpha * img_back
    boosted = np.clip(boosted, 0, 1)
    return (boosted * 255).astype(np.uint8)

def homomorphic_filter(image, cutoff=30, gamma_low=0.3, gamma_high=1.5):
    """
    Applique un filtre homomorphique à l'image.
    """
    # Convertir l'image en niveaux de gris si elle est en couleur
    if len(image.shape) == 3:
        image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Normaliser l'image entre 0 et 1
    image_float = img_as_float(image)

    # Appliquer la transformée de Fourier
    f = fftshift(fft2(image_float))

    # Créer un masque passe-bas et un masque passe-haut
    rows, cols = image.shape[:2]
    crow, ccol = rows // 2, cols // 2
    mask_lowpass = np.zeros((rows, cols), dtype=np.float32)
    mask_highpass = np.ones((rows, cols), dtype=np.float32)

    for i in range(rows):
        for j in range(cols):
            d = np.sqrt((i - crow) ** 2 + (j - ccol) ** 2)
            mask_lowpass[i, j] = 1 / (1 + (d / cutoff) ** 2)
            mask_highpass[i, j] = 1 - mask_lowpass[i, j]

    # Appliquer les filtres passe-bas et passe-haut
    lowpass_filtered = f * mask_lowpass
    highpass_filtered = f * mask_highpass

    # Combinaison avec les coefficients gamma
    filtered = gamma_low * lowpass_filtered + gamma_high * highpass_filtered

    # Transformation inverse
    img_back = np.abs(ifft2(ifftshift(filtered)))

    # Normaliser et convertir en uint8
    img_back = cv2.normalize(img_back, None, 0, 255, cv2.NORM_MINMAX).astype(np.uint8)

    return img_back


def add_gaussian_noise(img, mean=0, sigma=25):
    """Ajoute du bruit Gaussien"""
    noise = np.random.normal(mean, sigma, img.shape)
    noisy = img + noise
    return np.clip(noisy, 0, 255).astype(np.uint8)


def add_salt_pepper_noise(img, density=0.05):
    """Ajoute du bruit Poivre et Sel"""
    noisy = np.copy(img)
    num = int(density * img.size)
    coords = [np.random.randint(0, i, num) for i in img.shape]
    noisy[coords[0], coords[1]] = 255  # Sel
    coords = [np.random.randint(0, i, num) for i in img.shape]
    noisy[coords[0], coords[1]] = 0    # Poivre
    return noisy



def erosion(img, kernel_size=5):
    """Erosion morphologique"""
    kernel = np.ones((kernel_size, kernel_size), np.uint8)
    if len(img.shape) == 2:
        return cv2.erode(img, kernel, iterations=1)
    else:
        return np.dstack([cv2.erode(img[:, :, c], kernel, iterations=1) for c in range(3)])


def dilation(img, kernel_size=5):
    """Dilatation morphologique"""
    kernel = np.ones((kernel_size, kernel_size), np.uint8)
    if len(img.shape) == 2:
        return cv2.dilate(img, kernel, iterations=1)
    else:
        return np.dstack([cv2.dilate(img[:, :, c], kernel, iterations=1) for c in range(3)])


def opening(img, kernel_size=5):
    """Ouverture morphologique"""
    kernel = np.ones((kernel_size, kernel_size), np.uint8)
    if len(img.shape) == 2:
        return cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)
    else:
        return np.dstack([cv2.morphologyEx(img[:, :, c], cv2.MORPH_OPEN, kernel) for c in range(3)])


def closing(img, kernel_size=5):
    """Fermeture morphologique"""
    kernel = np.ones((kernel_size, kernel_size), np.uint8)
    if len(img.shape) == 2:
        return cv2.morphologyEx(img, cv2.MORPH_CLOSE, kernel)
    else:
        return np.dstack([cv2.morphologyEx(img[:, :, c], cv2.MORPH_CLOSE, kernel) for c in range(3)])

def internal_gradient(image, se_size=5):
    """
    Calcule le gradient interne : image - érosion
    """
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (se_size, se_size))
    eroded = cv2.erode(image, kernel, iterations=1)
    return cv2.absdiff(image, eroded)


def external_gradient(image, se_size=5):
    """
    Calcule le gradient externe : dilatation - image
    """
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (se_size, se_size))
    dilated = cv2.dilate(image, kernel, iterations=1)
    return cv2.absdiff(dilated, image)


def morphological_gradient(image, se_size=5):
    """
    Calcule le gradient morphologique : dilatation - érosion
    """
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (se_size, se_size))
    dilated = cv2.dilate(image, kernel, iterations=1)
    eroded = cv2.erode(image, kernel, iterations=1)
    return cv2.absdiff(dilated, eroded)


def white_top_hat(image, se_size=5):
    """
    Calcule le Top Hat blanc : image - ouverture
    """
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (se_size, se_size))
    opened = cv2.morphologyEx(image, cv2.MORPH_OPEN, kernel)
    return cv2.absdiff(image, opened)


def black_top_hat(image, se_size=5):
    """
    Calcule le Top Hat noir : fermeture - image
    """
    kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (se_size, se_size))
    closed = cv2.morphologyEx(image, cv2.MORPH_CLOSE, kernel)
    return cv2.absdiff(closed, image)



def harris_corner(img):
    if len(img.shape) == 3:
        img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
    img = np.float32(img)
    dst = cv2.cornerHarris(img, blockSize=2, ksize=3, k=0.04)
    dst = cv2.dilate(dst, None)
    ret, dst = cv2.threshold(dst, 0.01 * dst.max(), 255, 0)
    dst = np.uint8(dst)
    _, labels, stats, centroids = cv2.connectedComponentsWithStats(dst)
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 100, 0.001)
    corners = cv2.cornerSubPix(img, np.float32(centroids), (5, 5), (-1, -1), criteria)
    output_img = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
    for corner in corners:
        x, y = np.int32(corner)  # ← Correction ici
        cv2.circle(output_img, (x, y), 3, (0, 0, 255), 1)
    return output_img

def susan_corner(img):
    from skimage import feature, color
    from skimage.feature import peak_local_max
    from scipy.ndimage import gaussian_filter

    if len(img.shape) == 3:
        img = color.rgb2gray(img)
    img = gaussian_filter(img, sigma=1.2)

    # Susan corner detection simplifié
    def susan_response(image, radius=3, g=10):
        from numpy.lib.stride_tricks import sliding_window_view
        h, w = image.shape
        padded = np.pad(image, radius, mode='reflect')
        windows = sliding_window_view(padded, (2*radius+1, 2*radius+1))
        center = windows[:, :, radius, radius]
        diff = np.abs(windows - center[:, :, None, None])
        response = np.sum(diff < g, axis=(2, 3))
        return response

    response = susan_response(img)
    coords = peak_local_max(response, min_distance=5, threshold_abs=15)
    output = cv2.cvtColor((img * 255).astype(np.uint8), cv2.COLOR_GRAY2BGR)

    for y, x in coords:
        cv2.circle(output, (x, y), 3, (0, 0, 255), -1)
    return output


def plot_histogram(img):
    """Affiche l'histogramme d'une image"""
    if len(img.shape) == 3:
        img = to_grayscale(img)
    plt.figure()
    plt.hist(img.ravel(), 256, [0, 256])
    plt.title('Histogramme')
    plt.show()