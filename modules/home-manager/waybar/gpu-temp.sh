#!/usr/bin/env sh
# GPU temperature widget for waybar (AMD GPU edge)
set +e

# Resolve the GPU hwmon device by name (amdgpu / radeon)
HWMON_DIR=$(for d in /sys/class/hwmon/hwmon*/; do
    name=$(cat "${d}name" 2>/dev/null)
    if [[ "$name" == "amdgpu" || "$name" == "radeon" ]]; then
        echo "${d}"
        break
    fi
done)

TEMP_FILE="${HWMON_DIR}temp1_input"

if [ ! -f "$TEMP_FILE" ]; then
  echo ""
  exit 0
fi

# Read temperature in millidegrees and convert to Celsius
temp_millidegrees=$(cat "$TEMP_FILE" 2>/dev/null)

if [ -z "$temp_millidegrees" ]; then
  echo ""
  exit 0
fi

# Convert to degrees Celsius
temp_c=$(echo "$temp_millidegrees" | awk '{printf "%.0f", $1/1000}')

# Format output
echo "🎮 ${temp_c}°C"
exit 0

