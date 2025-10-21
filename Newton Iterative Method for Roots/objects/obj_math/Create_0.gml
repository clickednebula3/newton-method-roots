x0 = room_width/2;
y0 = room_height/2;
w0 = x0;
h0 = y0;
x = x0;
y = y0;

do_next = 0;
next_i = mouse_x;
next_i_target = mouse_x;

func_line = [func_mx_b, func_axx_bx_c, func_axxx_bxx_cx_d, func_stretch];
func_id = 1;
func = func_axx_bx_c;
in = -1;

function func_mx_b(_x, _in = [2, 30]) { return [
	(_in[0]*_x) + _in[1],
	_in[0],
	"mx+b  as  " + string(_in[0])+"x + "+string(_in[1])
]; }

function func_axx_bx_c(_x, _in = [1/300, 0, -40]) { return [
	_in[0]*power(_x, 2) + _in[1]*_x + _in[2],
	2*_in[0]*_x + _in[1],
	"ax2+bx+c  as  "+string(_in[0])+"x2 + "+string(_in[1])+"x + "+string(_in[2])
]; }

function func_axxx_bxx_cx_d(_x, _in = [1/501, -1/10, -29/5, 210]) { return [
	_in[0]*power(_x, 3) + _in[1]*power(_x, 2) + _in[2]*_x+ _in[3],
	3*_in[0]*power(_x, 2) + 2*_in[1]*_x + _in[2],
	"ax3+bx2+cx+d  as  "+string(_in[0])+"x3 + "+string(_in[1])+"x2 + "+string(_in[2])+"x + "+string(_in[3])
]; }

function func_stretch(_x, _func=[sin, cos], _a=40, _t=1/50) { return [
	_a*_func[0](_x*_t),
	_a*_func[1](_x*_t)*_t,
	"asin(tx)  as  "+string(_a)+"sin("+string(_t)+"x)"
];}