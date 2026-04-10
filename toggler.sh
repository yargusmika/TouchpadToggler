#!/bin/bash
# Сюда вставляй название устройства, так при преезапуске оно тоже будет работать
NAME='______NAME_______'
# Состояние подключено к системе
STATUS=$(xinput list --name-only "$NAME" | grep "$NAME")

# Состояние подключено или нет
STATE=$(xinput list-props "$NAME" | grep "Device Enabled" | awk '{print $NF}')


DEBUG=false

show_help() {
	echo "Опции: $0 [опции]"
	echo ""
	echo "Опции:"
	echo "	-h, --help    Показать все возможные функции"
	echo "	-d, --debug   Вывод информации для debug"
	echo ""
}


print_debug_info() {
	echo "--Debug--"
	echo "Name the touchpad: $NAME"
	echo "Status connecting to system: $STATUS"
	echo "State connecting enable/disable: $STATUS"
	DEBUG=true
	echo ""
	echo ""
}


debug_info() {
	if [ "$DEBUG" = true ]; then 
		echo -e "[DEBUG] $1"
	fi
}

while [[ $# -gt 0 ]]; do
	case "$1" in
		-h|--help)
			show_help
			exit 0
			;;
		-d|--debug)
			print_debug_info
			shift
			;;
		*)
			echo "Неизвестный параметр: $1"
			exit 1
			;;
	esac
done


if [[ "$STATUS" = "$NAME" ]]; then 
	debug_info "Touchpad exists into system!"
else 
	debug_info "Touchpad don't connected to system..."
	exit 0
fi

if [ "$STATE" == "1" ]; then
	debug_info "Touchpad exists and \"enable\""
	debug_info "Change the to \"disable\" the touchpad"
	xinput disable "$NAME"
else
	debug_info "Touchpad exists, but \"disable\""
	debug_info "Change the to \"enable\" the touchpad"
	xinput enable "$NAME"
fi
