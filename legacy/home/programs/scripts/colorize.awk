#!/usr/bin/env awk
# Copyright (c) 2022 Robin Jarry

BEGIN {
	# R;G;B colors
	url = "\033[38;2;255;255;175m" # yellow
	header = "\033[38;2;175;135;255m" # purple
	signature = "\033[38;2;175;135;255m" # purple
	diff_meta = "\033[1;38;2;255;255;255m" # bold white
	diff_chunk = "\033[38;205;0;205m" # cyan
	diff_add = "\033[38;2;0;205;0m" # green
	diff_del = "\033[38;2;205;0;0m" # red
	quote_1 = "\033[38;2;95;175;255m"  # blue
	quote_2 = "\033[38;2;255;135;0m" # orange
	quote_3 = "\033[38;2;175;135;255m" # purple
	quote_4 = "\033[38;2;255;95;215m" # pink
	quote_x = "\033[38;2;128;128;128m" # gray
	reset = "\033[0m"
	# state
	in_diff = 0
	in_signature = 0
	in_headers = 0
	in_body = 0
	# patterns
	header_pattern = @/^[A-Z][[:alnum:]-]+:/
	url_pattern = @/[a-z]{2,6}:\/\/[[:graph:]]+|(mailto:)?[[:alnum:]_\+\.~\/-]*[[:alnum:]_]@[[:lower:]][[:alnum:]\.-]*[[:lower:]]/
}
function color_quote(line) {
	level = 0
	quotes = ""
	while (line ~ /^>/) {
		level += 1
		quotes = quotes ">"
		line = substr(line, 2)
		while (line ~ /^ /) {
			quotes = quotes " "
			line = substr(line, 2)
		}
	}
	if (level == 1) {
		color = quote_1
	} else if (level == 2) {
		color = quote_2
	} else if (level == 3) {
		color = quote_3
	} else if (level == 4) {
		color = quote_4
	} else {
		color = quote_x
	}
	if (line ~ /^\+/) {
		return color quotes diff_add line reset
	} else if (line ~ /^-/) {
		return color quotes diff_del line reset
	}
	gsub(url_pattern, url "&" color, line)
	return color quotes line reset
}
{
	# Strip carriage returns from line
	sub(/\r$/, "")

	if (in_diff) {
		if ($0 ~ /^-- ?$/) {
			in_signature = 1
			in_diff = 0
			in_headers = 0
			in_body = 0
			$0 = signature $0 reset
		} else if ($0 ~ /^@@ /) {
			$0 = diff_chunk $0 reset
		} else if ($0 ~ /^(diff --git|index|---|\+\+\+) /) {
			$0 = diff_meta $0 reset
		} else if ($0 ~ /^\+/) {
			$0 = diff_add $0 reset
		} else if ($0 ~ /^-/) {
			$0 = diff_del $0 reset
		}
	} else if (in_signature) {
		gsub(url_pattern, url "&" signature)
		$0 = signature $0 reset
	} else if (in_headers) {
		if ($0 ~ /^$/) {
			in_signature = 0
			in_diff = 0
			in_headers = 0
			in_body = 1
		} else {
			sub(header_pattern, header "&" reset)
			gsub(url_pattern, url "&" reset)
		}
	} else if (in_body) {
		if ($0 ~ /^>/) {
			$0 = color_quote($0)
		} else if ($0 ~ /^diff --git /) {
			in_signature = 0
			in_diff = 1
			in_headers = 0
			in_body = 0
			$0 = diff_meta $0 reset
		} else if ($0 ~ /^-- ?$/) {
			in_signature = 1
			in_diff = 0
			in_headers = 0
			in_body = 0
			$0 = signature $0 reset
		} else {
			gsub(url_pattern, url "&" reset)
		}
	} else if ($0 ~ /^diff --git /) {
		in_signature = 0
		in_diff = 1
		in_headers = 0
		in_body = 0
		$0 = diff_meta $0 reset
	} else if ($0 ~ /^-- ?$/) {
		in_signature = 1
		in_diff = 0
		in_headers = 0
		in_body = 0
		$0 = signature $0 reset
	} else if ($0 ~ header_pattern) {
		in_signature = 0
		in_diff = 0
		in_headers = 1
		in_body = 0
		sub(header_pattern, header "&" reset)
		gsub(url_pattern, url "&" reset)
	} else {
		in_signature = 0
		in_diff = 0
		in_headers = 0
		in_body = 1
		if ($0 ~ /^>/) {
			$0 = color_quote($0)
		} else {
			gsub(url_pattern, url "&" reset)
		}
	}

	print
}
