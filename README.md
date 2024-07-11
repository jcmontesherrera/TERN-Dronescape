# Dronescape Field Protocols and Checklists 🚁🏞️

Protocols and checklists for drone imagery and point cloud collection utilized in the Dronescape and Naturescan projects, conducted by the Terraluma Lab at the University of Tasmania, and the Terrestrial Ecosystem Research Network (TERN) at the University of Adelaide.

## 1. Planning

- Forms, Permits and Risk Assessments
- [Exploratory *ausplotsR* script 🔎](Files/ausplotsR_exploratory.R)
- [Field Gear & Hardware Checklist 🛠️🚁📦](Files/TERN-FieldGear-Checklist.md)
- Charge batteries, cache satellite image in controller.

## 2. Pre-flight

- [Mapping Mission Settings 🚁](Files/TERN-Mapping-Mission-Settings.md)

## 3. Flight

- [Metadata Template 📝](Files/TERN-Metadata-Drone-Flight.md)

## 4. Post-Flight
- Prepare for next flight or day
- Data Backup Protocol

## 5. Data Processing
- RGB and Multispec Processing Protocol
    1. [Metashape Python script by Poornima et al., 2022](https://github.com/ternaustralia/drone_metashape) - TERN GitHub
        - RGB and Multispec images are aligned separately, RTK positioning + offset
    2. Metashape GUI workflow by JCMH, Robbins, Dell, Turner and Lucieer
        - RGB and Multispec images are aligned together, RTK positioning
    - Both approcahes output an RGB orthomosaic and Multispec 10-band reflectance orthomosaic
- LiDAR Processing Protocol
    - DJI Terra
    - R script by Poornima et al., 2022
- Cloud Optimized GeoTiffs and Point Clouds
    - Script by Poornima et al., 2022
- SpatioTemporal Asset Catalog (STAC) creation
- Data Upload to TERN Data Discovery Portal
    - Rclone commands and steps

## 6. Access, Training and Applications
- TERN Data Discovery Portal - How to Use
- GeoNadir
- GIS and Image analysis
- Case studies


---
#### Contact
juancarlos.montesherrera@utas.edu.au<
