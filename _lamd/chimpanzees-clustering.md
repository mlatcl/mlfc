---
title: "Practical 5: Clustering Chimpanzees"
practical: 5
featured_image: slides/diagrams/ml/kmeans-chimpanzee.png
abstract: >
  In this self-guided practical we showcase a practical example of K-means clustering on Chimpanzee faces. Using a pre-trained classifier to generate a vector encoding of each portrait, we analyse the best parameter selection, and finally, implement K-means clustering.
layout: practical
venue: 
author:
- family: Kiburia
  given: Austin
- family: Sendyka
  given: Radzim
time: "14:00"
date: 2025-09-22
transition: None
reveal: false
ipynb: true
postsdir: ../_practicals/ # Where compiled lecture HTML files go
---

\subsection{Chimpanzee Faces}

\notes{We know that human faces are unique to each of us. But did you know that chimpanzees also have unique faces?

We will be checking if different images of the same chimpanzee would naturally cluster together. Using a sample set of 25 photos of 5 chimpanzees from [Iashin et al., 2025](https://arxiv.org/abs/2507.10552), let's see if we are able to cluster the dataset.

Let's download the photos (and other code we will need later). The [ChimpUFE](https://github.com/v-iashin/ChimpUFE) repo was created by Iashin et al. We will also be using their pre-trained neural networks for creating embeddings of the chimp's faces.

*Iashin, Vladimir, et al. "Self-supervised Learning on Camera Trap Footage Yields a Strong Universal Face Embedder." arXiv preprint arXiv:2507.10552 (2025).*}

\setupcode{#these files are quite large and take a couple minutes to download
!git clone https://github.com/v-iashin/ChimpUFE.git
!cd ChimpUFE && pip install -r requirements.txt
!wget -P ./ChimpUFE/assets/weights https://github.com/v-iashin/ChimpUFE/releases/download/v1.0/25-06-06T20-51-36_330k.pth}

\notes{This is what the chimps look like:}

\setupplotcode{import os
matplotlib.pyplot as plt
matplotlib.image as mpimg}

\plotcode{gallery = "./ChimpUFE/assets/gallery"
folders = sorted(os.listdir(gallery))

fig, axes = plt.subplots(len(folders), 5, figsize=(10, 2*len(folders)))
for i, f in enumerate(folders):
    imgs = sorted(os.listdir(os.path.join(gallery, f)))[:5]
    for j, img in enumerate(imgs):
        ax = axes[i, j]
        ax.imshow(mpimg.imread(os.path.join(gallery, f, img)))
        ax.axis("off")
        if j == 0:
            ax.text(-0.02, 0.5, f, transform=ax.transAxes, ha="right", va="center", fontsize=10)

plt.subplots_adjust(left=0.18, wspace=0.3, hspace=0.05)}

\subsection{Clustering}

\notes{
Let's use the images directly to try to cluster the pictures. After extracting the pixel values, we will apply dimensionality reduction so that we can visualise the process.}

\setupcode{import os
import numpy as np
import matplotlib.image as mpimg}

\code{paths = [os.path.join(gallery, f, img)
         for f in sorted(os.listdir(gallery))
         for img in sorted(os.listdir(os.path.join(gallery, f)))]

images = np.array([mpimg.imread(p).ravel() for p in paths])
print(images.shape)}

\setupcode{from sklearn.decomposition import PCA}
\code{images_2d = PCA(n_components=2).fit_transform(images)
print(images_2d.shape)}

\notes{Let's visualise our 2d mapping of the chimps. We can see that for the most part it's not the worst, with many similar photos grouped together, but it's surely not going to allow us to perfectly separate them.}

\setupcode{import matplotlib.pyplot as plt
from matplotlib.offsetbox import OffsetImage, AnnotationBbox
import matplotlib.image as mpimg}

\code{fig, ax = plt.subplots(figsize=(6,6))

target_px = 32

for (x, y), path in zip(images_2d, paths):
    img = mpimg.imread(path)
    h, w = img.shape[:2]
    zoom = target_px / max(h, w)
    ab = AnnotationBbox(OffsetImage(img, zoom=zoom), (x, y), frameon=False)
    ax.add_artist(ab)

mins = images_2d.min(axis=0); maxs = images_2d.max(axis=0)
pad = 0.05 * (maxs - mins)
ax.set_xlim(mins[0]-pad[0], maxs[0]+pad[0])
ax.set_ylim(mins[1]-pad[1], maxs[1]+pad[1])
ax.set_xticks([]); ax.set_yticks([])}

\subsection{K-Means}

\notes{
We will now apply K-means clustering on the mappings to group similar faces together.}

\notes{Let's implement the algorithm as presented in the [lecture](https://mlatcl.github.io/mlfc/lectures/04-01-latent-variable-modelling.html).

```
1.  First, initialize cluster centres by randomly selecting k data points
2.  Assign each data point to its nearest cluster centre
3.  Update each cluster centre by computing the mean of all points assigned to it
4.  Repeat steps 2 and 3 until the cluster assignments stop changing
```}

\codeassignment{Now, let's implement K-means clustering. Let's avoid using `scikit-learn`'s `KMeans`, or another imported library, as we want to implement it fram scratch, and visualise all the steps.}{import numpy as np

def cluster_kmeans_handwritten(X, n_clusters=5, max_iter=30, random_state=42):
    rng = np.random.RandomState(random_state)
    n_samples = X.shape[0]

    # init centers by picking random points
    centers = X[rng.choice(n_samples, n_clusters, replace=False)].copy()

    history = []
    for _ in range(max_iter):
        dists = [[]] # TODO calculate distances

        labels = [] # TODO assign to clusters

        new_centers = [] # TODO update cluster centres

        if True: # TODO stopping condition
            break

        history.append((labels.copy(), centers.copy()))
        centers = new_centers
    return history}{}

\notes{Use the widget below to visualise the progress of your K-means clustering.}

\setupcode{import numpy as np
import matplotlib.pyplot as plt
import ipywidgets as widgets
from IPython.display import display
from sklearn.decomposition import PCA
import matplotlib.image as mpimg}

\helpercode{def iterative_kmeans_widget(X, paths, n_clusters=5, max_iter=30, random_state=42):
    history = cluster_kmeans_handwritten(X, n_clusters, max_iter, random_state)
    X2 = PCA(n_components=2).fit_transform(X)

    def show_iteration(counter=0):
        labels, centers = history[counter]
        centers2 = PCA(n_components=2).fit(X).transform(centers)

        fig, (ax_scatter, ax_gallery) = plt.subplots(
            1, 2, figsize=(14, 6),
            gridspec_kw={'width_ratios':[2,3]}
        )

        cmap = plt.get_cmap("tab10")
        cluster_colors = {k: cmap(k) for k in range(n_clusters)}

        # scatter plot with explicit color mapping
        colors = [cluster_colors[l] for l in labels]
        ax_scatter.scatter(X2[:,0], X2[:,1], c=colors, s=50)
        ax_scatter.scatter(centers2[:,0], centers2[:,1], c="black", marker="x", s=100)
        ax_scatter.set_title(f"Iteration {counter}")

        # gallery
        ax_gallery.axis("off")
        cols = len(X)//n_clusters*2
        for k in range(n_clusters):
            members = np.where(labels == k)[0][:cols]
            y = n_clusters - k - 1
            for j, idx in enumerate(members):
                img = mpimg.imread(paths[idx])
                ax_gallery.imshow(img, extent=[j, j+1, y, y+1])
                ax_gallery.add_patch(
                    plt.Rectangle((j, y), 1, 1, fill=False,
                                  edgecolor=cluster_colors[k], lw=2)
                )
            ax_gallery.text(-0.5, y+0.5, f"Cluster {k}", va="center", ha="right")

        ax_gallery.set_xlim(-1, cols)
        ax_gallery.set_ylim(0, n_clusters)
        ax_gallery.set_aspect("equal")

        plt.tight_layout()
        plt.show()

    slider = widgets.IntSlider(value=0, min=0, max=len(history)-1,
                               step=1, description="Iteration")
    out = widgets.interactive_output(show_iteration, {"counter": slider})
    display(slider, out)
    return X2, history}

\code{X2, history_i2d = iterative_kmeans_widget(images_2d, paths)}

\subsection{Performance}

\notes{Reasoning about clustering performance is very diffucult, as there will often not be a simple cluster-class relationship, which will make it hard to say what image should be where. Many metrics exist, but none are perfect.

Two approaches we will use here are:
- Force a cluster-class correspondence by finding the permutation with the best accuracy.
- Adjusted Rand Index (ARI) - counting pairs of images from the same class in the same cluster, adjusting for random chance.}

\setupcode{from sklearn.metrics import adjusted_rand_score
import itertools}

\helpercode{def performance_stats(history, classes):
  labels, _ = history[-1]
  if len(classes) < 7:  # do you see why we can't run this for big inputs?
    # Forcing a class-cluster correspondence
    best = max(
        ((np.mean([dict(zip(sorted(set(labels)), perm))[l]==c for l,c in zip(labels,classes)]), dict(zip(sorted(set(labels)), perm)))
        for perm in itertools.permutations(sorted(set(classes)), len(set(labels)))),
        key=lambda x: x[0]
    )
    # print('Mapping', best[1])
    print('Best Accuracy:', best[0])
  else:
    print('Skipping Accuracy')

  # ARI
  ari = adjusted_rand_score(classes, labels)
  print("ARI:", round(ari,2))}

\code{classes = [x.split('/')[-2] for x in paths]
performance_stats(history_i2d, classes)}

\notes{Both measures report that we did do better than random chance, but not by a lot. We can definetely improve on this, as pixel values taken alone do not carry sufficient information. To show this more intuitively - our approach didn't even take into account which pixels were next to each other!}

\subsection{Face Embeddings}

\notes{
This is where Neural Networks have a significant advantage, and we can use them to improve on the very naive clustering we did above. We will be using a pre-trained model provided by Iashin et al. These embeddings encode high-level facial features in a numerical vector space.

We will now extract the embeddings for these 25 images.}

\setupcode{import os
import torch
from PIL import Image
from torch.utils.data import DataLoader
from torchvision import datasets}

\helpercode{def make_embeddings(path):
  cwd = os.getcwd()
  if os.path.basename(cwd) != "ChimpUFE":
    os.chdir("ChimpUFE") # needed to run code from demo_face_rec
  from demo_face_rec import get_model, get_embedding

  # setup
  device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
  model, tfm = get_model("./assets/weights/25-06-06T20-51-36_330k.pth", device)
  ds = datasets.ImageFolder(path, transform=tfm)
  loader = DataLoader(ds, batch_size=8, num_workers=2, shuffle=False)

  # extracting embeddings
  embs = []
  for x, _ in loader:
      embs.append(get_embedding(model, x, device).cpu())
  embeddings = torch.cat(embs, 0)
  os.chdir(cwd)
  return embeddings}

\code{embeddings = make_embeddings('./assets/gallery')
print(embeddings.shape)}

\notes{To be able to intuitively reason about the clustering and visualise it, we will again use dimensionality reduction to convert the encodings into 2 dimensions. Note, that this will hurt performance, as we're discarding most of the information.}

\code{embeddings_2d = PCA(n_components=2).fit_transform(embeddings)}

\notes{And now, we can reuse the code we wrote above to see if the clustering works better on the embeddings. It should!}

\code{X2, history_e2d = iterative_kmeans_widget(embeddings_2d, paths, random_state=2)
# the reason i'm fiddling with random state is because quite often the clustering succeeds in 1 step, which is not very illustrative}

\notes{And we again evaluate performance. The raw pixel value PCA achieved about `0.44` best accuracy and `0.13` ARI. Do we do better?}

\code{performance_stats(history_e2d, classes)}

\notes{Ee lost quite a lot of information by boiling everything down to 2 dimensions. For completeness, let's repeat the 2 above analyses without the PCA step - bear in mind that this will make the visualisations quite a bit useless, so we'll skip it.}

\code{print('Full Images')
history_i = cluster_kmeans_handwritten(images, 5)
performance_stats(history_i, classes)
print('Full Embeddings')
history_e = cluster_kmeans_handwritten(np.array(embeddings), 5)
performance_stats(history_e, classes)}

\notes{Looks like there's no big improvement, and actually, the PCA images beats full images! While the lack of improvement on 2d embeddings is unexpected (and probably with more data we would see a significant differences), the 2d PCA over raw images is actually expected to do better. Why?}

\subsection{Other datasets}

\notes{Another bigger dataset of labeled chimpanzee images was published here: [paper](https://pub.inf-cv.uni-jena.de/pdf/freytag2016chimpanzee.pdf), [github](https://github.com/cvjena/chimpanzee_faces?tab=readme-ov-file).

*Alexander Freytag and Erik Rodner and Marcel Simon and Alexander Loos and Hjalmar Kühl and Joachim Denzler: "Chimpanzee Faces in the Wild: Log-Euclidean CNNs for Predicting Identities and Attributes of Primates", German Conference on Pattern Recognition (GCPR), 2016 .*}

\code{!git clone https://github.com/cvjena/chimpanzee_faces.git}

\notes{The below text file contains a description of the dataset. We're selecting only the Filename and Name, but you might use more data in other analyses. The below code converts it into a handy dataframe.}

\setupcode{import pandas as pd}

\code{ann = "chimpanzee_faces/datasets_cropped_chimpanzee_faces/data_CTai/annotations_ctai.txt" # you can also use data_CZoo
with open(ann) as f:
  recs = [{line.strip().split()[i]: line.strip().split()[i+1] for i in [0, 2]} for line in f]
df_freytag = pd.DataFrame(recs)
df_freytag}

\codeassignment{*Assess* the data, and modify it as necessary}{# TODO assess the data and modify it as necessary}{}

\notes{Let's select a subset of this, to use in our clusterings.}

\setupcode{import random
import shutil}

\code{def sample_subset(df, n, min_, max_=None, seed=42):
    if max_ is None:
      max_ = min_
    rng = random.Random(seed)
    valid = [n for n, c in df["Name"].value_counts().items() if c >= min_]
    names = rng.sample(valid, n)
    dfs = []
    for name in names:
        sub = df[df["Name"] == name]
        n = rng.randint(min_, min(max_, len(sub)))
        dfs.append(sub.sample(n, random_state=seed))
    out = pd.concat(dfs)
    return out

df_freytag_small = sample_subset(df_freytag, 10, 10) # 10 photos each for 10 chimps

gallery_freytag = "ChimpUFE/assets/gallery_freytag"
os.makedirs(gallery_freytag, exist_ok=True)
base = "chimpanzee_faces/datasets_cropped_chimpanzee_faces/data_CTai"

for _, row in df_freytag_small.iterrows():
    identity = row["Name"]
    src = os.path.join(base, row["Filename"])
    os.makedirs(os.path.join(gallery_freytag, identity), exist_ok=True)
    dst = os.path.join(gallery_freytag, identity, os.path.basename(row["Filename"]))
    shutil.copy(src, dst)

paths_freytag = [os.path.join(gallery_freytag, f, img)
         for f in sorted(os.listdir(gallery_freytag))
         for img in sorted(os.listdir(os.path.join(gallery_freytag, f)))]

df_freytag_small}

\notes{Finally, we can run the same embedding code on the new dataset.}

\code{embeddings_freytag = make_embeddings('./assets/gallery_freytag')}

\code{embeddings_freytag_2d = PCA(n_components=2).fit_transform(embeddings_freytag)}

\code{X2, history_freytag_e2d = iterative_kmeans_widget(embeddings_freytag_2d, paths_freytag, n_clusters=10, random_state=42)}

\code{classes_freytag = df_freytag_small['Name'].values
performance_stats(history_freytag_e2d, classes_freytag)}

\notes{The adjusted Rand index tells us that our approach worked on the new dataset!}

\subsection{Hierarchical Clustering}

\notes{Hierarchical clustering is an alternative method, where all elements are at first considered their own clusters, and repetetively join the closest clusters together, until only one remains. This is very nicely visualised using [dendrograms](https://en.wikipedia.org/wiki/Dendrogram).}

\codeassignment{Using our earlier dataset, let's conduct hierarchical clustering, and produce a dendrogram.}{import numpy as np

def cluster_hierarchical_handwritten(X):
    n_samples = X.shape[0]
    clusters = {i: [i] for i in range(n_samples)}
    distances = np.full((2*n_samples-1, 2*n_samples-1), np.inf)

    # compute pairwise distances
    for i in range(n_samples):
        for j in range(i+1, n_samples):
            pass # TODO compute and set distances between samples

    Z = []
    next_cluster = n_samples

    while len(clusters) > 1:
        # find closest pair
        keys = list(clusters.keys())
        min_d, pair = np.inf, None
        for i in range(len(keys)):
            for j in range(i+1, len(keys)):
                pass # TODO calculate distance between clusters, if new best, update min_d and pair

        i, j = pair
        new_cluster = clusters[i] + clusters[j]
        Z.append([i, j, min_d, len(new_cluster)])
        clusters[next_cluster] = new_cluster
        del clusters[i], clusters[j]
        next_cluster += 1

    return np.array(Z)}{}

\setupcode{from matplotlib.offsetbox import OffsetImage, AnnotationBbox
from scipy.cluster.hierarchy import dendrogram}

\helpercode{def show_dendrogram(Z, paths, zoom=0.15):
    fig, (ax_dendro, ax_imgs) = plt.subplots(2, 1, figsize=(13, 6), gridspec_kw={"height_ratios": [100, 1]})
    dendro = dendrogram(Z, no_labels=True, ax=ax_dendro)
    ax_dendro.tick_params(left=False, bottom=False, labelleft=False, labelbottom=False)
    ax_imgs.set_xlim(ax_dendro.get_xlim())
    ax_imgs.set_ylim(0, 1)
    ax_imgs.axis("off")
    leaves = dendro["leaves"]
    xmin, xmax = ax_dendro.get_xlim()
    margin = 0.02 * (xmax - xmin)
    x_positions = np.linspace(xmin + margin, xmax - margin, num=len(leaves))

    for x, leaf_idx in zip(x_positions, leaves):
        img = mpimg.imread(paths[leaf_idx])
        imagebox = OffsetImage(img, zoom=zoom)
        ab = AnnotationBbox(imagebox, (x, 0.5), frameon=False)
        ax_imgs.add_artist(ab)

    plt.tight_layout()
    plt.show()}

\code{linkage_output = cluster_hierarchical_handwritten(embeddings_2d)
show_dendrogram(linkage_output, paths)}

\notes{End of Practical 5
```
 _______  __   __  _______  __    _  ___   _  _______  __
|       ||  | |  ||   _   ||  |  | ||   | | ||       ||  |
|_     _||  |_|  ||  |_|  ||   |_| ||   |_| ||  _____||  |
  |   |  |       ||       ||       ||      _|| |_____ |  |
  |   |  |       ||       ||  _    ||     |_ |_____  ||__|
  |   |  |   _   ||   _   || | |   ||    _  | _____| | __
  |___|  |__| |__||__| |__||_|  |__||___| |_||_______||__|
```}

\thanks
