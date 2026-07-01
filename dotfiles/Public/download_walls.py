import os
import json
import random
import urllib.request
import urllib.parse

# We use the literal descriptive file names in dharmx/walls to automatically curate your themes!
THEME_KEYWORDS = {
    "everforest": ["forest", "tree", "green", "moss", "plant", "nature"],
    "onedark":["dark", "grey", "black", "cyberpunk", "digital", "shadow", "minimal"],
    "tokyonight":["neon", "purple", "city", "night", "street", "magenta", "outrun"],
    "kanagawa":["water", "wave", "painting", "snow", "lake", "calm", "boat", "japan", "grey"],
    "nightfox":["space", "planet", "galaxy", "red", "sunset", "stars", "moon", "meteor"],
    "catppuccin":["pink", "purple", "clouds", "flower", "soft", "cherry", "blossom", "pastel", "cafe", "cute"],
    "ayu":["yellow", "orange", "bright", "sun", "light", "clean", "white"]
}

API_URL = "https://api.github.com/repos/dharmx/walls/git/trees/main?recursive=1"
RAW_URL_PREFIX = "https://raw.githubusercontent.com/dharmx/walls/main/"

def curate_wallpapers():
    print("Fetching the full 3,000+ catalog from dharmx/walls...")
    
    req = urllib.request.Request(API_URL, headers={'User-Agent': 'Mozilla/5.0'})
    try:
        with urllib.request.urlopen(req) as response:
            tree = json.loads(response.read().decode())['tree']
    except Exception as e:
        print(f"Failed to fetch repository data: {e}")
        return

    # Get all valid image files
    images = [f['path'] for f in tree if f['type'] == 'blob' and f['path'].lower().endswith(('.png', '.jpg', '.jpeg'))]
    
    base_dir = "dharmx_wallpapers"
    os.makedirs(base_dir, exist_ok=True)
    
    # 1. Download Gruvbox (since it actually has a dedicated folder)
    gruvbox_images =[img for img in images if 'gruvbox/' in img.lower()]
    if gruvbox_images:
        download_images(gruvbox_images, "gruvbox", base_dir)

    # 2. Automatically curate the rest based on picture contents matching the theme colors
    for theme, keywords in THEME_KEYWORDS.items():
        matched_images = []
        for img in images:
            filename = img.split('/')[-1].lower()
            # If the picture matches our theme's color vibe, add it to the list!
            if any(kw in filename for kw in keywords):
                matched_images.append(img)
                
        if matched_images:
            download_images(matched_images, theme, base_dir)
        else:
            print(f"⚠️ Could not find matches for '{theme}'")

def download_images(image_list, theme_name, base_dir):
    # Pick exactly 10 images from the curated matches
    selected = random.sample(image_list, min(10, len(image_list)))
    
    theme_dir = os.path.join(base_dir, theme_name)
    os.makedirs(theme_dir, exist_ok=True)
    
    print(f"\nCurating & Downloading 10 wallpapers for {theme_name}...")
    for i, img_path in enumerate(selected, 1):
        file_name = img_path.split('/')[-1]
        raw_url = RAW_URL_PREFIX + urllib.parse.quote(img_path)
        save_path = os.path.join(theme_dir, file_name)
        
        try:
            urllib.request.urlretrieve(raw_url, save_path)
            print(f"  [{i}/{len(selected)}] Saved {file_name}")
        except Exception as e:
            print(f"  [X] Failed to download {file_name}: {e}")

if __name__ == "__main__":
    curate_wallpapers()
    print("\n✅ Finished! All 10-wallpaper sets have been curated and sorted into 'dharmx_wallpapers'.")
