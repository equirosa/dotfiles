months=(01-enero 02-febrero 03-marzo 04-abril 05-mayo 06-junio 07-julio
	08-agosto 09-setiembre 10-octubre 11-noviembre 12-diciembre)
for month in "${months[@]}"; do
	mkdir "$month"
done
