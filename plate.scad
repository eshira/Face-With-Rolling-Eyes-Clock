$fn=100;

height=25;
walls=3;
mainbodyd=125;
plate=148;
extra=2;

translate([0,0,walls+height/2-walls-1.5]) linear_extrude (height=walls) import("eyeholes.svg");
//import(file = "file.svg", center = false, dpi = 96);

module back() {
    difference(){
        cylinder(d=mainbodyd,h=height,center=true);
        cylinder(d=mainbodyd-walls,h=height+1,center=true);
    }

    translate([0,0,-height/2]) cylinder(d=mainbodyd,h=1,center=true);
}

module front(){
    difference(){
    union() {cylinder(d=mainbodyd-extra,h=height,center=true);
        translate([0,0,height/2]) cylinder(d=plate,h=walls,center=true);
        }
    cylinder(d=mainbodyd-extra-walls,h=height*2,center=true);
    }

}


//color([1,0,1]) back();
color([0,1,0]) front();

