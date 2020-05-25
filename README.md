# halogen-xcarve
Files for customized CNC router, based on X-Carve XXL.

Major hardware changes:
-Mechatron HFSAC-6508-ER11 spindle + Mechatron STC65 tool changer + Omron MX2 VFD
-Customized X-controller box with add'l components:
  •Lattepanda v1 2G/32G with integrated arduino leonardo. Running Manjaro 20 Lysia and cncjs
  •Buck converters for 12v and 5v
  •12v relay bank
  •20x4 LCD
  •Quick release E-stop
  •Wifi antenna
-1000mm x 1000mm makerslide frame, stiffened / raised.
-8mm lead screws for all axes. Based on kit from MFX Workshop
-Custom Z-axis linear slide.
-Custom SLA printed dust shoe.
-Custom HDPE vacuum grid on MDF/steel table + Ametek 3-stage vacuum motor.
-Custom acrylic retractable tool magazine.

Major software changes:
-Custom Fusion 360 post to enable automatic tool changes and bleeder board compensation.
-Custom cncjs macros to perform automatic tool changes and allow bleeder board compensation.
