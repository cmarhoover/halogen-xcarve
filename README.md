# halogen-xcarve
- Files for customized CNC router, based on X-Carve XXL, using X-Controller driver board with <a href="https://github.com/gnea/grbl">GRBL 1.1h</a>
- Features include:
  - Server setup with all necessary electronics inside modified X-controller extrusion. Access via any network device with web browser. Gcode processed locally, preventing accidental disconnects. Touch screen connected directly to controller with touch-optimized interface enabled.
  - Approx 30" x 30" x 5" usable work area.
  - 24K rpm spindle with auto-tool change capability. Supports ISO10 tool holders / ER16 collets.
  - Retractable tool magazine.
  - Tool length probing. 
  - Vacuum grid for clamp-free hold down. Optional bleeder board for use with throughcuts. 
  - Dust collection system with auto-on during machining.  

### hardware changes:
- Mechatron HFSAC-6508-ER11 spindle + Mechatron STC65 tool changer + Omron MX2 VFD<br>
- Customized X-controller box with add'l components:<br>
  - Lattepanda v1 2G/32G Intel Atom z8350 + integrated arduino leonardo.
    - <a href="https://manjaro.org/downloads/official/xfce/">Manjaro XFCE</a> (operating system) 
    - <a href="https://cnc.js.org/">cncjs</a> (server) 
    - <a href="https://wiki.shapeoko.com/index.php/LCD_on_GRBL">lcd on grbl</a> (running on leonardo to power 20x4 LCD) 
  - Buck converters for 12v and 5v
  - 12v relay bank
  - 20x4 LCD
  - Quick release E-stop
  - Wifi antenna
  - Noctua 40mm x 40mm 12v quiet fan
- 1000mm x 1000mm makerslide frame, stiffened / raised.
- 8mm lead screws. Based on kit from <a href="https://mfxworkshop.com/product/screwdrive-kit-2-lift/">MFX Workshop</a>. 
- Custom Z-axis linear slide.
- Custom SLA printed dust shoe.
- Custom HDPE vacuum grid on MDF/steel table + Ametek 3-stage vacuum motor.
- Custom acrylic retractable tool magazine.
- Metrol P21 tool setter
- OpenBuilds 24v ring LED
- Festo 24v Solenoids
- Festo regulator / air filter
- Ultramation linear thrusters
- Static discharge swivel vacuum hose
- Eyoyo 15" TFT touch screen

### software changes:
- Custom Fusion 360 post to enable automatic tool changes, probing, and bleeder board compensation.
- Custom cncjs macros to perform automatic tool changes, probing, and bleeder board compensation.

### basic workflow principles:
- Custom fusion 360 post inserts global variables into gcode that are processed by macros in cncjs. 

### documentation
- Video of auto-tool change / probing routine <a href="https://youtu.be/f6pbz_fGYno">here</a>. 
