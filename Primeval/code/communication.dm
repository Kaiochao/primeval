client
	verb
		ooc(t as text)
			if(t && ckey(t))
				world << "<b>[src]:</b> [html_encode(t)]"