player
	parent_type = /mob

	Login()
		world << "<i>[name] ([key]) has logged in</i>"
		..()

	Logout()
		world << "<i>[name] ([key]) has logged out</i>"
		..()

client/Del()
	if(istype(mob, /player))
		save()
	..()