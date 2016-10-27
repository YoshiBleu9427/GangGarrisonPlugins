object_event_add(global.yb_minimap_object, ev_draw, 0, '

	if(not global.yb_minimap_show) return 0;
	if(global.myself.object == -1) return 0;
	
	// minimap_width = background_width * xscale
	// minimap_height = background_height * yscale
	// minimap_width = background_width * scale
	var xscale, yscale, scale;
	
	// mappy ololololol. Coords of the minimap (see view_xview[0])
	var mapx, mapy;
	var mapw, maph;
	
	// zoom vars
	var zoomFactor; // The zoom makes you see zoomFactor times bigger
	var l,t; // The coords of the part of the map that is drawn within the minimap (see view_xview[0])
	var bgPartWidth, bgPartHeight;
	var zoomxscale, zoomyscale, zoomscale;
	
	xscale = (global.yb_minimap_posw / map_width()) * 6;
	yscale = (global.yb_minimap_posh / map_height()) * 6;
	scale = min(xscale, yscale);	
	if(global.yb_minimap_nearHealingHud) {
		mapx = view_xview[0] + global.yb_minimap_posx_medic;
		mapy = view_yview[0] + global.yb_minimap_posy_medic;
	} else {
		mapx = view_xview[0] + global.yb_minimap_posx;
		mapy = view_yview[0] + global.yb_minimap_posy;
	}
	
	mapw = global.yb_minimap_posw;
	maph = global.yb_minimap_posh;
	
	// zooming vars
	zoomFactor = 1;
	var map_part_width, map_part_height;
	if(global.yb_minimap_zooming) {
		zoomFactor = global.yb_minimap_zoomRange;
		bgPartWidth = map_width() / (6 * zoomFactor);
		bgPartHeight = map_height() / (6 * zoomFactor);
		l = (global.myself.object.x / 6) - bgPartWidth / 2;
		t = (global.myself.object.y / 6) - bgPartHeight / 2;
		
		zoomxscale = (global.yb_minimap_posw / bgPartWidth);
		zoomyscale = (global.yb_minimap_posh / bgPartHeight);
		zoomscale = min(zoomxscale, zoomyscale);
	
	} else {
		switch(global.yb_minimap_fit) {
			case global.yb_minimap_fit_auto:
				zoomscale = min(xscale, yscale);	
				bgPartWidth = map_width() / 6;
				bgPartHeight = map_height() / 6;
				l = 0;
				t = 0;
				break;
			case global.yb_minimap_fit_width:
				zoomscale = xscale;	
				bgPartWidth =  map_width() / 6;
				bgPartHeight = min(map_height() / 6, map_height() * (yscale / zoomscale) / 6);
				l = 0
				t = max(0, min(map_height() - bgPartHeight, (global.myself.object.y / 6) - bgPartHeight / 2));
				break;
			case global.yb_minimap_fit_height:
				zoomscale = yscale;	
				bgPartWidth = min(map_width() / 6, map_width() * (xscale / zoomscale) / 6);
				bgPartHeight = map_height() / 6;
				l = max(0, min(map_width() - bgPartWidth, (global.myself.object.x / 6) - bgPartWidth / 2));
				t = 0;
				break;
			case global.yb_minimap_fit_reverse:
				zoomscale = max(xscale, yscale);	
				bgPartWidth = min(map_width() / 6, map_width() * (xscale / zoomscale) / 6);
				bgPartHeight = min(map_height() / 6, map_height() * (yscale / zoomscale) / 6);
				l = max(0, min(map_width()/6 - bgPartWidth, (global.myself.object.x / 6) - bgPartWidth / 2));
				t = max(0, min(map_height()/6 - bgPartHeight, (global.myself.object.y / 6) - bgPartHeight / 2));
				break;
		}
	}
		
	/*if(l > (map_width() / 6) - bgPartWidth) {
		l = (map_width() / 6) - bgPartWidth;
	}
	if(t > (map_height() / 6) - bgPartHeight) {
		t = (map_height() / 6) - bgPartHeight;
	}*/
		
	// drawing map and its outline
	
	draw_set_alpha(global.yb_minimap_alpha / 200);
	draw_set_color(c_white);
	draw_rectangle(mapx, mapy, mapx + bgPartWidth * zoomscale, mapy + bgPartHeight * zoomscale, false);
	draw_set_color(c_black);
	draw_rectangle(mapx, mapy, mapx + bgPartWidth * zoomscale, mapy + bgPartHeight * zoomscale, true);
	draw_set_color(c_white);
	draw_set_alpha(global.yb_minimap_alpha / 100);
	
	// draw backgrounds
	// thanks arctic for fixing
	for (i = 0; i <= 7; i += 1)
	{
		if (background_index[i] != -1)
		{
			draw_background_part_ext(background_index[i], l, t, bgPartWidth, bgPartHeight, mapx, mapy, zoomscale, zoomscale, c_black, global.yb_minimap_alpha / 100 * 0.4);
			draw_background_part_ext(background_index[i], l, t, bgPartWidth, bgPartHeight, mapx, mapy, zoomscale, zoomscale, c_white, global.yb_minimap_alpha / 100 * 0.7);
		}
	}
	
	var i;
	for(i = 0; i < ds_list_size(global.yb_minimap_displayables); i+=1) {
		var displayable;
		displayable = ds_list_find_value(global.yb_minimap_displayables, i);
		with(displayable) {
			var ptx, pty;
			ptx = -1465; // this is definitely a value that never should be displayable
			if(x/6 < l || x/6 > l + bgPartWidth || y/6 < t || y/6 > t + bgPartHeight) {
				ptx = -1465;
			} else {
				ptx =  mapx + (zoomscale * ((x/6) - l));
				pty =  mapy + (zoomscale * ((y/6) - t));
			}
			if(ptx != -1465) {
				switch(global.yb_minimap_method) {
					case global.yb_minimap_method_dots: 
						var r, g, b, finalColor;
						r = color_get_red(colorRate) / 2;
						g = color_get_green(colorRate) / 2;
						b = color_get_blue(colorRate) / 2;
						r += color_get_red(color) / 2;
						g += color_get_green(color) / 2;
						b += color_get_blue(color) / 2;
						finalColor = make_color_rgb(r,g,b);
						draw_point_color(ptx, pty + 1, color);
						draw_point_color(ptx, pty - 1, color);
						draw_point_color(ptx, pty, finalColor);
						draw_point_color(ptx + 1, pty, color);
						draw_point_color(ptx - 1, pty, color);
						break;
					case global.yb_minimap_method_bigdots: 
						draw_circle_color(ptx,pty,3,colorRate,color,false);
						break;
					case global.yb_minimap_method_bubble: 
						draw_sprite_ext(BubblesS,bubbleIndex,ptx,pty,size,size,0,color,global.yb_minimap_alpha / 100);
						draw_sprite_ext(BubblesS,bubbleIndex,ptx,pty,size,size,0,colorRate,rate*global.yb_minimap_alpha / 100);
						break;
				}
			}
		}
	}
');