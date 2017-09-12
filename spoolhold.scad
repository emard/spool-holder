h_bottom=2;
d_bottom=20;

h_mid=3;

h_top=20;
d_top=10;

d_hole1=3.5; // hole diameter
h_hole1=15; // 1st hole height

d_hole2=d_hole1;
h_hole2=20; // 2nd hole height

module foot()
{
  difference()
  {
  rotate([0,0,45])
  union()
  {
    translate([0,0,h_bottom/2])
      cylinder(d=d_bottom*sqrt(2),h=h_bottom,$fn=4,center=true);
    translate([0,0,h_bottom+h_mid/2])
      cylinder(d1=d_bottom*sqrt(2),
      d2=d_top*sqrt(2),h=h_mid,$fn=4,center=true);
    translate([0,0,h_bottom+h_mid+h_top/2])
      cylinder(d=d_top*sqrt(2),h=h_top,$fn=4,center=true);
  }
    // threaded rod holes
    translate([0,0,h_hole1])
      rotate([90,0,0])
      cylinder(d=d_hole1,h=d_top+0.01,$fn=16,center=true);
    translate([0,0,h_hole2])
      rotate([0,90,0])
      cylinder(d=d_hole2,h=d_top+0.01,$fn=16,center=true);

  }
}

foot();