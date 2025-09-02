// Copyright (c) 2020 Neil D. Lawrence

// This code recreates the example that miskimit has at http://miskimit.github.io using the rewritten code base.

class Miskimit extends Game {
    constructor(objects, params, simulation, boundaries, context, colors) {
	super(objects, params, simulation, boundaries, context, colors);
    }
    birth() {
	// spawn the initial small balls.
	for (var i = 0; i<160; i++) {
	    this.objects.balls[this.objects.balls.length] = new Ball(this.context,
								     randomX(this),
								     randomY(this),
								     randomRadius(this));
	}
	
	
	this.simulation.bigBalls = true;
	
	// manually spawn the few large ones that
	// start with no velocity. because i'm lazy.
	for (var i = 0; i<7; i++) {
	    var temp = new Ball(this.context,
				randomX(this),
				randomY(this),
				randomRadius(this));
	    temp.dx = 0;
	    temp.dy = 0;
	    this.objects.balls[this.objects.balls.length] = temp;
	}
	
	// and manually spawn one large ball WITH initial velocity.
	// just to impart some more initial energy in the system.
	this.objects.balls[this.objects.balls.length] = new Ball(this.context,
								 randomX(this),
								 randomY(this), 15);
    }
    reset() {
	this.objects.balls = [];
	this.birth();
    }
}

document.addEventListener("keydown", function() {
     keyDownHandler(event, miskimit);
});
document.addEventListener("keyup", function() {
     keyUpHandler(event, miskimit);
});

var colors = {
    ground: 'rgba(56, 256, 56, 0.8)',
    pin: 'rgba(256, 56, 56, 0.8)',
    ball: 'rgba(200, 200, 200, 0.8)',
    membrane: 'rgba(56, 256, 56, 0.8)',
    hot: 'rgba(256, 56, 56, 0.8)',
    cold: 'rgba(56, 56, 256, 0.8)'
};


var simulation = {
    paused: false,
    bumped: false,
    gravity: false,
    drag: false,
    sound: true,
    bigBalls: false,
    clearCanv: true,
    dt: 1
};

var boundaries = {
    wallBounce: true,
    floorBounce: true,
    floorWrap: false,
    floorWrapCenter: true,
    floorReset: false
};

var params = {
    inelasticityFactor: 1.0,
    energy: 0.0,
    gravityAccel: 0.29,
    arrowAccel: 0.4,
    stochasticity: 0.0,
    stochasticityScale: 0.2,
    dragFactor: 0.99
};
var objects = {
    balls: [],
    boxes: [],
    pits: [],
    posts: [],
    membranes: []
};

var context = {
    canvas: document.getElementById("miskimit-canvas")
};


var beep = new Audio('beep');
beep.volume = 0.002

var miskimit = new Miskimit(objects, params, simulation, boundaries, context, colors);

miskimit.reset()	    
draw(miskimit);
