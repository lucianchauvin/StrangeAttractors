

var attractors = [];

function setup() {
    createCanvas(screen.width, screen.height, WEBGL);

    background(0);
    orbitControl();
    normalMaterial();
    frameRate(1000);
    colorMode(HSB);
    smooth();
    createEasyCam({ distance: 500 });
    setl();

    // attractors.push(new Attractor("Lorenze", 1, 0, 0, 0, 0, 1, 0, .005, 20 * c, 255, 170, 280, false, "10*(-x+y)", "28*x-y-x*z", "x*y-(8/3)*z"));
    // attractors.push(new Attractor("BurkeShaw", 1, 0, 0, 0, 0, 1, 0, .005, 100 * c, 255, 180, 255, false, "-1*10*(x+y)", "((-1*x*y)/x)-10*x*z", "10*x*y+4.272"));
    // attractors.push(new Attractor("Spott-Linz", .1, .1, .1, 0, 0, 1, 0, .01, 150 * c, 255, 160, 230, false, "(x/x)*y", "(-1*x)+y*z", "1-((x/x)*y*y)"));
    // attractors.push(new Attractor("Nose-Hoover", 1, 0, 0, 0, 0, 1, 0, .009, 100 * c, 255, 55, 134, false, "(x/x)*y", "(-1*x)+y*z", "1.5-(x/x)*y*y"));
}

function setl() {
    attractors.shift();
    var nname = document.getElementById("name").value;
    var x = parseFloat(document.getElementById("x").value);
    var y = parseFloat(document.getElementById("y").value);
    var z = parseFloat(document.getElementById("z").value);
    var scale = parseFloat(document.getElementById("scale").value);
    var step = parseFloat(document.getElementById("step").value);
    var length = parseFloat(document.getElementById("length").value);
    var startColor = parseFloat(document.getElementById("sc").value);
    var endColor = parseFloat(document.getElementById("ec").value);
    var dx = document.getElementById("dx").value;
    var dy = document.getElementById("dy").value;
    var dz = document.getElementById("dz").value;
    console.log(nname, x, y, z, scale, step, length, startColor, endColor, dx, dy, dz);
    attractors.push(new Attractor(nname, x, y, z, 0, 0, 1, 0, step, scale, length, startColor, endColor, false, dx, dy, dz));

}

function preset(which) {
    if (which == "hal") {
        document.getElementById("name").value = "Halvorsen";
        document.getElementById("x").value = "1";
        document.getElementById("y").value = "0";
        document.getElementById("z").value = "0";
        document.getElementById("scale").value = "20";
        document.getElementById("step").value = ".005";
        document.getElementById("dx").value = "-1.4*x+-4*y+-4*z-y*y";
        document.getElementById("dy").value = "-4*x+-1.4*y+-4*z+-z*z";
        document.getElementById("dz").value = "-4*x+-4*y+-1.4*z+-x*x";
        setl();
    }
    if (which == "lor") {
        document.getElementById("name").value = "Lorenze";
        document.getElementById("x").value = "1";
        document.getElementById("y").value = "0";
        document.getElementById("z").value = "0";
        document.getElementById("scale").value = "5";
        document.getElementById("step").value = ".005";
        document.getElementById("dx").value = "10*(-x+y)";
        document.getElementById("dy").value = "28*x-y-x*z";
        document.getElementById("dz").value = "x*y-(8/3)*z";
        setl();
    }
    if (which == "bur") {
        document.getElementById("name").value = "BurkeShaw";
        document.getElementById("x").value = "1";
        document.getElementById("y").value = "0";
        document.getElementById("z").value = "0";
        document.getElementById("scale").value = "100";
        document.getElementById("step").value = ".005";
        document.getElementById("dx").value = "-1*10*(x+y)";
        document.getElementById("dy").value = "(-1*y)-10*x*z";
        document.getElementById("dz").value = "10*x*y+4.272";
        setl();
    }
    if (which == "spo") {
        document.getElementById("name").value = "Spott-Linz";
        document.getElementById("x").value = ".1";
        document.getElementById("y").value = ".1";
        document.getElementById("z").value = ".1";
        document.getElementById("scale").value = "50";
        document.getElementById("step").value = ".01";
        document.getElementById("dx").value = "(x/x)*y";
        document.getElementById("dy").value = "(-1*x)+y*z";
        document.getElementById("dz").value = "1-(y*y)";
        setl();
    }
    if (which == "nos") {
        document.getElementById("name").value = "Nose-Hoover";
        document.getElementById("x").value = "1";
        document.getElementById("y").value = "0";
        document.getElementById("z").value = "0";
        document.getElementById("scale").value = "100";
        document.getElementById("step").value = ".009";
        document.getElementById("dx").value = "y";
        document.getElementById("dy").value = "(-1*x)+y*z";
        document.getElementById("dz").value = "1.5-y*y";
        setl();
    }

}

function draw() {
    background(0);
    for (var i = 0; i < attractors.length; i++) {
        attractors[i].update();
        attractors[i].drawp();
    }
}