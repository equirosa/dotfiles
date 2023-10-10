js="$(mktemp --suffix=.js)"
opt="$(mktemp --suffix=.opt.js)"
min="$(mktemp --suffix=.min.js)"

elm make --output="$js" "$@"
elm make --optimize --output="$opt" "$@"

uglifyjs "$js" --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle --output "$min"

echo "Initial size: $(wc -c "$js") bytes  ($js)"
echo "Optimized size: $(wc -c "$opt") bytes  ($opt)"
echo "Minified size:$(wc -c <"$min") bytes  ($min)"
echo "Gzipped size: $(gzip -c <"$min" | wc -c) bytes"
