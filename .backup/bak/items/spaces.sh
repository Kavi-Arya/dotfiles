#!/usr/bin/env sh

sketchybar --add   space          space_template left                \
           --set   space_template icon.color=0xffea6962     \
                                  label.drawing=off                  \
                                  drawing=off                        \
                                  updates=on                         \
                                  associated_display=1               \
                                  label.font="$FONT:Black:14.0"      \
                                  icon.font="$FONT:Bold:14.0"        \
                                  icon.padding_right=6               \
                                  icon.padding_left=6                \
                                  icon.y_offset=1                \
                                  background.padding_left=4          \
                                  background.padding_right=4        \
                                  icon.background.height=2          \
                                  icon.background.color=$ICON_COLOR  \
                                  icon.background.color=$ICON_COLOR  \
                                  icon.background.y_offset=-13      \
                                  click_script="$SPACE_CLICK_SCRIPT" \
                                  ignore_association=on              \
                                                                     \
           --clone spaces_1.label label_template                     \
                                  associated_display=1               \
                                  label.width=45                     \
                                  label.align=center                 \
                                  position=left                      \
                                  drawing=on                         \
                                                                     \
           --clone spaces_1.idle  space_template                     \
           --set   spaces_1.idle  associated_space=1                 \
                                  icon=Terminal\
                                  icon.highlight_color=0xffea6962 \
                                  icon.background.color=0xffa8998a\
                                  drawing=on                         \
                                  script="$PLUGIN_DIR/space.sh"      \
                                                                     \
           --clone spaces_1.misc  space_template                     \
           --set   spaces_1.misc  associated_space=2                 \
                                  icon=Dev\
                                  icon.highlight_color=0xffea6962 \
                                  icon.background.color=0xffa8998a\
                                  drawing=on                         \
                                  script="$PLUGIN_DIR/space.sh"      \
                                                                     \
           --clone spaces_1.doc   space_template                     \
           --set   spaces_1.doc   associated_space=3                 \
                                  icon=Files\
                                  icon.highlight_color=0xffea6962\
                                  icon.background.color=0xffa8998a\
                                  drawing=on                         \
                                  script="$PLUGIN_DIR/space.sh"      \
                                                                     \
           --clone spaces_1.help  space_template                     \
           --set   spaces_1.help  associated_space=4                 \
                                  icon=Web\
                                  icon.highlight_color=0xffea6962 \
                                  icon.background.color=0xffa8998a\
                                  drawing=on                         \
                                  script="$PLUGIN_DIR/space.sh"      \
                                                                     \
           --clone spaces_1.music space_template                     \
           --set   spaces_1.music associated_space=5                 \
                                  icon=Music\
                                  icon.highlight_color=0xffea6962 \
                                  icon.background.color=0xffa8998a\
                                  drawing=on                         \
                                  script="$PLUGIN_DIR/space.sh"      \
                                                                     \
           --clone spaces_2.nine  space_template                     \
           --set   spaces_2.nine  associated_space=6                 \
                                  icon=6\
                                  icon.highlight_color=0xffea6962\
                                  icon.background.color=0xffa8998a\
                                  drawing=on                         \
                                  script="$PLUGIN_DIR/space.sh"      \
                                                                     \
           # --clone spaces_2.code  space_template                     \
           # --set   spaces_2.code  associated_space=7                 \
           #                        icon=7                     \
           #                        icon.highlight_color=0xffa8998a\
           #                        icon.background.color=0xffea6962\
           #                        drawing=on                         \
           #                        script="$PLUGIN_DIR/space.sh"      \
           #                                                           \
           # --clone spaces_2.tex   space_template                     \
           # --set   spaces_2.tex   associated_space=8                 \
           #                        icon=8 \
           #                        icon.highlight_color=0xffa8998a\
           #                        icon.background.color=0xffea6962\
           #                        drawing=on                         \
           #                        script="$PLUGIN_DIR/space.sh"      \
           #                                                           \
           # --clone spaces_2.web   space_template                     \
           # --set   spaces_2.web   associated_space=9                 \
           #                        icon=9                         \
           #                        icon.highlight_color=0xffa8998a\
           #                        icon.background.color=0xffea6962\
           #                        drawing=on                         \
           #                        script="$PLUGIN_DIR/space.sh"      \
																																			\
           --add   bracket        spaces_1                           \
                                  spaces_1.label                     \
                                  spaces_1.idle                      \
                                  spaces_1.misc                      \
                                  spaces_1.doc                       \
                                  spaces_1.help                      \
                                  spaces_1.music                     \
                                  spaces_1.nine                      \
                                  spaces_1.label                     \
                                  spaces_1.code                      \
                                  spaces_1.web                       \
                                  spaces_1.tex                       \
                                  spaces_1.web                       \

