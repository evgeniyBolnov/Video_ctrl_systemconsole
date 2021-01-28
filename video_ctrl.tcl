package provide video_ctrl 0.1
package require Tcl 8.5

namespace eval ::video_ctrl {

  set control_width 80

  set amm [lindex [get_service_paths master] 0]
  set claim_path [claim_service master $amm mylib]

  toolkit_set_property  self title "Video control"
  toolkit_set_property  self itemsPerRow 1
  toolkit_set_property  self visible true

  toolkit_add TABS tabbedGroup self {expandableX true expandableY true}

  toolkit_add CVITab group TABS {expandableX true expandableY true itemsPerRow 2}
    toolkit_set_property CVITab title "CVI"

      toolkit_add  CVIGroup group CVITab {itemsPerRow 1 minWidth 120}
        toolkit_set_property CVIGroup title "Parameters"

          toolkit_add  CVIBaseAddrGroup group CVIGroup {expandableX true itemsPerRow 1 minWidth 120}
            toolkit_set_property CVIBaseAddrGroup title "CVI Base Address"

          toolkit_add  CVIBaseAddressText textField CVIBaseAddrGroup
            toolkit_set_property CVIBaseAddressText minWidth $control_width
            toolkit_set_property CVIBaseAddressText text 0x0

      toolkit_add  CVIParamsGroup group CVITab {itemsPerRow 1 minWidth 120}
        toolkit_set_property CVIParamsGroup title "CVI registers"

          toolkit_add  CVIControlGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIControlGroup title "CVI Control"

              toolkit_add CVIControlText textField CVIControlGroup {minWidth 80}
                toolkit_set_property CVIControlText text "0x0"

              toolkit_add CVIControlGoLed led CVIControlGroup
                toolkit_set_property CVIControlGoLed text "Go"
                toolkit_set_property CVIControlGoLed color green_off

              toolkit_add CVIControlStatusLed led CVIControlGroup
                toolkit_set_property CVIControlStatusLed text "Status Interrupt"
                toolkit_set_property CVIControlStatusLed color green_off

              toolkit_add CVIControlFieldLed led CVIControlGroup
                toolkit_set_property CVIControlFieldLed text "Frame interrupt"
                toolkit_set_property CVIControlFieldLed color green_off

          toolkit_add  CVIStatusGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIStatusGroup title "CVI Status"

              toolkit_add CVIStatusText textField CVIStatusGroup {minWidth 80}
                toolkit_set_property CVIStatusText text "0x0"

              toolkit_add CVIStatusGoLed led CVIStatusGroup
                toolkit_set_property CVIStatusGoLed text "Status"
                toolkit_set_property CVIStatusGoLed color green_off

              toolkit_add CVIStatusInterlaceLed led CVIStatusGroup
                toolkit_set_property CVIStatusInterlaceLed text "Interlace"
                toolkit_set_property CVIStatusInterlaceLed color green_off

              toolkit_add CVIStatusStableLed led CVIStatusGroup
                toolkit_set_property CVIStatusStableLed text "Stable"
                toolkit_set_property CVIStatusStableLed color green_off

              toolkit_add CVIStatusOverflowLed led CVIStatusGroup
                toolkit_set_property CVIStatusOverflowLed text "Overflow"
                toolkit_set_property CVIStatusOverflowLed color green_off

              toolkit_add CVIStatusResolutionLed led CVIStatusGroup
                toolkit_set_property CVIStatusResolutionLed text "Resolution"
                toolkit_set_property CVIStatusResolutionLed color green_off

              toolkit_add CVIStatusLockedLed led CVIStatusGroup
                toolkit_set_property CVIStatusLockedLed text "Locked"
                toolkit_set_property CVIStatusLockedLed color green_off

              toolkit_add CVIStatusClippingLed led CVIStatusGroup
                toolkit_set_property CVIStatusClippingLed text "Clipping"
                toolkit_set_property CVIStatusClippingLed color green_off

              toolkit_add CVIStatusPaddingLed led CVIStatusGroup
                toolkit_set_property CVIStatusPaddingLed text "Padding"
                toolkit_set_property CVIStatusPaddingLed color green_off

              toolkit_add CVIStatusDropStickyLed led CVIStatusGroup
                toolkit_set_property CVIStatusDropStickyLed text "DropSticky"
                toolkit_set_property CVIStatusDropStickyLed color green_off

              toolkit_add CVIDropCountText textField CVIStatusGroup {minWidth 80}
                toolkit_set_property CVIDropCountText text "0"
                toolkit_set_property CVIDropCountText editable false

          toolkit_add  CVIInterruptGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIInterruptGroup title "CVI Interrupt"

              toolkit_add CVIInterruptText textField CVIInterruptGroup {minWidth 80}
                toolkit_set_property CVIInterruptText text "0x0"

              toolkit_add CVIInterruptStatusLed led CVIInterruptGroup
                toolkit_set_property CVIInterruptStatusLed text "Status update"
                toolkit_set_property CVIInterruptStatusLed color green_off

              toolkit_add CVIInterruptEndFrameLed led CVIInterruptGroup
                toolkit_set_property CVIInterruptEndFrameLed text "End field/frame"
                toolkit_set_property CVIInterruptEndFrameLed color green_off

          toolkit_add  CVIUsedWordsGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIUsedWordsGroup title "CVI Used Words"

              toolkit_add CVIUsedWordsText textField CVIUsedWordsGroup {minWidth 80}
                toolkit_set_property CVIUsedWordsText text "0"
                toolkit_set_property CVIUsedWordsText editable false

          toolkit_add  CVISampleCountGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVISampleCountGroup title "CVI Active Sample Count"

              toolkit_add CVISampleCountText textField CVISampleCountGroup {minWidth 80}
                toolkit_set_property CVISampleCountText text "0"
                toolkit_set_property CVISampleCountText editable false

          toolkit_add  CVIF0CountGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIF0CountGroup title "CVI F0 Active Line Count"

              toolkit_add CVIF0LineCountText textField CVIF0CountGroup {minWidth 80}
                toolkit_set_property CVIF0LineCountText text "0"
                toolkit_set_property CVIF0LineCountText editable false

          toolkit_add  CVIF1CountGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIF1CountGroup title "CVI F1 Active Line Count"

              toolkit_add CVIF1LineCountText textField CVIF1CountGroup {minWidth 80}
                toolkit_set_property CVIF1LineCountText text "0"
                toolkit_set_property CVIF1LineCountText editable false

          toolkit_add  CVITotalSampleGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVITotalSampleGroup title "CVI Total Sample Count"

              toolkit_add CVITotalSampleCountText textField CVITotalSampleGroup {minWidth 80}
                toolkit_set_property CVITotalSampleCountText text "0"
                toolkit_set_property CVITotalSampleCountText editable false

          toolkit_add  CVIF0LineCountGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIF0LineCountGroup title "CVI F0 Total Line Count"

              toolkit_add CVIF0TotalLineCountText textField CVIF0LineCountGroup {minWidth 80}
                toolkit_set_property CVIF0TotalLineCountText text "0"
                toolkit_set_property CVIF0TotalLineCountText editable false

          toolkit_add  CVIF1LineCountGroup group CVIParamsGroup {expandableX true minWidth 120}
            toolkit_set_property CVIF1LineCountGroup title "CVI F1 Total Line Count"

              toolkit_add CVIF1TotalLineCountText textField CVIF1LineCountGroup {minWidth 80}
                toolkit_set_property CVIF1TotalLineCountText text "0"
                toolkit_set_property CVIF1TotalLineCountText editable false                

          toolkit_add  CVIButtonsGroup group CVIGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property CVIButtonsGroup title "Operation"

            toolkit_add CVIReadButton button CVIButtonsGroup
              toolkit_set_property CVIReadButton text "Read"
              toolkit_set_property CVIReadButton onClick "::video_ctrl::CVIReadButton_onClick"

            toolkit_add CVIWriteButton button CVIButtonsGroup
              toolkit_set_property CVIWriteButton text "Write"
              toolkit_set_property CVIWriteButton onClick "::video_ctrl::CVIWriteButton_onClick"
#############################################################################################
  toolkit_add MixerTab group TABS {expandableX true expandableY true itemsPerRow 3}
    toolkit_set_property MixerTab title "Mixer"

      toolkit_add  MixParametersGroup group MixerTab {itemsPerRow 1 minWidth 120}
        toolkit_set_property MixParametersGroup title "Parameters"

          toolkit_add  MixBaseAddrGroup group MixParametersGroup {expandableX true itemsPerRow 1 minWidth 120}
            toolkit_set_property MixBaseAddrGroup title "Mixer Base Address"

              toolkit_add  MixBaseAddressText textField MixBaseAddrGroup
                toolkit_set_property MixBaseAddressText minWidth $control_width
                toolkit_set_property MixBaseAddressText text 0x0

          toolkit_add  MixLayerGroup group MixParametersGroup {expandableX true itemsPerRow 1 minWidth 120}
            toolkit_set_property MixLayerGroup title "Mixer Layer"

              toolkit_add  MixLayerText textField MixLayerGroup
                toolkit_set_property MixLayerText minWidth $control_width
                toolkit_set_property MixLayerText text 0

          toolkit_add  MixButtonsGroup group MixParametersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixButtonsGroup title "Operation"

              toolkit_add MixReadButton button MixButtonsGroup
                toolkit_set_property MixReadButton text "Read"
                toolkit_set_property MixReadButton onClick "::video_ctrl::MixReadButton_onClick"

              toolkit_add MixWriteButton button MixButtonsGroup
                toolkit_set_property MixWriteButton text "Write"
                toolkit_set_property MixWriteButton onClick "::video_ctrl::MixWriteButton_onClick"

      toolkit_add  MixRegistersGroup group MixerTab {itemsPerRow 1 minWidth 120}
        toolkit_set_property MixRegistersGroup title "Mixer registers"

          toolkit_add  MixControlGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixControlGroup title "Mix Control"

              toolkit_add MixControlText textField MixControlGroup {minWidth 80}
                toolkit_set_property MixControlText text "0x0"

              toolkit_add MixControlLed led MixControlGroup
                toolkit_set_property MixControlLed text "Go"
                toolkit_set_property MixControlLed color green_off

          toolkit_add  MixStatusGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixStatusGroup title "Mix Status"

              toolkit_add MixStatusText textField MixStatusGroup {minWidth 80}
                toolkit_set_property MixStatusText text "0x0"
                toolkit_set_property MixStatusText editable false

              toolkit_add MixStatusLed led MixStatusGroup
                toolkit_set_property MixStatusLed text "Status"
                toolkit_set_property MixStatusLed color green_off

          toolkit_add  MixBKGWidthGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixBKGWidthGroup title "Mix Background Width"

              toolkit_add MixBKGWidthText textField MixBKGWidthGroup {minWidth 80}
                toolkit_set_property MixBKGWidthText text "0x0"

          toolkit_add  MixBKGHeightGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixBKGHeightGroup title "Mix Background Height"

              toolkit_add MixBKGHeightText textField MixBKGHeightGroup {minWidth 80}
                toolkit_set_property MixBKGHeightText text "0x0"

          toolkit_add  MixBKGКGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixBKGКGroup title "Mix Background Red"

              toolkit_add MixBKGRedText textField MixBKGКGroup {minWidth 80}
                toolkit_set_property MixBKGRedText text "0x0"

          toolkit_add  MixBKGGGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixBKGGGroup title "Mix Background Green"

              toolkit_add MixBKGGreenText textField MixBKGGGroup {minWidth 80}
                toolkit_set_property MixBKGGreenText text "0x0"

          toolkit_add  MixBKGBGroup group MixRegistersGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixBKGBGroup title "Mix Background Blue"

              toolkit_add MixBKGBlueText textField MixBKGBGroup {minWidth 80}
                toolkit_set_property MixBKGBlueText text "0x0"

      toolkit_add  MixSelectLayerGroup group MixerTab {itemsPerRow 1 minWidth 120}
        toolkit_set_property MixSelectLayerGroup title "Mixer Layer"

          toolkit_add  MixSelectedLayerXOffsetGroup group MixSelectLayerGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixSelectedLayerXOffsetGroup title "Layer X offset"

              toolkit_add MixSelectedLayerXOffsetText textField MixSelectedLayerXOffsetGroup {minWidth 80}
                toolkit_set_property MixSelectedLayerXOffsetText text "0x0"

          toolkit_add  MixSelectedLayerYOffsetGroup group MixSelectLayerGroup {expandableX true itemsPerRow 2 minWidth 120}
            toolkit_set_property MixSelectedLayerYOffsetGroup title "Layer Y offset"

              toolkit_add MixSelectedLayerYOffsetText textField MixSelectedLayerYOffsetGroup {minWidth 80}
                toolkit_set_property MixSelectedLayerYOffsetText text "0x0"

          toolkit_add  MixSelectedLayerControlGroup group MixSelectLayerGroup {expandableX true minWidth 120}
            toolkit_set_property MixSelectedLayerControlGroup title "Layer Control"

              toolkit_add MixSelectedLayerControlText textField MixSelectedLayerControlGroup {minWidth 80}
                toolkit_set_property MixSelectedLayerControlText text "0x0"

              toolkit_add MixSelectedLayerControlEnableLed led MixSelectedLayerControlGroup
                toolkit_set_property MixSelectedLayerControlEnableLed text "Enable"
                toolkit_set_property MixSelectedLayerControlEnableLed color green_off

              toolkit_add MixSelectedLayerControlConsumeLed led MixSelectedLayerControlGroup
                toolkit_set_property MixSelectedLayerControlConsumeLed text "Consume"
                toolkit_set_property MixSelectedLayerControlConsumeLed color green_off

              toolkit_add MixSelectedLayerAlphaModeText textField MixSelectedLayerControlGroup {minWidth 80}
                toolkit_set_property MixSelectedLayerAlphaModeText text "No blending"
                toolkit_set_property MixSelectedLayerAlphaModeText editable false

          toolkit_add  MixSelectedLayerPositionGroup group MixSelectLayerGroup {expandableX true minWidth 120}
            toolkit_set_property MixSelectedLayerPositionGroup title "Layer Position"

              toolkit_add MixSelectedLayerPositionText textField MixSelectedLayerPositionGroup {minWidth 80}
                toolkit_set_property MixSelectedLayerPositionText text "0x0"

          toolkit_add  MixSelectedLayerAlphaGroup group MixSelectLayerGroup {expandableX true minWidth 120}
            toolkit_set_property MixSelectedLayerAlphaGroup title "Layer Static Alpha"

              toolkit_add MixSelectedLayerAlphaText textField MixSelectedLayerAlphaGroup {minWidth 80}
                toolkit_set_property MixSelectedLayerAlphaText text "0x0"
}

proc ::video_ctrl::CVIReadButton_onClick {} {
  variable claim_path

  set read_control [master_read_32 $claim_path [toolkit_get_property CVIBaseAddressText text] 1]
  if [expr {($read_control & 0x1) == 1}] {
    set control_go_led green
  } else {
    set control_go_led green_off
  }  
  if [expr {($read_control & 0x2) == 0x2}] {
    set control_status_interrupt_led green
  } else {
    set control_status_interrupt_led green_off
  } 
  if [expr {($read_control & 0x4) == 0x4}] {
    set control_frame_interrupt_led green
  } else {
    set control_frame_interrupt_led green_off
  } 
  toolkit_set_property CVIControlText text $read_control
  toolkit_set_property CVIControlGoLed color $control_go_led
  toolkit_set_property CVIControlStatusLed color $control_status_interrupt_led
  toolkit_set_property CVIControlFieldLed color $control_frame_interrupt_led

  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (1 * 4)}] 1]
  if [expr {($read_status & 0x1) == 1}] {
    set status_status_led green
  } else {
    set status_status_led green_off
  }  
  if [expr {($read_status & 0x80) == 0x80}] {
    set status_interlace_led green
  } else {
    set status_interlace_led green_off
  } 
  if [expr {($read_status & 0x100) == 0x100}] {
    set status_stable_led green
  } else {
    set status_stable_led green_off
  } 
  if [expr {($read_status & 0x200) == 0x200}] {
    set status_overflow_led green
  } else {
    set status_overflow_led green_off
  } 
  if [expr {($read_status & 0x400) == 0x400}] {
    set status_resolution_led green
  } else {
    set status_resolution_led green_off
  } 
  if [expr {($read_status & 0x800) == 0x800}] {
    set status_locked_led green
  } else {
    set status_locked_led green_off
  } 
  if [expr {($read_status & 0x1000) == 0x1000}] {
    set status_clipping_led green
  } else {
    set status_clipping_led green_off
  } 
  if [expr {($read_status & 0x2000) == 0x2000}] {
    set status_Padding_led green
  } else {
    set status_Padding_led green_off
  } 
  if [expr {($read_status & 0x4000) == 0x4000}] {
    set status_DropSticky_led green
  } else {
    set status_DropSticky_led green_off
  } 
  toolkit_set_property CVIStatusGoLed color $status_status_led
  toolkit_set_property CVIStatusInterlaceLed color $status_interlace_led
  toolkit_set_property CVIStatusStableLed color $status_stable_led
  toolkit_set_property CVIStatusOverflowLed color $status_overflow_led
  toolkit_set_property CVIStatusResolutionLed color $status_resolution_led
  toolkit_set_property CVIStatusLockedLed color $status_locked_led
  toolkit_set_property CVIStatusClippingLed color $status_clipping_led
  toolkit_set_property CVIStatusPaddingLed color $status_Padding_led
  toolkit_set_property CVIStatusDropStickyLed color $status_DropSticky_led
  toolkit_set_property CVIDropCountText text [expr {($read_status & 0x3f8000) >> 15}]
  toolkit_set_property CVIStatusText text $read_status

  set read_interrupt [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (2 * 4)}] 1]
  if [expr {($read_interrupt & 0x2) == 0x2}] {
    set interrupt_status_led green
  } else {
    set interrupt_status_led green_off
  }  
  if [expr {($read_interrupt & 0x4) == 0x4}] {
    set interrupt_end_frame_led green
  } else {
    set interrupt_end_frame_led green_off
  } 
  toolkit_set_property CVIInterruptStatusLed color $interrupt_status_led
  toolkit_set_property CVIInterruptEndFrameLed color $interrupt_end_frame_led
  toolkit_set_property CVIInterruptText text $read_interrupt

  toolkit_set_property CVIUsedWordsText   text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property CVISampleCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (4 * 4)}] 1]
  toolkit_set_property CVIF0LineCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (5 * 4)}] 1]
  toolkit_set_property CVIF1LineCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (6 * 4)}] 1]

  toolkit_set_property CVITotalSampleCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (7 * 4)}] 1]
  toolkit_set_property CVIF0TotalLineCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (8 * 4)}] 1]
  toolkit_set_property CVIF1TotalLineCountText text [master_read_32 $claim_path [expr {[toolkit_get_property CVIBaseAddressText text] + (9 * 4)}] 1]
}

proc ::video_ctrl::CVIWriteButton_onClick {} {
  variable claim_path
  master_write_32 $claim_path [toolkit_get_property CVIBaseAddressText text] [toolkit_get_property CVIControlText text]
  ::video_ctrl::CVIReadButton_onClick
}

proc ::video_ctrl::MixReadButton_onClick {} {
  variable claim_path
  set read_control   [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (0 * 4)}] 1]
  if [expr {($read_control & 0x1) == 0x1}] {
    set control_go_led green
  } else {
    set control_go_led green_off
  }  
  toolkit_set_property MixControlText text $read_control
  toolkit_set_property MixControlLed color $control_go_led
  set read_status [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (1 * 4)}] 1]
  if [expr {($read_status & 0x1) == 0x1}] {
    set status_go_led green
  } else {
    set status_go_led green_off
  }  
  toolkit_set_property MixStatusText text $read_status
  toolkit_set_property MixStatusLed color $status_go_led
  toolkit_set_property MixBKGWidthText  text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (3 * 4)}] 1]
  toolkit_set_property MixBKGHeightText text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (4 * 4)}] 1]
  toolkit_set_property MixBKGRedText    text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (5 * 4)}] 1]
  toolkit_set_property MixBKGGreenText  text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (6 * 4)}] 1]
  toolkit_set_property MixBKGBlueText   text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (7 * 4)}] 1]
  
  set LayerOffset [expr {5 * 4 * [toolkit_get_property MixLayerText text] }]

  set read_layer_control [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (10 * 4) + $LayerOffset }] 1]

  if [expr {($read_layer_control & 0x1) == 0x1}] {
    set layer_control_led green
  } else {
    set layer_control_led green_off
  }  
  if [expr {($read_layer_control & 0x2) == 0x2}] {
    set layer_consume_led green
  } else {
    set layer_consume_led green_off
  }  
  switch -exact [expr {($read_layer_control & 0xC)>>2}] {
    0  { toolkit_set_property MixSelectedLayerAlphaModeText text "No blending" }
    1  { toolkit_set_property MixSelectedLayerAlphaModeText text "Static alpha" }
    2  { toolkit_set_property MixSelectedLayerAlphaModeText text "Input Alpha" }
    3  { toolkit_set_property MixSelectedLayerAlphaModeText text "Unused" }
  }

  toolkit_set_property MixSelectedLayerControlEnableLed color $layer_control_led
  toolkit_set_property MixSelectedLayerControlConsumeLed color $layer_consume_led

  toolkit_set_property MixSelectedLayerXOffsetText  text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (8 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixSelectedLayerYOffsetText  text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (9 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixSelectedLayerControlText  text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (10 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixSelectedLayerPositionText text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (11 * 4) + $LayerOffset }] 1]
  toolkit_set_property MixSelectedLayerAlphaText    text [master_read_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (12 * 4) + $LayerOffset }] 1]
}

proc ::video_ctrl::MixWriteButton_onClick {} {
  variable claim_path

  set LayerOffset [expr {5 * 4 * [toolkit_get_property MixLayerText text] }]

  master_write_32 $claim_path [toolkit_get_property MixBaseAddressText text] [toolkit_get_property MixControlText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (3 * 4)}] [toolkit_get_property MixBKGWidthText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (4 * 4)}] [toolkit_get_property MixBKGHeightText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (5 * 4)}] [toolkit_get_property MixBKGRedText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (6 * 4)}] [toolkit_get_property MixBKGGreenText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (7 * 4)}] [toolkit_get_property MixBKGBlueText text]

  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (8 * 4) + $LayerOffset}]  [toolkit_get_property MixSelectedLayerXOffsetText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (9 * 4) + $LayerOffset}]  [toolkit_get_property MixSelectedLayerYOffsetText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (10 * 4) + $LayerOffset}] [toolkit_get_property MixSelectedLayerControlText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (11 * 4) + $LayerOffset}] [toolkit_get_property MixSelectedLayerPositionText text]
  master_write_32 $claim_path [expr {[toolkit_get_property MixBaseAddressText text] + (12 * 4) + $LayerOffset}] [toolkit_get_property MixSelectedLayerAlphaText text]
  ::video_ctrl::MixReadButton_onClick
}
