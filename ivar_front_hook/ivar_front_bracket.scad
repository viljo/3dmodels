/*
IKEA Ivar bookshelf front hooks by Anders Viljosson 2022-04-07

I created this because I couldn't find any Ivar hooks/hangers that's
faces the front of the bookshelf. 

Released under the license "Creative Commons - Attribution - Non-Commercial" 
*/

// set default circle refinement
$fn=50;


bracket_heigth = 25;     // Heigth of bracket 
bracket_thickness = 2;   // Shell thickness

ivar_pole_width = 44.5;  // Ivar sidepiece width (observed from the front of the bookshelf)
ivar_pole_depth = 32.5;  // Ivar sidepiece depth (observed from the front of the bookshelf)
ivar_pegs_lengths = 7;   // Ivar peg lengths (22mm is maximum to fit)
ivar_pegs_diam  = 6;

grabber_width = 10;     // width of grabber ears in both parts
hook_width = 8;        // Width of hook/hanger
hook_diameter = 25;     // Diameter of hook/hanger
hook_thickness = 5;     // Hook thickness;



width_with_slots = ivar_pole_width + 2*bracket_thickness; 

module ivar_back_holder(){
    union(){
        
        // mounting pegs are 6mm diameter and 22mm long
        translate([-13,0,bracket_thickness]) cylinder(ivar_pegs_lengths,ivar_pegs_diam/2,ivar_pegs_diam/2);
        translate([13,0,bracket_thickness]) cylinder(ivar_pegs_lengths,ivar_pegs_diam/2,ivar_pegs_diam/2);
        
        // Main center base plate
        translate([-ivar_pole_width/2,-bracket_heigth/2,0]) 
        roundedcube(ivar_pole_width, bracket_heigth, bracket_thickness, 5);            
      
       //Bottom bracket that connects the base with the side hooks
       translate([-width_with_slots/2-grabber_width/2,-bracket_heigth/2,0]) 
          cube([width_with_slots+grabber_width, bracket_heigth/2, bracket_thickness]);
        
       //Side hook 1
       translate([-width_with_slots/2-grabber_width,-bracket_heigth/2,0]) 
            roundedcube(grabber_width, bracket_heigth, bracket_thickness, 5);
        
       //Side hook 2     
       translate([width_with_slots/2,-bracket_heigth/2,0]) 
            roundedcube(grabber_width, bracket_heigth, bracket_thickness, 5); 
        }
    }  


module ivar_front_hook(){
    union(){
        
        translate([ivar_pole_depth,-ivar_pole_width/2-bracket_thickness,-bracket_heigth/2]) {
            
            // Main center base plate (for hook)
            cube([bracket_thickness, ivar_pole_width+2*bracket_thickness, bracket_heigth]);
            
            translate([0,(ivar_pole_width+2*bracket_thickness)/2-hook_width/2,0]) 
             cube([hook_diameter-hook_thickness/2, hook_width, hook_thickness]);
            
            // Hook on base plate
            translate([0,(ivar_pole_width+2*bracket_thickness)/2+hook_width/2, (hook_diameter/2+hook_thickness)]) 
                rotate([0,-90,180])
                    difference(){
                        leg_v7(length=0, width=hook_width, thick=hook_thickness, gap=hook_diameter, lip=0);
                         translate([hook_thickness,0,0]) cube([hook_diameter, hook_width, hook_diameter]);
                    }
        }
        
       //side top part (rounded) 
       translate([-grabber_width,-ivar_pole_width/2,0])
            rotate([90,0,0]) roundedcube(ivar_pole_depth+grabber_width, bracket_heigth/2, bracket_thickness, 5);  
       
        //side top part (rounded)     
       translate([-grabber_width,ivar_pole_width/2+bracket_thickness,0])
            rotate([90,0,0]) roundedcube(ivar_pole_depth+grabber_width, bracket_heigth/2, bracket_thickness, 5);  
        
        // 2x sideparts ontop of existing side parts
        translate([0,ivar_pole_width/2,-bracket_heigth/2]) cube([ivar_pole_depth,bracket_thickness, bracket_heigth]);
        translate([0,-ivar_pole_width/2-bracket_thickness,-bracket_heigth/2]) cube([ivar_pole_depth,bracket_thickness, bracket_heigth]);
        
        // Grabbers gripping ivar_back_holder part
        rotate([0,-90,180])  
            translate([0,ivar_pole_width/2-3, -2*bracket_thickness])  
                 difference(){
                     cube([bracket_heigth/2, grabber_width, bracket_thickness]);
                     rotate([0,-45,0]) cube([bracket_heigth/2, grabber_width, bracket_thickness]);
                 }
            
        // Grabbers gripping ivar_back_holder part
        rotate([0,-90,180])  
            translate([0,-ivar_pole_width/2-grabber_width+3, -2*bracket_thickness])  
             difference(){
                 cube([bracket_heigth/2, grabber_width, bracket_thickness]);
                 rotate([0,-45,0]) cube([bracket_heigth/2, grabber_width, bracket_thickness]);
             }

     }        
}



module roundedcube(xdim ,ydim ,zdim,rdim){
    hull(){
        translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

        translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
    }
}


// This hook module was found on: https://sigmdel.ca/michel/3d/intro_openscad_01_en.html
module leg_v7(length, width, thick, gap, lip) {
    asser(lip >= 0, "lip cannot be a negative");
    radius = gap/2 + thick;
    difference() {
         union() {
           cube([length, width, thick]);
           translate([0, 0, radius])
             rotate([270, 0, 0])
               color("red") cylinder(h=width, r=radius);
         }
         union() {
          translate([0, 0, radius])
             rotate([270, 0, 0])
               color("blue") cylinder(h=width, r=gap/2);
           translate([0, 0, thick])
             color("pink") cube([radius, width, 2*radius]);
         }
    }
    translate([0, 0, 2*radius- thick] ) {
      color("purple") cube([lip, width, thick]);
      translate([lip, 0, thick/2])
        rotate([270, 0, 0])
          color("orange") cylinder(h=width, d=thick);
    }
 }


// Instanciate the Ivar hook part
ivar_front_hook();

// Instanciate the Ivar back holder part (aligned with the hook)
rotate([-90,180,-90]) translate([0,0,-bracket_thickness]) ivar_back_holder();


        
 
