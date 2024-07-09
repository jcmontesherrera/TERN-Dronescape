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
- RGB and Multispec Processing Protocol
    - Metashape Python script by Poornima et al., 2022
        - RGB and Multispec images are aligned separately, RTK positioning + offset
        - Output: RGB orthomosaic, Multispec 10-band orthomosaic
    - Metashape GUI workflow by JCMH, Robbins and Lucieer
        - RGB and Multispec images are aligned together, RTK positioning
        - Output: RGB orthomosaic, Multispec 10-band orthomosaic
- LiDAR Processing Protocol
    - DJI Terra
    - R script by Poornima et al., 2022

---
#### Contact
juancarlos.montesherrera@utas.edu.au
