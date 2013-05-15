mob/mortal
	var health
	var max_health

	var energy
	var max_energy

	proc/set_health(n)  health = min(max(n, 0), max_health)
	proc/gain_health(n) set_health(health + n)
	proc/lose_health(n) set_health(health - n)

	proc/set_energy(n)  energy = min(max(n, 0), max_energy)
	proc/gain_energy(n) set_energy(energy + n)
	proc/lose_energy(n) set_energy(energy - n)