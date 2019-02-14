Root  Entry                                              
Contents                                                        
Page 
c4 Symbol  
Symbol 
Symbol 
Symbol 
Symbol 
Symbol 
Symbol 
Symbol 
Symbol 
Symbol 10 
Symbol 11 
Symbol 12 
Symbol 15 
Symbol 14 
Symbol 13 
Symbol 16 
Symbol 17 
Symbol 18 
Symbol 19 
Symbol 20 
Symbol 21 
Symbol 22 
CPicPage CPicLayer CPicFrame CPicShape
ball CPicFrame CPicPage CPicLayer CPicFrame 
ball 
CPicPage CPicLayer CPicFrame CPicShape
Layer CPicPage CPicLayer CPicFrame CPicShape
Layer CPicPage CPicLayer CPicFrame 
Layer 
CPicPage CPicLayer CPicFrame CPicShape
Layer CPicPage CPicLayer CPicFrame CPicPage CPicLayer CPicFrame CPicSprite 
Layer 
CPicPage CPicLayer CPicFrame CPicText TextField6 init 
Layer 
Layer / Math.abs( 
CPicPage CPicLayer CPicFrame CPicButton
1on (press) _parent.gotoAndPlay("newgame");
Layer 
Layer Layer 
CPicPage CPicLayer CPicFrame 
Layer CPicPage CPicLayer CPicFrame CPicButton
�on (press) if (_root.gameStatus == "ajust") {
		_root.dragging = true;
		startDrag(this);
	}
}
on (release) {
	if (_root.gameStatus == "ajust") {
		_root.dragging = false;
		stopDrag();
	}
}                                                             
���?�� Layer   
forceSta�� CPicPage CPicLayer CPicFrame    
Layer 
CPicPage CPicLayer CPicFrame 
Layer CPicPage CPicLayer CPicFrame CPicButton 
�on (press) if (_root.gameStatus == "ajust") {
		_root.forceStart -= 0.1; if (_root.forceStart < 0) _root.forceStart = 0.1; _root.moveIndicator();
	}
}                                                                        
Layer   
Layer 
CPicPage CPicLayer CPicFrame CPicButton 
�on (press) if (_root.gameStatus == "ajust") {
		_root.forceStart += 0.1; if (_root.forceStart > 8) _root.forceStart = 8; _root.moveIndicator();
	}
}                                                  
Layer 
Layer 
CPicPage CPicLayer CPicFrame CPicButton 
gon (press) if (_root.gameStatus == "ajust") {
		_root.dirStart += 0.1; _root.moveIndicator();
	}}                                                 
Layer 
Layer Start = dirGrav = (dirGrav/(2*Math.PI)) CPicPage CPicLayer CPicFrame CPicButton 
gon (press) if (_root.gameStatus == "ajust") {
		_root.dirStart -= 0.1; _root.moveIndicator();
	}}                                                 
Layer 
Layer 
CPicPage CPicLayer CPicFrame CPicText TextField4 updatelistener 
name 
�,with (_root) if (caption == "RESET")
	caption = "GO";

if ( indicator._x != oldx || indicator._y != oldy ) {
	
	rx = indicator._x;
	ry = indicator._y;

	bx = plus._x;
	by = plus._y;

	// Get distance between the bodies
	dist = Math.sqrt(Math.pow(Math.abs(bx - rx), 2) + Math.pow(Math.abs(by - ry), 2));
	
	forceStart = (dist / 10 );

	if (forceStart > 8)
		forceStart = 8;

	// Direction
	dirGrav = Math.atan( Math.abs(bx-rx) / Math.abs(by-ry) );

	if (rx >= bx && ry < by) {
		dirGrav = Math.PI - dirGrav;
	}
	if (rx < bx && ry < by) {
		dirGrav = dirGrav + Math.PI;
	}
	if (rx < bx && ry >= by) {
		dirGrav = (2 * Math.PI) - dirGrav;
	}
	if (rx >= bx && ry >= by) {
		dirGrav = dirGrav;
	}

	dirStart = dirGrav = (dirGrav/(2*Math.PI)) * 360;

	oldforcestart = forceStart;
	oldDirStart = dirStart;

	moveIndicator();
}

if (forceStart && forceStart != oldforcestart) {
	moveIndicator();
	oldforcestart = forceStart;
}

if (dirStart && dirStart != oldDirStart) {
	moveIndicator();
	oldDirStart = dirStart;
}

}                                       actions  �����OO� CPicPage  	 CPicLayer  	 CPicFrame    CPicText                         I���+ TextField5
 gamerunner 
name 
�Hwith(_root) // Get distance to hole
distToHole = Math.sqrt(Math.pow(Math.abs(plus._x - end._x), 2) + Math.pow(Math.abs(plus._y - end._y), 2)); if (caption == "GO")
	caption = "RESET";

// End if ball entered the hole
if (distToHole < end._width/2) {
	endgame = true;
	wingame = true;
	endreason = "You reached the goal!";

	plus._visible = false;
	shadow._visible = false;
	sprettball._visible = true;
	sprettball.gotoAndPlay(1);

	gotoAndStop("stop");
}

// Init variables
ftx = fty = fsx = fsy = fgx = fgy = 0;

for (var i=0; i<minusMags.length; i++) {
	// Assign ball object to local variable
	this.minus = minusMags[i];
	
	// Get distance between the bodies
	factor_x = Math.pow(Math.abs(plus._x - this.minus._x), 2);
	factor_y = Math.pow(Math.abs(plus._y - this.minus._y), 2);

	if (!factor_x) factor_x = 0;
	if (!factor_y) factor_y = 0;

	dist = Math.sqrt(factor_x + factor_y);
	
	// Stop if they crash
	if (dist < (plus._width + this.minus._width) / 2) {
		endgame = true;
		endreason = "You hit ball "+ (i+1);
	}

	// Coulomb's Law : F = (Q1 x Q2) / (4 x Pi x Eo x r2)
	// forceGrav = (q1 * q2) / (4.0 * Math.PI * E0 * Math.pow(dist, 2));

	forceGrav = 0.00005 * (magMass * ballMass) / Math.pow(dist, 1.5);

	// Get gravity direction [ D = arctan(b/a) ]
	mx = this.minus._x;
	my = this.minus._y;
	px = plus._x;
	py = plus._y;
	dirGrav = Math.atan( Math.abs(px-mx) / Math.abs(py-my) );

	if (mx >= px && my < py) {
		//trace("under til venstre");
		dirGrav = Math.PI - dirGrav; // OK
	}
	if (mx < px && my < py) {
		//trace("under til h�yre");
		dirGrav = dirGrav + Math.PI; // OK
	}
	if (mx < px && my >= py) {
		//trace("over til h�yre");
		dirGrav = (2 * Math.PI) - dirGrav;
	}
	if (mx >= px && my >= py) {
		//trace("over til venstre");
		dirGrav = dirGrav; // OK
	}
	
	// Gravity addition
	fgx = forceGrav * Math.sin(dirGrav);
	fgy = forceGrav * Math.cos(dirGrav);

	// Update total force
	ftx += fgx;
	fty += fgy;


}


// "Force" addition
fsx = forceForce * Math.sin(dirForce);
fsy = forceForce * Math.cos(dirForce);

// Gravity plus "Force" vector
ftx += fsx;
fty += fsy;

// Update ball position
if (!endgame) {
	plus._x += ftx;
	plus._y += fty;

	shadow._x = plus._x + 2;
	shadow._y = plus._y + 2;
}

// Update "Force" direction
dirForce = Math.PI + Math.atan( Math.abs(ftx) / Math.abs(fty) );
if (ftx >= 0 && fty <= 0)
	dirForce = 2.0 * Math.PI - dirForce;
else if (ftx < 0 && fty > 0)
	dirForce = 2.0 * Math.PI - dirForce+ Math.PI;
else if (ftx > 0 && fty > 0) 
	dirForce = dirForce + Math.PI;

}
                                       actions  �����OO� s._x;
		line2._y = plus._y;
		line2._height =    CPicPage  	 CPicLayer  	 CPicFrame                                      
Layer line1._x = plus._x + addx;
line1._y = plus._y CPicPage CPicLayer CPicFrame CPicShape
Layer CPicPage CPicLayer CPicFrame 
Layer 
CPicPage CPicLayer CPicFrame CPicTex�� CPicPage CPicLayer CPicFrame 
background CPicSprite 
start !% !% 
!% !% sprettball 
board 
$@ 
controlpanels 
CPicText forceStart 
dirStart 
TextField2 Force: 
Direction: 
endreason asdfsadf 
CPicButton 
uon (press) if (gameStatus == "ajust") gotoAndPlay("startgame");
	} else {
		gotoAndPlay("ajust");
	}
}                           
caption GO 
controls >. >. shadow 
shadows 
minus 
minusballs >. >. plus 
playball 
line1 
indicator 
line2 
line 
gamerunner 
wall 
controllers 
�,sprettball._visible = false;
//mass = Math.PI * Math.pow(50/2, mass = 2250;

magMass = mass;
ballMass = mass;

maxForce = 8; forceStart = 4; dirStart = 45; moveIndicator();

function moveIndicator() {
	if (!dirStart) dirStart = 0; //dirStart = Number(dirStart);
	//dirStart = Math.round(Number(dirStart));
	dirStart = (Math.round(Number(dirStart) * 10.0)) / 10; radianDirStart = (dirStart / 360) * 2 * Math.PI;

	//trace(radianDirStart);

	forceStart = (Math.round(Number(forceStart) * 10.0)) / 10; addx = 10 * forceStart * Math.sin(radianDirStart);
	addy = 10 * forceStart * Math.cos(radianDirStart);

	if (!dragging) {
		indicator._x = plus._x + addx;
		indicator._y = plus._y + addy;
	}

	if (addy > 0 && addx > 0) {
		line1._visible = true;
		line2._visible = false;

		line1._x = plus._x;
		line1._y = plus._y;
		line1._height = addy;
		line1._width = addx;
	}
	else if (addy < 0 && addx > 0) {
		line2._visible = true;
		line1._visible = false;

		line2._x = plus._x;
		line2._y = plus._y;
		line2._height = -addy;
		line2._width = addx;
	}
	else if (addy > 0 && addx < 0) {
		line2._visible = true;
		line1._visible = false;

		line2._x = plus._x + addx;
		line2._y = plus._y + addy;
		line2._height = addy;
		line2._width = -addx;
	}
	else if (addy < 0 && addx < 0) {
		line1._visible = true;
		line2._visible = false;

		line1._x = plus._x + addx;
		line1._y = plus._y + addy;
		line1._height = -addy;
		line1._width = -addx;
	}

	_root.oldx = indicator._x;
	_root.oldy = indicator._y;
}                                                                                          
���?�� �^#include "parsexml.as"

BASE_PATH = "./";

function local2global(inx, iny) {
	pnt = y: iny};
	this.localToGlobal(pnt);
	return {x: pnt.x, y: pnt.y};
}
MovieClip.prototype.localCoords = local2global;

function global2local(inx, iny) {
	pnt = y: iny};
	this.globalToLocal(pnt);
	return {x: pnt.x, y: pnt.y};
}
MovieClip.prototype.globalCoords = global2local;

var xmlobj = new LoadXML();
xmlobj.onLoad = onDataLoaded;
xmlobj.getFrom(BASE_PATH + "boards.xml");

function onDataLoaded (xmlobj) {
	if ("" == xmlobj.errorMsg) {
		boards = xmlobj.object.boards;
		initBalls(1);
		initWalls(1);
	} else {
		trace ('error loading data: '+xmlobj.errorMsg);
	}
	dataLoaded = true;
}

function initBalls(board_num) {
	gridOrigo = new Array(
		Number(boards.board[board_num].xpos),
		Number(boards.board[board_num].ypos)
	);
	
	gridSpace = Number(boards.board[board_num].spacing);
	
	minusMags = new Array();
	
	num_balls = Number(boards.board[board_num].ball.length);
	
	balls = new Array();
	
	for (i=0; i < num_balls; i++) {
		x = gridOrigo[0] + (gridSpace * boards.board[board_num].ball[i].xpos);
		y = gridOrigo[1] + (gridSpace * boards.board[board_num].ball[i].ypos);
		
		balls[i] = new Array(x, y);
	}
	
	for (var i=0; i<balls.length; i++) {
		duplicateMovieClip(minus, "minus" + i, i+10);
		with ( eval("minus" + i) ) {
			_x = balls[i][0];
			_y = balls[i][1];
		}
		duplicateMovieClip(shadow, "shadow" + i, i+1);
		with ( eval("shadow" + i) ) {
			_x = balls[i][0] + 2;
			_y = balls[i][1] + 2;
		}
		minusMags[i] = eval("minus" + i);
	}
}

function initWalls(board_num) {
	walls = new Array();
	num_walls = Number(boards.board[board_num].wall.length);
	
	trace(num_walls);

	for (i=0; i < num_walls; i++) {
		duplicateMovieClip(wall, "wall" + i, 100 + i+1);

		trace(i);

		with ( eval("wall" + i) ) {
			_x = boards.board[board_num].wall[i].xpos;
			_y = boards.board[board_num].wall[i].ypos;
			_width = boards.board[board_num].wall[i].width;
			_height = boards.board[board_num].wall[i].height;
		}
		walls[i] = eval("wall" + i);
	}
}                                                                                          
� gameStatus = "ajust";

endreason = "";
sprettball._visible = false;
plus._visible = true;
shadow._visible = true;

plus._x = start._x;
plus._y = start._y;
shadow._x = plus._x + 2; shadow._y = plus._y + 2; endgame = true;
wingame = false;

stop();
                                                                                          
���?�ForcemeStatus = "startgame";
Force
forceSpeed = forceStart;
dirSpeed = dirStart / 360 * 2 * Math.PI;
endgame = false;

stop();                                                                                          
� /*

// Get distance to hole
distToHole = Math.sqrt(Math.pow(Math.abs(plus._x - end._x), 2) + Math.pow(Math.abs(plus._y - end._y), 2)); // End if ball entered the hole
if (distToHole < end._width/2 && wingame == false) {
	endgame = true;
	wingame = true;
	endreason = "You reached the goal!";

	trace("End");

	stop();

	plus._visible = false;
	shadow._visible = false;
	//sprettball._visible = true;
	//sprettball.gotoAndPlay(1);

	//plus._x = end._x;
	//plus._y = end._y;
	//shadow._x = plus._x + 2;
	//shadow._y = plus._y + 2;
}

ftx = fty = fsx = fsy = fgx = fgy = 0;


for (var i=0; i<minusMags.length; i++) {
	// Assign ball object to local variable
	minus = minusMags[i];

	// Get distance between the bodies
	dist = Math.sqrt(Math.pow(Math.abs(plus._x - minus._x), 2) + Math.pow(Math.abs(plus._y - minus._y), 2));

	// Stop if they crash
	if (dist < (plus._width + minus._width) / 2) {
		endgame = true;
		endreason = "You hit ball "+ (i+1);
	}

	// Coulomb's Law : F = (Q1 x Q2) / (4 x Pi x Eo x r2)
	// forceGrav = (q1 * q2) / (4.0 * Math.PI * E0 * Math.pow(dist, 2));

	forceGrav = 0.00005 * (magMass * ballMass) / Math.pow(dist, 1.5);

	// Get gravity direction [ D = arctan(b/a) ]
	mx = _root.minus._x;
	my = _root.minus._y;
	px = _root.plus._x;
	py = _root.plus._y;
	dirGrav = Math.atan( Math.abs(px-mx) / Math.abs(py-my) );


	if (mx >= px && my < py) {
		//trace("under til venstre");
		dirGrav = Math.PI - dirGrav; // OK
	}
	if (mx < px && my < py) {
		//trace("under til h�yre");
		dirGrav = dirGrav + Math.PI; // OK
	}
	if (mx < px && my >= py) {
		//trace("over til h�yre");
		dirGrav = (2 * Math.PI) - dirGrav;
	}
	if (mx >= px && my >= py) {
		//trace("over til venstre");
		dirGrav = dirGrav; // OK
	}

	// Gravity addition
	fgx = forceGrav * Math.sin(dirGrav);
	fgy = forceGrav * Math.cos(dirGrav);
	
	// Update total force
	ftx += fgx;
	fty += fgy;

}
Force
ForceForce
// "Speed" ForceionForce
fsx = forceSpeed * Math.sin(dirSpeed);
fsy = forceSpeed Forceh.cos(dirSpeed);

// Gravity plus "Speed" vector
ftx += fsx;
fty += fsy;

// Update ball position
if (!endgame) {
	plus._x += ftx;
	plus._y += fty;

	shadow._x = plus._x + 2;
	shadow._y = plus._y + 2;
}Force
Force
// Update "Speed" direction
dirSForce= Math.PI + Math.atan(Force.abs(ftx) / Math.abs(fty) );
if (ftx >= 0 && fty <= 0)
	dirForce = 2.0 * Math.PI - dirForce;
else if (ftx < 0 && fty > 0)
	dirForce = 2.0Forceth.PI - dirSpeed+ Math.PI;
else if (ftx > 0 && fty > 0) 
	dirSpeed = dirSpeed + Math.PI;


*/                                                                                          
stop(); actions   
flags 
CDocumentPagePage 1Scene 
Symbol 22wall 
Symbol 21status 
Symbol 19indbut 
Symbol 18gamerunner 
Symbol 17updatelistener 
Symbol 16but_dir_cw 
Symbol 15but_dir_ccw 
Symbol 14but_force_up 
Symbol 13but_force_down
                         
Symbol 12line_ulbr 
Symbol 20line_blur 
Symbol 11indicator 
Symbol 10forcePlus1

Symbol 9flyball	
Symbol 8goClip 
Symbol 7controller 
Symbol 
Symbol 5shadow 
Symbol 3the_start 
Symbol 
Symbol 1ball_minus 
Symbol 2ball_plus 
Vector::Template"PublishFormatProperties::generator���� CColorDef 
PPH 
xPH 
x0x 