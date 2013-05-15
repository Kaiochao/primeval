world
	mob = /mob/logging_in

mob/logging_in
	var savefiles[]

	Login()
		for()
			savefiles = savefiles()
			switch(input(src, "Welcome!", "Login Options") in login_options())
				if("Load") if(load_character()) return
				if("New") if(new_character()) return
				if("Delete") delete_character()
				else
					del client
					return

	proc/login_options()
		var options[] = list("New")
		if(savefiles.len) options.Insert(1, "Load", "Delete")
		return options

	proc/load_character()
		var slot = input(src, "Which character will you load?", "Load Character") as null|anything in savefiles
		if(slot) return client.load(savefiles[slot])

	proc/new_character()
		//	open slots
		var slots[0]
		for(var/n in 1 to MAX_SLOTS)
			var slot = "Slot [n]"
			if(!savefiles[slot])
				slots[slot] = n

		if(!slots.len)
			alert(src, "You don't have any open slots!", "Slots Full")
			return

		//	slot is a number
		var slot

		if(slots.len == MAX_SLOTS)
			slot = 1
		else
			slot = slots[input(src, "Which slot will you make a character on?", "New Character") as null|anything in slots]
			if(!slot) return

			alert(src, "Creating a new character in Slot [slot]!", "New Character")

		//	name, gender, race, etc.
		var char_name = choose_name()
		var genders[] = list("Boy" = MALE, "Girl" = FEMALE)
		var char_gender = genders[input(src, "Boy or girl?", "Gender", gender) in genders]

		var client/c = client
		var player/p = new /player
		p.name = char_name
		p.gender = char_gender
		c.mob = p
		c.slot = slot
		c.save()
		return true

	proc/choose_name()
		for()
			. = input(src, "What's your name?", "Name", key) as text

			//	name must be shorter than 20 and... contain a letter
			if(ckey(.) && length(.) <= 20)
				return

	proc/delete_character()
		var slot = input(src, "Which character will you delete?", "Delete Character") as null|anything in savefiles
		if(slot)
			if("Yes" == alert(src, "Are you sure you want to delete this character?", "Delete Character", "No", "Yes"))
				return fdel(client.save_path(savefiles[slot]))

	//	returns a list of slots associated to a number
	proc/savefiles()
		. = list()
		for(var/slot in 1 to MAX_SLOTS)
			if(fexists(client.save_path(slot)))
				.["Slot [slot]"] = slot

client
	var slot	//	the currently-loaded slot (null until loaded)

	proc/save_path(slot)
		return "data/players/[ckey] (slot [slot || src.slot]).sav"

	proc/save()
		if(istype(mob, /player))
			var savefile/s = new (save_path())
			s << mob
			s["sx"] << mob.x
			s["sy"] << mob.y
			s["sz"] << mob.z
			return true

	proc/load(slot)
		src.slot = slot
		var path = save_path()
		if(fexists(path))
			var savefile/s = new (path)
			var player/p
			s >> p
			var sx, sy, sz
			s["sx"] >> sx
			s["sy"] >> sy
			s["sz"] >> sz
			p.loc = locate(sx, sy, sz)
			mob = p
			return true