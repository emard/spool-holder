spool_d=200;
spool_h=70;
spool_hole=52;
spool_above=10; // clearance from floor level

clearance=0.5;  // contact surface clearance

h_bottom=2;
d_bottom=20;

h_mid=3;

h_top=20;
d_top=10;

d_hole1=3.5; // hole diameter
h_hole1=15; // 1st hole height

d_hole2=d_hole1;
h_hole2=20; // 2nd hole height

feet_distance=100;

d2_kuglager=11;
d1_kuglager=5;
h_kuglager=4;

d_rod=3; // M3 threaded rod diameter
h_rod=[spool_h+2*d_top+10,
       feet_distance+2*d_top+10];

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

module spool()
{
  translate([0,0,spool_d/2+spool_above])
  rotate([90,0,0])
    difference()
    {
      cylinder(d=spool_d,h=spool_h,$fn=64,center=true);
      cylinder(d=spool_hole,h=spool_h+0.01,$fn=32,center=true);
    }
}

module kuglager()
{
    difference()
    {
      cylinder(d=d2_kuglager,h=h_kuglager,$fn=32,center=true);
      cylinder(d=d1_kuglager,h=h_kuglager+0.001,$fn=32,center=true);
    }
}

module four_feet()
{
  for(i=[-1:2:1])
    for(j=[-1:2:1])
    {
      // the feet
      translate([feet_distance/2*i,(spool_h/2+d_top/2+clearance)*j,0])
        foot();
      // kuglager's
      translate([feet_distance/2*i,(spool_h/2-clearance-h_kuglager/2)*j,h_hole1])
        rotate([90,0,0])
        %kuglager();
      // the rods
      // translate([20*i,10*j,0])
      rotate([0,0,45+45*j])
        translate([20*i,0,0])
          rotate([90,0,0])
          %cylinder(d=d_rod,h=h_rod[(j+1)/2],$fn=16,center=true);
      // translate([
    }
}

// foot();
% spool();
four_feet();
