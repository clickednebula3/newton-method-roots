draw_set_color(c_gray);
draw_line(x0-w0, y0, x0+w0, y0);
draw_line(x0, y0-h0, x0, y0+h0);


draw_set_color(c_aqua);
var _last_point = [-w0-10, h0];
var _do_der = false;
var _draw_der = [0, 0, 0, 0];
//do_next = 0;

draw_set_color(c_red);
draw_line(x0+next_i_target, y0-3, x0+next_i_target, y0+3);
next_i = lerp(next_i, next_i_target, 0.2);

draw_set_color(c_aqua);
if (do_next == 0) { next_i_target = mouse_x-x0; }
if (keyboard_check_pressed(vk_enter)) { do_next = 0; }
draw_text(8, 8+0*16, "function: "+string(func(0)[2]));
draw_set_color(c_yellow)
draw_text(8, 8+1*16, "iteration: "+string(do_next));
draw_set_color(c_lime);
draw_line(next_i+x0, y0-3, next_i+x0, y0+3);
draw_set_color(c_aqua);

if (keyboard_check_pressed(vk_backspace)) { func_id++; func = func_line[func_id%array_length(func_line)]; }
if (keyboard_check_pressed(vk_f5)) { game_restart(); }

for (var i=min(-w0-100, floor(next_i)-5); i<max(w0+100, ceil(next_i)+5); i+=1/2) {
	var _ans = h0;
	if (is_array(in) && array_length(in) > 0) { _ans = -func(i, in)[0]; } else { _ans = -func(i)[0]; }
	
	
	draw_line(x0+_last_point[0], y0+_last_point[1], x0+i, y0+_ans);
	//draw_point(x0+i, y0+_ans);
	
	
	if (abs((next_i+x0)-(x0+i)) < 1/4 /*&& _ans < h0 && _ans > -h0*/) {
		draw_set_color(c_yellow);
		var _der = 0;
		if (is_array(in) && array_length(in) > 0) { _der = -func(i, in)[1]; } else { _der = -func(i)[1]; }
		// y = m (x - x1) + y1
		// y = _der * ((x0-w0) - (x0+i)) + _ans
		var _der_ans = [
			_der*(-w0 - i) + _ans,
			_der*(+w0 - i) + _ans
		];
		
		//draw_line(x0-w0, y0+_der_ans[0], x0+w0, y0+_der_ans[1]);
		_do_der = true;
		_draw_der = [x0-w0, y0+_der_ans[0], x0+w0, y0+_der_ans[1]];
		
		if (_der != 0 && abs(_der) < 99999999) {
			draw_set_color(c_red);
			//do_next = true;
			var _next_i = i - _ans/_der
			draw_text(8, 8+3*16, "Next: ("+string(_next_i)+", 0)"); 
			if (abs(_next_i-next_i)<1/4) { draw_text(8, 8+4*16, "Same as last! Good answer!"); }
			if (keyboard_check_pressed(vk_space) && alarm[0] <= 0) { next_i_target = _next_i; do_next++; alarm[0] = 10;}
			// y - y1 = m (x - x1) at y = 0
			// i - _ans/m = x
			draw_circle(x0+_next_i, y0, 5, true);
			
		}
		
		draw_set_color(c_lime);
		draw_text(8, 8+2*16, "Chosen: ("+string(next_i)+", "+string(-_ans)+")");
		draw_circle(x0+i, y0+_ans, 5, true);
		
		draw_set_color(c_aqua);
	}
	
	_last_point = [i, _ans];
}

if (_do_der) {
	draw_set_color(c_yellow);
	draw_line(_draw_der[0], _draw_der[1], _draw_der[2], _draw_der[3]);
	draw_set_color(c_white);
}

//if (do_next) {
	
//}