<p align="center">
  <img src="logo.png" alt="HKV — World Meteorological Organization — CREWS Climate Risk & Early Warning Systems" width="800"/>
</p>

<h1 align="center">CREWS UFFFS Nowcast — Lao PDR & Cambodia</h1>

<p align="center">
  <em>Training material for the CREWS Urban Flash Flood Forecasting System workshops</em>
</p>

<p align="center">
  <a href="#about-the-programme">About</a> •
  <a href="#repository-overview">Overview</a> •
  <a href="#prerequisites">Prerequisites</a> •
  <a href="#installation">Installation</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#notebooks">Notebooks</a> •
  <a href="#data-access">Data Access</a> •
  <a href="#license">License</a>
</p>

---

## About the Programme

The **Climate Risk and Early Warning Systems (CREWS)** initiative supports Least Developed Countries and Small Island Developing States in strengthening their early warning capacity. As part of CREWS, the [World Meteorological Organization (WMO)](https://wmo.int/) is implementing **Urban Flash Flood Forecasting Systems (UFFFS)** for two cities in mainland Southeast Asia, with [HKV](https://www.hkv.nl/en/) providing the technical implementation:

| Country | City |
|---|---|
| 🇱🇦 Lao PDR | Vientiane |
| 🇰🇭 Cambodia | Phnom Penh |

Urban flash floods develop within hours of extreme rainfall, are very localised, and disproportionately affect informal and low-income settlements in rapidly urbanising cities. The CREWS UFFFS combines satellite rainfall observation, short-term ensemble nowcasting, and rain-gauge validation into the **observation and nowcasting** stage of an end-to-end early warning chain — built on open-source tools and openly available data, so that the national meteorological and hydrological services of Lao PDR and Cambodia can operate the system independently.

This repository contains the **training material** developed for the capacity-building workshops held during the programme. The notebooks are designed as self-contained, hands-on tutorials that guide participants through every step of the satellite rainfall and nowcasting workflow.

> **Scope of this repository.** This repo covers the rainfall **observation and nowcasting** components only. The hydrodynamic flood-modelling component for Vientiane and Phnom Penh is handled separately.

---

## Repository Overview

The repository contains a single Python environment and three sequential tutorial notebooks:

```
CREWS_UFFFS_Nowcast/
├── README.md
├── LICENSE
├── logo.png
├── pixi.toml                           ← Environment definition
├── install.bat                         ← Run once to set up the environment (Windows)
├── start.bat                           ← Launch Jupyter Lab (Windows)
│
├── 1_Download_GSMaP_Rainfall.ipynb     ← Download & preprocess GSMaP rainfall via GEE
├── 2_Nowcast_GSMaP_Rainfall.ipynb      ← Run pySTEPS, save ensemble nowcast NetCDF
├── 3_Interpret_GSMaP_Nowcast.ipynb     ← Ensemble products, gauge validation, GeoTIFF export
│
├── data/                               ← Auto-created by postinstall (see below)
│   ├── gsmap/{raw,processed}
│   └── gauges/
└── outputs/                            ← Auto-created by postinstall
    ├── figures/
    ├── nowcasts/
    └── tables/
```

The `data/` and `outputs/` folders are created automatically by the `postinstall` task when you run `install.bat`.

---

## Prerequisites

### Install Pixi

The environment is managed with [**Pixi**](https://pixi.sh) — a fast, cross-platform package manager built on the conda ecosystem. Pixi reads the `pixi.toml` file and creates a reproducible, isolated Python environment with all required dependencies. You do **not** need to install Anaconda, Miniconda, or any other Python distribution beforehand.

#### How to Install Pixi

1. Go to the **Pixi installation page**: [https://pixi.sh/latest/#installation](https://pixi.sh/latest/#installation)

2. **On Windows** (recommended method), open **PowerShell** and run:
   ```powershell
   winget install prefix-dev.pixi
   ```
   Alternatively, you can use the installer script:
   ```powershell
   iwr -useb https://pixi.sh/install.ps1 | iex
   ```

3. **Verify the installation** by opening a new terminal window and running:
   ```
   pixi --version
   ```
   You should see a version number. If you get a "command not found" error, close and reopen your terminal, or restart your computer.

> **Tip:** If you are behind a corporate proxy or firewall, see the [Pixi documentation](https://pixi.sh/latest/) for proxy configuration instructions.

### Register for Google Earth Engine

The GSMaP rainfall download in Notebook 1 uses the **Google Earth Engine (GEE)** Python API. You will need a free GEE account associated with a Google Cloud project:

1. Sign up at [https://earthengine.google.com/signup/](https://earthengine.google.com/signup/)
2. Create or select a Google Cloud project to associate with Earth Engine
3. After installation (see below), authenticate once per machine by running:
   ```
   pixi run ee-auth
   ```
   This opens a browser window for the OAuth flow. Verify with:
   ```
   pixi run ee-test
   ```

---

## Installation

You only need to run the installation **once**.

### Step 1: Install the environment

Navigate to the repository folder and **double-click `install.bat`** (or run it from a terminal). The script will:

1. Clean any previous environment
2. Download and install all Python dependencies via Pixi
3. Register a Jupyter kernel so the notebooks can find the environment
4. Create the `data/` and `outputs/` folder structure used by the notebooks

```
install.bat
```

> **Note:** The first installation may take several minutes as Pixi downloads all packages. Subsequent installs are much faster thanks to caching.

### Step 2: Authenticate Earth Engine (first time only)

Open a terminal in the repository folder and run:

```
pixi run ee-auth
```

This is interactive and only needs to be done once per machine and Google account.

### Step 3: Launch Jupyter Lab

**Double-click `start.bat`** (or run it from a terminal):

```
start.bat
```

Jupyter Lab will open automatically. Navigate to the notebook you want to run and make sure the correct kernel is selected (see the kernel name in the top-right corner).

### Quick Reference

| Action | Command |
|---|---|
| Install (run once) | `install.bat` |
| Authenticate Earth Engine (run once per machine) | `pixi run ee-auth` |
| Start Jupyter Lab | `start.bat` |
| Kernel name | `CREWS UFFFS Nowcast (pixi)` |
| Verify environment | `pixi run check` |
| Verify raster stack only | `pixi run check-raster` |
| Verify Earth Engine | `pixi run ee-test` |
| Run Notebook 1 headlessly | `pixi run run-download` |
| Run Notebook 2 headlessly | `pixi run run-nowcast` |
| Run Notebook 3 headlessly | `pixi run run-interpret` |

---

## Getting Started

We recommend working through the notebooks in order:

### Notebook 1 — Download, Preprocess, and Analyse GSMaP

Entry point for working with satellite precipitation data. It covers:

- Defining the workshop event period and area of interest
- Authenticating to Google Earth Engine
- Downloading GSMaP rainfall-rate data as GeoTIFF tiles
- Combining GeoTIFFs into a single CF-compliant NetCDF
- Inspecting individual rainfall fields and accumulations
- Basic quality checks on the rainfall product
- Zooming in around Vientiane and Phnom Penh
- Visualising mean, maximum, and accumulated rainfall

**Key concept:** GSMaP (Global Satellite Mapping of Precipitation) is JAXA's gauge-corrected, multi-satellite precipitation product, providing global rainfall estimates at hourly resolution and ~10 km grid spacing. Accessed here through the GEE catalog (`JAXA/GPM_L3/GSMaP/v8/operational`).

### Notebook 2 — Create the Nowcast with pySTEPS

Building on the preprocessed data from Notebook 1, this tutorial focuses on **producing** the nowcast:

- Configuring nowcast settings (input window, lead time, ensemble size, domain)
- Selecting the most recent input fields for nowcasting
- Generating a **persistence baseline** for comparison
- Running an ensemble STEPS nowcast and a deterministic extrapolation diagnostic
- Visualising motion vectors, ensemble mean, and ensemble maximum
- Saving the nowcast as NetCDF for re-use in Notebook 3

**Key concept:** STEPS (Short-Term Ensemble Prediction System) extrapolates observed rainfall patterns forward in time using optical flow, while adding stochastic perturbations at different spatial scales to represent forecast uncertainty.

### Notebook 3 — Interpret, Validate, and Apply the Nowcast

Picks up from the saved NetCDF in Notebook 2 and is **independently runnable**. Covers:

- Computing **ensemble statistics**, **exceedance probabilities**, and ensemble spread
- Zooming around Vientiane and Phnom Penh
- Building a nowcast animation
- Extracting **point time series** and **threshold-probability tables** for each city
- Comparing GSMaP and the nowcast against a **rain-gauge CSV**
- Optional **validation** against withheld GSMaP observations
- Exporting operational products to **GeoTIFF**

This is where the workshop **exercises** for ensemble interpretation, gauge comparison, and operational use sit. Notebook 2 is intentionally lean so trainees can produce a nowcast quickly; Notebook 3 is where they spend time interpreting it.

---

## Data Access

The notebooks fetch GSMaP rainfall data **on-the-fly from Google Earth Engine** — no preloaded data archive is shipped with this repository. After authenticating Earth Engine (see [Prerequisites](#prerequisites)), Notebook 1 will download the rainfall fields for the event you configure.

For the rain-gauge comparison in Notebook 2 (Step 22), the notebook expects a CSV at `data/gauges/example_rain_gauge_observations.csv`. An example file can be requested from the contact below.

> **📧 To obtain example rain-gauge data, please contact [j.aerts@hkv.nl](mailto:j.aerts@hkv.nl)**

---

## Key Technologies

| Component | Technology | Description |
|---|---|---|
| Satellite rainfall | [GSMaP](https://sharaku.eorc.jaxa.jp/GSMaP/) | JAXA Global Satellite Mapping of Precipitation |
| Data access | [Google Earth Engine](https://earthengine.google.com/) | Cloud-hosted geospatial catalog and Python API |
| Nowcasting | [pysteps](https://pysteps.readthedocs.io/) | Short-term ensemble prediction of precipitation |
| Environment management | [Pixi](https://pixi.sh) | Reproducible conda-based environments |
| Notebooks | [Jupyter Lab](https://jupyter.org/) | Interactive computing platform |

---

## Troubleshooting

**"pixi not found" when running install.bat**
Make sure Pixi is installed (see [Prerequisites](#prerequisites)) and that you opened a **new** terminal window after installation.

**Installation fails with dependency conflicts**
Try running `pixi clean` in the repository folder, then `install.bat` again. If the problem persists, ensure you have a stable internet connection and that no VPN or firewall is blocking access to `conda-forge`.

**Wrong kernel in Jupyter**
After opening a notebook, check the kernel name in the top-right corner. Use **Kernel → Change Kernel** and select **`CREWS UFFFS Nowcast (pixi)`**.

**GDAL/rasterio DLL errors on Windows**
This usually indicates a version mismatch from a previous mixed install. Run `install.bat` again (which calls `pixi clean` first) and confirm with `pixi run check-raster`. The GDAL/rasterio versions in `pixi.toml` are intentionally pinned to avoid the most common Windows DLL issues — do **not** install rasterio, rioxarray, or GDAL with pip in this project.

**Earth Engine authentication fails**
Make sure you have signed up for Earth Engine and associated a Google Cloud project ([signup link](https://earthengine.google.com/signup/)). Then run `pixi run ee-auth` and follow the browser prompts. Verify with `pixi run ee-test`. Some institutional networks block the OAuth flow — try a personal network if it fails.

---

## Contributing

This material is developed as part of the CREWS UFFFS programme. If you find issues or have suggestions for improvement, please open an issue on this repository or contact the development team.

---

## Contact

For questions about the workshop material, data access, or the CREWS UFFFS Nowcast programme:

📧 **Jerom Aerts** — [j.aerts@hkv.nl](mailto:j.aerts@hkv.nl)

---

## License

This repository is released under the [CC0 1.0 Universal](LICENSE) public domain dedication. You can copy, modify, and distribute the material.

---

<p align="center">
  <sub>Developed by <a href="https://www.hkv.nl/en/">HKV</a> for the <a href="https://wmo.int/">World Meteorological Organization</a> as part of the <a href="https://www.crews-initiative.org/">Climate Risk and Early Warning Systems (CREWS)</a> initiative.</sub>
</p>
