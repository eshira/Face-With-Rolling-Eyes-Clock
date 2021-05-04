//notes:
//sidelobe holes need to go slightly farther apart
//and ever so slightly towards the square base

//curve smoothness
$fn=100;
extra=.5;
thickness=3;
bearingheight=10;
walls=3;
    
module sidelobe(){
    translate([0,17,0]){  
        cylinder(d=8,h=thickness,center=true);      
    }
}

module sideholes(){
    translate([0,17,0]) cylinder(d=4,h=thickness+1,center=true);
}

module housing(){
    difference() {
        hull(){
            sidelobe();
            mirror([0,1,0]) sidelobe();
        }
        union(){
            sideholes();
            mirror([0,1,0]) sideholes();
        }
    }


    translate([7.5,0,-thickness/2+bearingheight/2]) cylinder(d=19+extra+walls*2,h=bearingheight,center=true);
    
    hull(){
    cylinder(d=28.1+extra,center=true,h=thickness);
    translate([7.5,0,0]) cylinder(d=19+extra+walls*2,h=thickness,center=true);
    }
}


difference(){
    housing();
    union(){
        translate([7.5,0,0]) cylinder(d=8+1.5,h=thickness+1,center=true);
        translate([7.5,0,0]) cylinder(d=12+1.5,h=bearingheight*2,center=false);
        translate([7.5,0,bearingheight-thickness/2-3.5]) cylinder(d=19+extra/2,h=bearingheight+1,center=false);
    }}

translate([-14,0,0]) cube([7,14.5,thickness],center=true);
