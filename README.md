# Dronescape Field Protocols and Checklists 🚁🏞️

Protocols and checklists for drone imagery and point cloud collection utilized in the Dronescape and Naturescan projects, conducted by the Terrestrial Ecosystem Research Network (TERN) at the University of Adelaide, and the Terraluma Lab at the University of Tasmania.

## Planning

- Forms, Permits and Risk Assessments
- [Exploratory *ausplotsR* script 🔎](Files/ausplotsR_exploratory.R)
- [Field Gear & Hardware Checklist 🛠️🚁📦](Files/TERN-FieldGear-Checklist.md)
- Charge batteries, cache satellite image in controller.

## Pre-flight

- [Mapping Mission Settings 🚁](Files/TERN-Mapping-Mission-Settings.md)

## Flight

- [Metadata Template 📝](Files/TERN-Metadata-Drone-Flight.md)

## Post-Flight
- Data Backup Protocol
- RGB and Multispec Processing Protocol
    - Metashape Python script by Poornima et al., 2022
        - RGB and Multispec images are aligned separately, RTK positioning + offset
        - Output: RGB orthomosaic, Multispec 10-band reflectance orthomosaic
    - Metashape GUI workflow by JCMH, Robbins, Dell, Turner and Lucieer
        - RGB and Multispec images are aligned together, RTK positioning
        - Output: RGB orthomosaic, Multispec 10-band reflectance orthomosaic
- LiDAR Processing Protocol
    - DJI Terra
    - R script by Poornima et al., 2022
- Data Upload to TERN Data Discovery Portal
    - Rclone commands and steps

---
#### Contact
juancarlos.montesherrera@utas.edu.au
![TerraLuma]("Figures-Logos\Terraluma-logo.png"|100)
![TERN](Figures-Logos\TERN-logo.png|100)
![UTAS](Figures-Logos\UTAS-logo.png|100)
![UniAde](Figures-Logos\UniAdelaide-Logo.jpg|100)


