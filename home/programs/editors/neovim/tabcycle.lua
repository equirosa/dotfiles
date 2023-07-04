function(fallback)
	if cmp.visible()
		then cmp.select_next_item()
	elseif luasnip.expand_or_locally_jumpable() then
		luasnip.expand_or_jump()
	else
		fallback()
	end
end
