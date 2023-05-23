#!/bin/sh

for mes in enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre; do
	curl -LO "https://blankcalendarpages.com/printable_calendar/calendario1/${mes}-de-$(date -u +%Y)-calendario-es1.jpg"
done
