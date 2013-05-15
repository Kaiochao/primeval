client
	verb/ooc(t as text)
		if(t)
			world << "(<b>[key]</b>): [html_encode(t)]"

mob/mortal
	proc/say(t)

	//	send a message 't' to all mobs in range
	proc/speak(t, range)
		var message = "<b>[name]</b>: [t]"
		hearers(range) << message