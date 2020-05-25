; Set user-defined variables
%MACHINE_MAX_Z = 0
%TOUCH_PLATE_HEIGHT = 45
%BLEEDER_THICKNESS = 10.5
%TOOL_PROBE_X = 24.5
%TOOL_PROBE_Y = 13.5
%PROBE_FEEDRATE = 200
%PROBE_DISTANCE = -100
%PROBE_HEIGHT = -60
%TOOL_MAGAZINE_X = 138.1
%TOOL_MAGAZINE_Y = 26.5
%TOOL_MAGAZINE_Z = -110.7
%TOOLHOLDER_PREV_X = global.prevTool * 50 + TOOL_MAGAZINE_X
%TOOLHOLDER_CURRENT_X = global.activeTool * 50 + TOOL_MAGAZINE_X
%TOOLHOLDER_Y = 56.5
%TOOLCHANGE_FEEDRATE = 500
%TOOLCHANGE_RETRACT_FEEDRATE = 2500

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

; Replace previous tool into magazine and fetch current tool
M5
G90 G17 G21
G53 G0 Z[MACHINE_MAX_Z]
G53 G0 X[TOOLHOLDER_PREV_X]Y[TOOLHOLDER_Y]
G53 G1 Z[TOOL_MAGAZINE_Z] F[TOOLCHANGE_RETRACT_FEEDRATE]
G53 G1 Y[TOOL_MAGAZINE_Y] F[TOOLCHANGE_FEEDRATE]
%wait
M8
G53 G1 Z[TOOL_MAGAZINE_Z + 10] F[TOOLCHANGE_FEEDRATE]
M9
G53 G1 Z[TOOL_MAGAZINE_Z + 35]  F[TOOLCHANGE_RETRACT_FEEDRATE]
G53 G0 X[TOOLHOLDER_CURRENT_X]
G53 G1 Z[TOOL_MAGAZINE_Z + 10] F[TOOLCHANGE_RETRACT_FEEDRATE]
M8
G53 G1 Z[TOOL_MAGAZINE_Z] F[TOOLCHANGE_FEEDRATE]
M9
%wait
G53 G1 Y[TOOLHOLDER_Y] F[TOOLCHANGE_FEEDRATE]

; Probe current tool and update tool length offset
M5
G90 G17 G21
G49
G53 G0 Z[MACHINE_MAX_Z]
G53 G0 X[TOOL_PROBE_X]
G53 G0 Y[TOOL_PROBE_Y]
G91 G1 Z[PROBE_HEIGHT] F[TOOLCHANGE_RETRACT_FEEDRATE]
G38.2 Z[PROBE_DISTANCE] F[PROBE_FEEDRATE]
G91 G1 Z-1 F[PROBE_FEEDRATE]
G38.4 Z5 F[PROBE_FEEDRATE/4]
G43.1 Z[posz - TOUCH_PLATE_HEIGHT + BLEEDER_BOOLEAN]
G53 G0 Z[MACHINE_MAX_Z]

; Go to previous work position
G90
G0 X[X0]Y[Y0]

; Restore modal state
[WCS] [PLANE] [UNITS] [DISTANCE] [FEEDRATE] [SPINDLE] [COOLANT]

; Update global.prevTool
%global.prevTool = global.activeTool || 0

;Reset bleeder for next operation
%global.useBleeder = global.useBleeder - BLEEDER_THICKNESS

; Print stored values to console
(activeTool=[JSON.stringify(global.activeTool)])
(prevTool=[JSON.stringify(global.prevTool)])
(useBleeder=[JSON.stringify(global.useBleeder)])
(ready)
