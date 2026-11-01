#!/bin/bash

ISSUES_MAP=( \
  [0]="Under-voltage detected" \
  [1]="Arm frequency capped" \
  [2]="Currently throttled"
  [3]="Soft temperature limit active" \
  [16]="Under-voltage has occurred" \
  [17]="Arm frequency capping has occurred" \
  [18]="Throttling has occurred" \
  [19]="Soft temperature limit has occurred")

THROTTLED_OUTPUT=$(vcgencmd get_throttled)
THROTTLED_HEX=${THROTTLED_OUTPUT#*x}
THROTTLED_HEX=${THROTTLED_HEX:-0}
THROTTLED_VAL=$((16#$THROTTLED_HEX))
CURRENT=$((THROTTLED_VAL & 0xF))
PAST=$(((THROTTLED_VAL >> 16) & 0xF))

# Display current issues
echo "Current issues:"
if [ "$CURRENT" -eq 0 ]; then
  echo "No throttling issues detected."
else
  for (( bit=0; bit<4; bit++ )); do
    if (( CURRENT & (1 << bit) )); then
      echo "~ ${ISSUES_MAP[$bit]}"
    fi
  done
fi

echo ""

# Display past issues
echo "Previously detected issues:"
if [ "$PAST" -eq 0 ]; then
  echo "No throttling issues detected."
else
  for (( bit=0; bit<4; bit++ )); do
    if (( PAST & (1 << bit) )); then
      echo "~ ${ISSUES_MAP[$((16 + bit))]}"
    fi
  done
fi
