#!/run/current-system/sw/bin/bash

# --- Gesamt-CPU-Auslastung ---
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
prev_total=$((user + nice + system + idle + iowait + irq + softirq + steal))
prev_idle=$idle
sleep 0.5
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat
total=$((user + nice + system + idle + iowait + irq + softirq + steal))
idle_diff=$((idle - prev_idle))
total_diff=$((total - prev_total))
total_usage=$(( (100 * (total_diff - idle_diff)) / total_diff ))

# --- Temperatur aus thermal_zone1 (x86_pkg_temp) ---
TEMP_MAIN=$(awk '{printf "%.0f", $1/1000}' /sys/class/thermal/thermal_zone1/temp)

# --- Core-Auslastungen ermitteln ---
declare -A OLD_TOTAL
declare -A OLD_IDLE
while read -r line; do
  [[ "$line" =~ ^cpu([0-9]+)\ (.*) ]] || continue
  CORE=${BASH_REMATCH[1]}
  FIELDS=(${BASH_REMATCH[2]})
  total=0
  for i in {0..7}; do 
    total=$((total + FIELDS[i]))
  done
  OLD_TOTAL[$CORE]=$total
  OLD_IDLE[$CORE]=${FIELDS[3]}
done < /proc/stat

sleep 0.5

# Tooltip-Basis mit Gesamt-Auslastung
TOOLTIP="CPU-Auslastung: ${total_usage}%\n"

# Berechne nun die Core-Auslastung und erweitere den Tooltip
while read -r line; do
  [[ "$line" =~ ^cpu([0-9]+)\ (.*) ]] || continue
  CORE=${BASH_REMATCH[1]}
  FIELDS=(${BASH_REMATCH[2]})
  total=0
  for i in {0..7}; do 
    total=$((total + FIELDS[i]))
  done
  idle=${FIELDS[3]}
  diff_total=$((total - OLD_TOTAL[$CORE]))
  diff_idle=$((idle - OLD_IDLE[$CORE]))
  usage=0
  if (( diff_total > 0 )); then
    usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))
  fi
  TOOLTIP+="Core $CORE: ${usage}%\n"
done < /proc/stat

# --- Core-Temperaturen über sensors holen (zeilenweise verarbeiten) ---
while IFS= read -r line; do
    if [[ "$line" =~ Core\ ([0-9]+):\ +\+([0-9.]+)°C ]]; then
        CORE=${BASH_REMATCH[1]}
        TEMP=${BASH_REMATCH[2]}
        TOOLTIP+="Temp Core $CORE: ${TEMP}°C\n"
    fi
done <<< "$(sensors | grep -E 'Core [0-9]+:')"

# --- Ausgabe im Waybar-Format ---
echo "{\"text\": \" ${total_usage}% | 🌡️ ${TEMP_MAIN}°C\", \"tooltip\": \"${TOOLTIP}\"}"

