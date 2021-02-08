package provide video_ctrl 0.1
package require Tcl 8.5

proc createParameters {BaseName BaseAddress} {
  toolkit_add ${BaseName}Tab group TABS {expandableX true expandableY true itemsPerRow 3}
  toolkit_set_property ${BaseName}Tab title ${BaseName}

    toolkit_add  ${BaseName}ParametersGroup group ${BaseName}Tab {itemsPerRow 1 minWidth 120}
      toolkit_set_property ${BaseName}ParametersGroup title "Parameters"

        toolkit_add  ${BaseName}BaseAddrGroup group ${BaseName}ParametersGroup {expandableX true itemsPerRow 1 minWidth 120}
          toolkit_set_property ${BaseName}BaseAddrGroup title "${BaseName} Base Address"

            toolkit_add  ${BaseName}BaseAddressText textField ${BaseName}BaseAddrGroup
              toolkit_set_property ${BaseName}BaseAddressText minWidth 80
              toolkit_set_property ${BaseName}BaseAddressText text $BaseAddress

        toolkit_add  ${BaseName}ButtonsGroup group ${BaseName}ParametersGroup {expandableX true itemsPerRow 2 minWidth 120}
          toolkit_set_property ${BaseName}ButtonsGroup title "Operation"

            toolkit_add ${BaseName}ReadButton button ${BaseName}ButtonsGroup
              toolkit_set_property ${BaseName}ReadButton text "Read"
              toolkit_set_property ${BaseName}ReadButton onClick "::video_ctrl::${BaseName}ReadButton_onClick"

            toolkit_add ${BaseName}WriteButton button ${BaseName}ButtonsGroup
              toolkit_set_property ${BaseName}WriteButton text "Write"
              toolkit_set_property ${BaseName}WriteButton onClick "::video_ctrl::${BaseName}WriteButton_onClick"
}

proc create_register {BaseName BaseGroup RegName Title {Edit true} {Dec false}} {
    toolkit_add  ${BaseName}${BaseGroup}${RegName}Group group ${BaseName}${BaseGroup}Group {expandableX true minWidth 200}
      toolkit_set_property ${BaseName}${BaseGroup}${RegName}Group title "${BaseName} ${Title}"

    toolkit_add ${BaseName}${BaseGroup}${RegName}Text textField ${BaseName}${BaseGroup}${RegName}Group {minWidth 80}
      toolkit_set_property ${BaseName}${BaseGroup}${RegName}Text text "0x0"
      toolkit_set_property ${BaseName}${BaseGroup}${RegName}Text editable $Edit

  if {$Dec} {
    toolkit_add ${BaseName}${BaseGroup}${RegName}DecText label ${BaseName}${BaseGroup}${RegName}Group {minWidth 80}
      toolkit_set_property ${BaseName}${BaseGroup}${RegName}DecText text "0"
  }
}

proc create_led {BaseName BaseGroup RegName BitName Text} {
    toolkit_add ${BaseName}${BaseGroup}${RegName}${BitName}Led led ${BaseName}${BaseGroup}${RegName}Group
    toolkit_set_property ${BaseName}${BaseGroup}${RegName}${BitName}Led text $Text
    toolkit_set_property ${BaseName}${BaseGroup}${RegName}${BitName}Led color green_off
}

namespace eval ::video_ctrl {

  set control_width 80

  set amm [lindex [get_service_paths master] 0]
  set claim_path [claim_service master $amm mylib]

  toolkit_set_property  self title "Video control"
  toolkit_set_property  self itemsPerRow 1
  toolkit_set_property  self visible true

  toolkit_add TABS tabbedGroup self {expandableX true expandableY true}

  createParameters CVI "0x0"

  toolkit_add  CVIRegistersGroup group CVITab {itemsPerRow 1 minWidth 120}
    toolkit_set_property CVIRegistersGroup title "CVI registers"

  create_register CVI Registers Control "Control"
  create_led CVI Registers Control Go "Go"
  create_led CVI Registers Control StatusInterrupt "Status Interrupt"
  create_led CVI Registers Control FrameInterrupt "Frame interrupt"

  create_register CVI Registers Status "Status" false
  create_led CVI Registers Status Status     "Status"
  create_led CVI Registers Status Interlace  "Interlace"
  create_led CVI Registers Status Stable     "Stable"
  create_led CVI Registers Status Overflow   "Overflow"
  create_led CVI Registers Status Resolution "Resolution"
  create_led CVI Registers Status Locked     "Locked"
  create_led CVI Registers Status Clipping   "Clipping"
  create_led CVI Registers Status Padding    "Padding"
  create_led CVI Registers Status DropSticky "DropSticky"

  toolkit_add CVIDropCountText textField CVIRegistersStatusGroup {minWidth 80}
    toolkit_set_property CVIDropCountText text "0"
    toolkit_set_property CVIDropCountText editable false

  create_register CVI Registers Interrupt "Interrupt"
  create_led CVI Registers Interrupt Status   "Status Update"
  create_led CVI Registers Interrupt EndFrame "End field/frame"

  create_register CVI Registers UsedWords   "Used Words"           false true
  create_register CVI Registers SampleCount "Sample Count"         false true
  create_register CVI Registers F0Count     "F0 Active Line Count" false true
  create_register CVI Registers F1Count     "F1 Active Line Count" false true
  create_register CVI Registers TotalSample "Total Sample Count"   false true
  create_register CVI Registers F0LineCount "F0 Total Line Count"  false true
  create_register CVI Registers F1LineCount "F1 Total Line Count"  false true
              
#############################################################################################
  createParameters Mixer "0x0"

  toolkit_add  MixerLayerSelectGroup group MixerParametersGroup {expandableX true itemsPerRow 1 minWidth 120}
    toolkit_set_property MixerLayerSelectGroup title "Mixer Select Layer"

      toolkit_add  MixerLayerText textField MixerLayerSelectGroup
        toolkit_set_property MixerLayerText minWidth $control_width
        toolkit_set_property MixerLayerText text 0

  toolkit_add  MixerRegistersGroup group MixerTab {itemsPerRow 1 minWidth 120}
    toolkit_set_property MixerRegistersGroup title "Mixer registers"

  create_register Mixer Registers Control "Control"
  create_led Mixer Registers Control Go "Go"

  create_register Mixer Registers Status "Status" false
  create_led Mixer Registers Status Status "Status"

  create_register Mixer Registers BKGWidth  "Background Width"  true true
  create_register Mixer Registers BKGHeight "Background Height" true true
  create_register Mixer Registers BKGRed    "Background Red"    true true
  create_register Mixer Registers BKGGreen  "Background Green"  true true
  create_register Mixer Registers BKGBlue   "Background Blue"   true true

  toolkit_add  MixerLayerGroup group MixerTab {itemsPerRow 1 minWidth 120}
    toolkit_set_property MixerLayerGroup title "Mixer Layer"

  create_register Mixer Layer XOffset "Layer X offset"
  create_register Mixer Layer YOffset "Layer Y offset"
  create_register Mixer Layer Control "Layer Control"
  create_led Mixer Layer Control Control "Enable"
  create_led Mixer Layer Control Consume "Consume"
  toolkit_add MixerLayerControlAlphaModeText textField MixerLayerControlGroup {minWidth 80}
    toolkit_set_property MixerLayerControlAlphaModeText text "No blending"
    toolkit_set_property MixerLayerControlAlphaModeText editable false
  create_register Mixer Layer LayerPosition "Layer Position"
  create_register Mixer Layer LayerAlpha    "Layer Static Aplha"

#############################################################################################
  createParameters Scaler "0x200"

  toolkit_add  ScalerRegistersGroup group ScalerTab {itemsPerRow 1 minWidth 120}
    toolkit_set_property ScalerRegistersGroup title "Scaler registers"

  create_register Scaler Registers Control "Control"
  create_led Scaler Registers Control Go "Go"

  create_register Scaler Registers Status "Status" false
  create_led Scaler Registers Status Status "Status"
  create_led Scaler Registers Status CoeffSelection "Edge adaptive coefficient selection"

  create_register Scaler Registers Width  "Output Width"  true true
  create_register Scaler Registers Height "Output Height" true true

#############################################################################################
  createParameters Clipper "0x400"

  toolkit_add  ClipperRegistersGroup group ClipperTab {itemsPerRow 1 minWidth 120}
    toolkit_set_property ClipperRegistersGroup title "Clipper registers"

  create_register Clipper Registers Control "Control"
  create_led Clipper Registers Control Go "Go"

  create_register Clipper Registers Status "Status" false
  create_led Clipper Registers Status Status "Status"

  create_register Clipper Registers LeftOffset   "Left Offset"          true true
  create_register Clipper Registers RightOffset  "Right Offset/Width"   true true
  create_register Clipper Registers TopOffset    "Top Offset"           true true
  create_register Clipper Registers BottomOffset "Bottom Offset/Height" true true

#############################################################################################
  createParameters FIR "0x800"

  toolkit_add  FIRRegistersGroup group FIRTab {itemsPerRow 1 minWidth 120}
    toolkit_set_property FIRRegistersGroup title "FIR registers"

  create_register FIR Registers Control "Control"
  create_led FIR Registers Control Go "Go"

  create_register FIR Registers Status "Status" false
  create_led FIR Registers Status Status "Status"

  create_register FIR Registers SearchBlur "Blur Search Range"
  create_register FIR Registers LowerBlur  "Lower Blur Threshold"
  create_register FIR Registers UpperBlur  "Upper Blur Threshold"

#############################################################################################
  createParameters Switch "0x400"

  toolkit_add  SwitchRegistersGroup group SwitchTab {itemsPerRow 1 minWidth 220}
    toolkit_set_property SwitchRegistersGroup title "Switch registers"

  create_register Switch Registers Control "Control"
  create_led Switch Registers Control Go "Go"

  create_register Switch Registers Status "Status" false
  create_led Switch Registers Status Status "Status"

  create_register Switch Registers Interrupt "Interrupt" false
  create_led Switch Registers Interrupt Interrupt "Interrupt"

  toolkit_add  SwitchRegistersUpdateGroup group SwitchRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
    toolkit_set_property SwitchRegistersUpdateGroup title "Switch Update"
 
  toolkit_add SwitchRegistersUpdateButton button SwitchRegistersUpdateGroup
    toolkit_set_property SwitchRegistersUpdateButton text "Update"
    toolkit_set_property SwitchRegistersUpdateButton onClick "::video_ctrl::SwitchUpdateButton_onClick"
  create_led Switch Registers Update Freezze "Freezze"

  toolkit_add  SwitchDoutGroup group SwitchTab {itemsPerRow 2 minWidth 220}
    toolkit_set_property SwitchDoutGroup title "Switch Dout"

  create_register Switch Dout Dout0      "Dout0 Output Control"
  create_register Switch Dout Dout1      "Dout1 Output Control"
  create_register Switch Dout Dout2      "Dout2 Output Control"
  create_register Switch Dout Dout3      "Dout3 Output Control"
  create_register Switch Dout Dout4      "Dout4 Output Control"
  create_register Switch Dout Dout5      "Dout5 Output Control"
  create_register Switch Dout Dout6      "Dout6 Output Control"
  create_register Switch Dout Dout7      "Dout7 Output Control"
  create_register Switch Dout Dout8      "Dout8 Output Control"
  create_register Switch Dout Dout9      "Dout9 Output Control"
  create_register Switch Dout Dout10     "Dout10 Output Control"
  create_register Switch Dout Dout11     "Dout11 Output Control"
  create_register Switch Dout Dout12     "Dout12 Output Control"
  create_register Switch Dout Dout13     "Dout13 Output Control"
  create_register Switch Dout Dout14     "Dout14 Output Control"
  create_register Switch Dout Dout15     "Dout15 Output Control"
  create_register Switch Registers DinConsume "Din Consume Mode Enable"
}

proc get_bit {Data Bit} {
  if [expr {($Data & $Bit) == $Bit}] {
    return green
  } else {
    return green_off
  } 
}

proc ::video_ctrl::CVIReadButton_onClick {} {
  variable claim_path

  set read_control [master_read_32 $claim_path [toolkit_get_property CVIBaseAddressText text] 1]
  toolkit_set_property CVIRegistersControlText               text  $read_control
  toolkit_set_property CVIRegistersControlGoLed              color [get_bit $read_control 0x1]
  toolkit_set_property CVIRegistersControlStatusInterruptLed color [get_bit $read_control 0x2]
  toolkit_set_property CVIRegistersControlFrameInterruptLed  color [get_bit $read_control 0x4]

  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (1 * 4)}] 1]
  toolkit_set_property CVIRegistersStatusStatusLed     color [get_bit $read_status 0x0001]
  toolkit_set_property CVIRegistersStatusInterlaceLed  color [get_bit $read_status 0x0080]
  toolkit_set_property CVIRegistersStatusStableLed     color [get_bit $read_status 0x0100]
  toolkit_set_property CVIRegistersStatusOverflowLed   color [get_bit $read_status 0x0200]
  toolkit_set_property CVIRegistersStatusResolutionLed color [get_bit $read_status 0x0400]
  toolkit_set_property CVIRegistersStatusLockedLed     color [get_bit $read_status 0x0800]
  toolkit_set_property CVIRegistersStatusClippingLed   color [get_bit $read_status 0x1000]
  toolkit_set_property CVIRegistersStatusPaddingLed    color [get_bit $read_status 0x2000]
  toolkit_set_property CVIRegistersStatusDropStickyLed color [get_bit $read_status 0x4000]
  toolkit_set_property CVIDropCountText                text  [expr {($read_status & 0x3f8000) >> 15}]
  toolkit_set_property CVIRegistersStatusText          text  $read_status

  set read_interrupt [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (2 * 4)}] 1]
  toolkit_set_property CVIRegistersInterruptStatusLed   color [get_bit $read_status 0x2]
  toolkit_set_property CVIRegistersInterruptEndFrameLed color [get_bit $read_status 0x4]
  toolkit_set_property CVIRegistersInterruptText        text $read_interrupt

  toolkit_set_property CVIRegistersUsedWordsText   text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property CVIRegistersSampleCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (4 * 4)}] 1]
  toolkit_set_property CVIRegistersF0CountText     text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (5 * 4)}] 1]
  toolkit_set_property CVIRegistersF1CountText     text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (6 * 4)}] 1]
  toolkit_set_property CVIRegistersTotalSampleText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (7 * 4)}] 1]
  toolkit_set_property CVIRegistersF0LineCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (8 * 4)}] 1]
  toolkit_set_property CVIRegistersF1LineCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (9 * 4)}] 1]
  toolkit_set_property CVIRegistersUsedWordsDecText   text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (3 * 4)}] 1]]
  toolkit_set_property CVIRegistersSampleCountDecText text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (4 * 4)}] 1]]
  toolkit_set_property CVIRegistersF0CountDecText     text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (5 * 4)}] 1]]
  toolkit_set_property CVIRegistersF1CountDecText     text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (6 * 4)}] 1]]
  toolkit_set_property CVIRegistersTotalSampleDecText text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (7 * 4)}] 1]]
  toolkit_set_property CVIRegistersF0LineCountDecText text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (8 * 4)}] 1]]
  toolkit_set_property CVIRegistersF1LineCountDecText text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (9 * 4)}] 1]]
}

proc ::video_ctrl::CVIWriteButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [toolkit_get_property CVIBaseAddressText text] [toolkit_get_property CVIControlText text]
  ::video_ctrl::CVIReadButton_onClick
}

proc ::video_ctrl::MixerReadButton_onClick {} {
  variable claim_path
  set read_control   [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (0 * 4)}] 1]
  toolkit_set_property MixerRegistersControlText  text  $read_control
  toolkit_set_property MixerRegistersControlGoLed color [get_bit $read_control 0x1]
  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (1 * 4)}] 1]
  toolkit_set_property MixerRegistersStatusText      text  $read_status
  toolkit_set_property MixerRegistersStatusStatusLed color [get_bit $read_status 0x1]
  toolkit_set_property MixerRegistersBKGWidthText    text  [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property MixerRegistersBKGHeightText   text  [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (4 * 4)}] 1]
  toolkit_set_property MixerRegistersBKGRedText      text  [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (5 * 4)}] 1]
  toolkit_set_property MixerRegistersBKGGreenText    text  [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (6 * 4)}] 1]
  toolkit_set_property MixerRegistersBKGBlueText     text  [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (7 * 4)}] 1]
  toolkit_set_property MixerRegistersBKGWidthDecText    text  [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (3 * 4)}] 1]]
  toolkit_set_property MixerRegistersBKGHeightDecText   text  [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (4 * 4)}] 1]]
  toolkit_set_property MixerRegistersBKGRedDecText      text  [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (5 * 4)}] 1]]
  toolkit_set_property MixerRegistersBKGGreenDecText    text  [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (6 * 4)}] 1]]
  toolkit_set_property MixerRegistersBKGBlueDecText     text  [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (7 * 4)}] 1]]
  
  set LayerOffset [expr {5 * 4 * [toolkit_get_property MixerLayerText text] }]
  set read_layer_control [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (10 * 4) + $LayerOffset }] 1]
  switch -exact [expr {($read_layer_control & 0xC)>>2}] {
    0  { toolkit_set_property MixerLayerControlAlphaModeText text "No blending" }
    1  { toolkit_set_property MixerLayerControlAlphaModeText text "Static alpha" }
    2  { toolkit_set_property MixerLayerControlAlphaModeText text "Input Alpha" }
    3  { toolkit_set_property MixerLayerControlAlphaModeText text "Unused" }
  }

  toolkit_set_property MixerLayerControlControlLed color [get_bit $read_layer_control 0x1]
  toolkit_set_property MixerLayerControlConsumeLed color [get_bit $read_layer_control 0x2]

  toolkit_set_property MixerLayerXOffsetText       text [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (8 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixerLayerYOffsetText       text [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (9 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixerLayerControlText       text [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (10 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixerLayerLayerPositionText text [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (11 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixerLayerLayerAlphaText    text [master_read_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (12 * 4) + $LayerOffset }] 1]
}

proc ::video_ctrl::MixerWriteButton_onClick {} {
  variable claim_path

  set LayerOffset [expr {5 * 4 * [toolkit_get_property MixerLayerText text] }]

  master_write_32 $claim_path [toolkit_get_property MixerBaseAddressText text] [toolkit_get_property MixerRegistersControlText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (3 * 4)}] [toolkit_get_property MixerRegistersBKGWidthText  text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (4 * 4)}] [toolkit_get_property MixerRegistersBKGHeightText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (5 * 4)}] [toolkit_get_property MixerRegistersBKGRedText    text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (6 * 4)}] [toolkit_get_property MixerRegistersBKGGreenText  text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (7 * 4)}] [toolkit_get_property MixerRegistersBKGBlueText   text]

  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (8 * 4) + $LayerOffset} ] [toolkit_get_property MixerLayerXOffsetText       text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (9 * 4) + $LayerOffset} ] [toolkit_get_property MixerLayerYOffsetText       text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (10 * 4) + $LayerOffset}] [toolkit_get_property MixerLayerControlText       text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (11 * 4) + $LayerOffset}] [toolkit_get_property MixerLayerLayerPositionText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixerBaseAddressText text] + (12 * 4) + $LayerOffset}] [toolkit_get_property MixerLayerLayerAlphaText    text]
  ::video_ctrl::MixerReadButton_onClick
}

proc ::video_ctrl::ScalerReadButton_onClick {} {
  variable claim_path
  set read_control [master_read_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (0 * 4)}] 1]
  toolkit_set_property ScalerRegistersControlText  text  $read_control
  toolkit_set_property ScalerRegistersControlGoLed color [get_bit $read_control 0x1]
  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (1 * 4)}] 1]
  toolkit_set_property ScalerRegistersStatusText text $read_status
  toolkit_set_property ScalerRegistersStatusStatusLed color [get_bit $read_status 0x1]
  toolkit_set_property ScalerRegistersWidthText     text [master_read_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property ScalerRegistersHeightText    text [master_read_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (4 * 4)}] 1]
  toolkit_set_property ScalerRegistersWidthDecText  text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (3 * 4)}] 1]] 
  toolkit_set_property ScalerRegistersHeightDecText text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (4 * 4)}] 1]] 
}

proc ::video_ctrl::ScalerWriteButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [       toolkit_get_property ScalerBaseAddressText text]             [toolkit_get_property ScalerRegistersControlText text]
  master_write_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (1 * 4)}] [toolkit_get_property ScalerRegistersStatusText  text]
  master_write_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (3 * 4)}] [toolkit_get_property ScalerRegistersWidthText   text]
  master_write_32 $claim_path [expr {[toolkit_get_property ScalerBaseAddressText text] + (4 * 4)}] [toolkit_get_property ScalerRegistersHeightText  text]
  ::video_ctrl::ScalerReadButton_onClick
}

proc ::video_ctrl::ClipperReadButton_onClick {} {
  variable claim_path
  set read_control [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (0 * 4)}] 1]
  toolkit_set_property ClipperRegistersControlText text $read_control
  toolkit_set_property ClipperRegistersControlGoLed color [get_bit $read_control 0x1]
  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (1 * 4)}] 1]
  toolkit_set_property ClipperRegistersStatusText text $read_status
  toolkit_set_property ClipperRegistersStatusStatusLed color [get_bit $read_status 0x1]
  toolkit_set_property ClipperRegistersLeftOffsetText   text [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property ClipperRegistersRightOffsetText  text [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (4 * 4)}] 1]  
  toolkit_set_property ClipperRegistersTopOffsetText    text [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (5 * 4)}] 1]
  toolkit_set_property ClipperRegistersBottomOffsetText text [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (6 * 4)}] 1]  
  toolkit_set_property ClipperRegistersLeftOffsetDecText   text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (3 * 4)}] 1]]
  toolkit_set_property ClipperRegistersRightOffsetDecText  text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (4 * 4)}] 1]]
  toolkit_set_property ClipperRegistersTopOffsetDecText    text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (5 * 4)}] 1]]
  toolkit_set_property ClipperRegistersBottomOffsetDecText text [hex2dec [master_read_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (6 * 4)}] 1]]
}

proc ::video_ctrl::ClipperWriteButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [       toolkit_get_property ClipperBaseAddressText text]             [toolkit_get_property ClipperRegistersControlText      text]
  master_write_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (1 * 4)}] [toolkit_get_property ClipperRegistersStatusText       text]
  master_write_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (3 * 4)}] [toolkit_get_property ClipperRegistersLeftOffsetText   text]
  master_write_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (4 * 4)}] [toolkit_get_property ClipperRegistersRightOffsetText  text]
  master_write_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (5 * 4)}] [toolkit_get_property ClipperRegistersTopOffsetText    text]
  master_write_32 $claim_path [expr {[toolkit_get_property ClipperBaseAddressText text] + (6 * 4)}] [toolkit_get_property ClipperRegistersBottomOffsetText text]
  ::video_ctrl::ClipperReadButton_onClick
}

proc ::video_ctrl::FIRReadButton_onClick {} {
  variable claim_path
  set read_control [master_read_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (0 * 4)}] 1]
  toolkit_set_property FIRRegistersControlText text $read_control
  toolkit_set_property FIRRegistersControlGoLed color [get_bit $read_control 0x1]
  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (1 * 4)}] 1]
  toolkit_set_property FIRRegistersStatusText text $read_status
  toolkit_set_property FIRRegistersStatusStatusLed color [get_bit $read_status 0x1]
  toolkit_set_property FIRRegistersSearchBlurText text [master_read_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property FIRRegistersLowerBlurText  text [master_read_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property FIRRegistersUpperBlurText  text [master_read_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (3 * 4)}] 1]
}

proc ::video_ctrl::FIRWriteButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [       toolkit_get_property FIRBaseAddressText text]             [toolkit_get_property FIRRegistersControlText    text]
  master_write_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (1 * 4)}] [toolkit_get_property FIRRegistersStatusText     text]
  master_write_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (3 * 4)}] [toolkit_get_property FIRRegistersSearchBlurText text]
  master_write_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (4 * 4)}] [toolkit_get_property FIRRegistersLowerBlurText  text]
  master_write_32 $claim_path [expr {[toolkit_get_property FIRBaseAddressText text] + (5 * 4)}] [toolkit_get_property FIRRegistersUpperBlurText  text]
}

proc ::video_ctrl::SwitchReadButton_onClick {} {
  variable claim_path
  set read_control [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (0 * 4)}] 1]
  toolkit_set_property SwitchRegistersControlText  text  $read_control
  toolkit_set_property SwitchRegistersControlGoLed color [get_bit $read_control 0x1]
  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (1 * 4)}] 1]
  toolkit_set_property SwitchRegistersStatusText text $read_status
  toolkit_set_property SwitchRegistersStatusStatusLed color [get_bit $read_status 0x1]
  toolkit_set_property SwitchRegistersInterruptText text [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (2 * 4)}] 1]
  toolkit_set_property SwitchRegistersInterruptInterruptLed color [get_bit [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (2 * 4)}] 1] 1]
  toolkit_set_property SwitchRegistersUpdateFreezzeLed color [get_bit [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (3 * 4)}] 1] 1]
  for {set i 0} {$i < 16} {incr i} {
    toolkit_set_property SwitchDoutDout${i}Text text [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (( $i + 4 )* 4)}] 1]
  }
  toolkit_set_property SwitchRegistersDinConsumeText text [master_read_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (21 * 4)}] 1]
}


proc ::video_ctrl::SwitchWriteButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [toolkit_get_property SwitchBaseAddressText text] [toolkit_get_property SwitchRegistersControlText text]
  for {set i 0} {$i < 16} {incr i} {
    master_write_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (( $i + 4 ) * 4)}] [toolkit_get_property SwitchDoutDout${i}Text  text]
  }
  master_write_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (21 * 4)}] [toolkit_get_property SwitchRegistersDinConsumeText  text]
  ::video_ctrl::SwitchReadButton_onClick
}

proc ::video_ctrl::SwitchUpdateButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [expr {[toolkit_get_property SwitchBaseAddressText text] + (3 * 4)}] 0x1
  ::video_ctrl::SwitchReadButton_onClick
}

proc hex2dec {largeHex} {
  scan $largeHex %x decimal
  return $decimal
}