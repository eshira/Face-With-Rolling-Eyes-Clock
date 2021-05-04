//curve smoothness
$fn=200;
shaft_diam=5.35;
shaft_height=8;

module shaft(){
    difference(){
        //this cylinder represents the motor shaft
        cylinder(d=shaft_diam,h=shaft_height);
        union() {
            //these rectangular prisms represent the cutaways on the motor shaft
            offset=1.725;
            translate([-shaft_diam,offset,-shaft_height/2]){ cube([shaft_diam*2,shaft_diam,shaft_height*2]);}
            mirror([0,1,0]){translate([-shaft_diam,offset,-shaft_height/2]){ cube([shaft_diam*2,shaft_diam,shaft_height*2]);}}
            }
    }
}

//this cylinder represents the plate supporting the eye
//cylinder(r=30,h=1);

difference() {
    translate([0,0,0.1]) cylinder(d=12.45,h=shaft_height+.5);
    union() {shaft();         cylinder(d=shaft_diam,h=2);}
}

translate([0,0,shaft_height-.5]) cylinder(d=14.5,h=2);
translate([0,0,shaft_height+.5]) cylinder(d=60,h=1.5);