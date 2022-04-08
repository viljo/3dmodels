//Copyright (c) <2022> <Anders Viljosson>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

// Description
// This is a model to generate a compatible part with
// "Novoferm 30102 - Paper roll holder for Novoferm sectional garage door from 1988"



// Total part properties
width=30;
heigth=22;
length=43;
fastener_depth=6;  // Depth removed on bolt head side

// Roller hole properties
hole_diam=11.5; 
hole_radius=hole_diam/2;

// Mounting slot properties
slot_width=15.10;
slot_depth=2.20; 
slot_distance=25;  // Distance between hole center to slot middle

// Screw slot properties
screw_slot_l = 15;
screw_slot_w= 8.5;



module round_part(){
translate([0, 0, heigth/2])
   difference(){
        cylinder(h=22, r=width/2, center=true);
        cylinder(h=22+0.01, r=hole_radius, center=true); 
    //    translate([0, hole_diam, 0]) cube([hole_radius+shell_thickness*4, shell_thickness, heigth+0.01], center=true);
    }
}

module square_part(){
    translate([0, length/2, heigth/2-fastener_depth/2]) cube([width, length, heigth-fastener_depth], center=true);
}

module part_outline(){
    union(){
    square_part();
    round_part();
}
}

module inner_hole(){
    translate([0, 0, heigth/2]){
        cylinder(h=22+0.01, r=hole_radius, center=true); 
    }
}


module slot(){
    translate([0, slot_distance, slot_depth/2-0.01]) cube([width+0.01, slot_width, slot_depth], center=true);
    translate([0, slot_distance, heigth/2]) cube([screw_slot_l, screw_slot_w, heigth+0.01], center=true);
}
  

difference(){
    part_outline();
    inner_hole();
    slot();
}

   