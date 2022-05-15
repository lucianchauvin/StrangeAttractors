class Attractor {

    points = [];

    constructor(name, x, y, z, xoffset, yoffset, power, noise, step, scale, length, startColor, endColor, iso, dx, dy, dz) {
        this.name = name;
        this.x = x;
        this.y = y;
        this.z = z;
        this.xoffset = xoffset;
        this.yoffset = yoffset;
        this.power = power;
        this.noise = noise;
        this.step = step;
        this.scale = scale;
        this.length = length;
        this.startColor = startColor;
        this.endColor = endColor;
        this.iso = iso;
        this.dx = dx;
        this.dy = dy;
        this.dz = dz;
    }
    update() {
        var x = this.x;
        var y = this.y;
        var z = this.z;
        var dxdt = eval(this.dx) * this.step;
        var dydt = eval(this.dy) * this.step;
        var dzdt = eval(this.dz) * this.step;

        this.x += dxdt;
        this.y += dydt;
        this.z += dzdt;

        this.points.push([this.x, this.y, this.z]);
        // console.log(this.x, this.y, this.z)
        // console.log(this.points.length)
        // console.log(this.points)
    }

    drawp() {
        translate(this.xoffset, this.yoffset, 0);
        noFill();

        var l = this.length;

        var hu = this.startColor;
        var c = 1;

        for (var i = 1; i < this.points.length - 1; i++) {
            stroke(hu, 255, i);
            strokeWeight(i / l);

            line(this.points[i - 1][0] * this.scale + random(this.noise), this.points[i - 1][1] * this.scale + random(this.noise), this.points[i - 1][2] * this.scale + random(this.noise), this.points[i][0] * this.scale + random(this.noise), this.points[i][1] * this.scale + random(this.noise), this.points[i][2] * this.scale + random(this.noise));
            hu += .4 * c;
            if (hu > this.endColor) {
                c = -1;
            }
            if (hu < this.startColor) {
                c = 1;
            }
            if (this.points.length >= l) {
                this.points.shift();
            }
        }
        translate((this.xoffset) * -1, (this.yoffset) * -1, 0);
    }
}