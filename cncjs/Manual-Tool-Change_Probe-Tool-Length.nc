; Set user-defined variables
%MACHINE_MAX_Z = 0
%TOUCH_PLATE_HEIGHT = 45
%BLEEDER_THICKNESS = 10.5
%TOOL_PROBE_X = 24.5
%TOOL_PROBE_Y = 13.5
%PROBE_FEEDRATE = 200
%PROBE_DISTANCE = -100
%PROBE_HEIGHT = -60

;Don't add bleeder offset when not used
%global.useBleeder = global.useBleeder + BLEEDER_THICKNESS
%BLEEDER_BOOLEAN = global.useBleeder || 0

; Keep a backup of current work position
%X0=posx, Y0=posy, Z0=posz

;Save modal state
%WCS = modal.wcs
%PLANE = modal.plane
%UNITS = modal.units
%DISTANCE = modal.distance
%FEEDRATE = modal.feedrate
%SPINDLE = modal.spindle
%COOLANT = modal.coolant

M5
G90 G17 G21
G49
G53 G0 Z[MACHINE_MAX_Z]
G53 G0 X[TOOL_PROBE_X]
G53 G0 Y[TOOL_PROBE_Y]
%wait
!
G91 G0 Z[PROBE_HEIGHT]
G38.2 Z[PROBE_DISTANCE] F[PROBE_FEEDRATE]
G91 G1 Z-1 F[PROBE_FEEDRATE]
G38.4 Z5 F[PROBE_FEEDRATE/4]
G43.1 Z[posz - TOUCH_PLATE_HEIGHT + BLEEDER_BOOLEAN]
G53 G0 Z[MACHINE_MAX_Z]
%wait

; Go to previous work position
G90
G0 X[X0]Y[Y0]
%wait

; Restore modal state
[WCS] [PLANE] [UNITS] [DISTANCE] [FEEDRATE] [SPINDLE] [COOLANT]

;Reset bleeder for next operation
%global.useBleeder = global.useBleeder - BLEEDER_THICKNESS

; Print stored values to console
(activeTool=[JSON.stringify(global.activeTool)])
(prevTool=[JSON.stringify(global.prevTool)])
(useBleeder=[JSON.stringify(global.useBleeder)])
(ready)
