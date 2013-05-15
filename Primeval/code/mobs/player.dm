mob/player
	parent_type = /mob/mortal

	Login()
		world << "<i>[name] ([key]) has logged in</i>"
		..()

	Logout()
		world << "<i>[name] ([key]) has logged out</i>"
		..()

client/Del()
	if(istype(mob, /mob/player))
		save()
	..()