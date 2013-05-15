turf
	var has_edges = false
	var edge_state

	var tmp/made_edges = false
	var tmp/edges[]

	proc/joins_with(turf/t)
		if(t.type == type)
			return true

	proc/make_edges()
		if(!has_edges) return
		if(made_edges) return
		edges = new
		if(edge_state == null) edge_state = edge_state()
		var global/dirs[] = list(1, 2, 4, 5, 6, 8, 9, 10)
		for(var/d in dirs)
			var turf/t = get_step(src, d)
			if(t && !joins_with(t))
				add_edge(d, t)

	proc/remake_edges()
		if(!edges) return
		for(var/obj/edge/e in edges) del e
		made_edges = false
		make_edges()

	proc/add_edge(dir, turf/loc)
		var obj/edge/e = new (loc)
		edges += e
		e.dir = dir
		e.icon = icon
		e.icon_state = edge_state
		e.layer = layer
		e.mouse_opacity = 0

	proc/edge_state()
		return "edge"

obj/edge