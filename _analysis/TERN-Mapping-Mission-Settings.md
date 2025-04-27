## RGB + Multispec mission settings 🗺️
- *Basic settings*
	- **Name:** YYYYMMDD_PlotName_Sensor
	- **Camera -> Zenmuse P1 -> 35 mm**
	- **Safe takeoff alt:** Default
	- **Terrain follow:** Disable
	- **ASL/ALT:** Relative to Takeoff Point (ALT)
	- **Flight route altitude:** 80 m
	- **Target Surface to Takeoff Point:**
		- if Canopy less than 10 m -> 0
		- 10 to 15 m -> 10
		- 15 to 30 m -> 15
		- if > 30 m -> 30 and Flight route altitude to 110 m
	- **Take-off speed:** 15 m/s
	- **Speed:** 8 to 9 m/sec: Adjust 1 sec lower than the max speed possible
	- **Elevation optimisation:** Enable
	- **Return-to-Home:** 
		- Document settings and conditions
- *Advanced settings*
	- **Side Overlap:** 80 %
	- **Frontal Overlap:** 80 %
	- **Course angle:** 0 (N-S)
	- **Margin:** 50 m (can be reduced)
	- **Photo mode:** Timed interval shot
- *Payload settings*
	- **Focus mode:** First Waypoint Autofocus
	- **Dewarping:** Disabled

## P1 settings 📸

> [!CAUTION]
> SD empty or format required?
- **Mode:** M
- **ISO:** Auto
- **Shutter speed:** 1/1000 s
- **Aperture:** f/5.6
- **EV:** 0
- **White Bal:** Check sky code table
	- Sunny (0 - 6)
	- Overcast (7 - 8)
- **Img ratio:** 3:2
- **Img format:** .JPG

## MicaSense settings 📸
> [!TIP]
> 192.168.10.254

> [!CAUTION]
> SDs empty or require formatting?

- Check DLS & GPS status
- **Capture-Mode:** Timer
- **Timer period:** 1 sec
- **Target Alt:** 80 m
- **Alt tolerance:** 20 m
- *Manual Exposure:* Disabled
- Press **Save**
- Acquire images of Calibration Panel

## LiDAR mission settings 🗺️
> [!CAUTION]
> SD empty or format required?

- *Basic settings*
	- **Name:** YYYYMMDD_PlotName_Sensor
	- **Camera -> Zenmuse ==L1 or L2== -> LiDAR mapping**
	- **IMU calibration:** Enable
	- **Safe Take-Off Altitude:** Default
	- **Terrain Follow:** Disable
	- **ASL/ALT:** Relative to takeoff point (ALT)
	- **Flight Route Altitude:** 50 m
	- **Target Surface to Takeoff Point:**
		- 0 when takeoff when takeoff at same elevation as the site.
		- Set this to the height of representative crowns in the plot.
	- **Takeoff Speed:** 15 m/s
	- **Speed:** 5 m/s
	- **Elevation Optimization:** Disabled

- *Advanced Settings*
	- **Side Overlap (LiDAR):** 50 %
	- **Side Overlap (Visible):** Default
	- **Forward Overlap (Visible):** Default, reduce if it slows down flight speed below 5 m/s
	- **Course Angle:** 0 (North-South)
	- **Margin:** 50 m, can be reduced if necessary.
	- **Photo mode:** Timed Interval Shot

- *Payload settings ==L1 or L2==*
	- **Return Mode:**
		- **L1:** Triple
		- **L2:** Penta-Return
	- **Sampling Rate:**
		- **L1:** 160 KHz
		- **L2:** 240 KHz
	- **Scanning Mode:** Repetitive
	- **RGB Coloring** Enable

- *RGB Camera settings in L1 View*
	- **S** - Shutter priority
	- **Shutter speed:** 1/1000 s
	- **Aperture and ISO:** Auto
	- **White Balance:** 
		- Sunny: Sky code 0 to 6
		- Cloudy: Sky code 7 to 8
	- **Image ratio:** 3:2, **IMG format:** jpeg
	- **Mechanical shutter:** Enabled
	- **Dewarping:** Enabled
