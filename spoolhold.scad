// spool holder include file

module foot()
{
  difference()
  {
  rotate([0,0,foot_rotate])
  union()
  {
    translate([0,0,h_bottom/2])
      cylinder(d=d_bottom*sqrt(2),h=h_bottom,$fn=foot_sides,center=true);
    translate([0,0,h_bottom+h_mid/2])
      cylinder(d1=d_bottom*sqrt(2),
      d2=d_top*sqrt(2),h=h_mid,$fn=foot_sides,center=true);
    translate([0,0,h_bottom+h_mid+h_top/2])
      cylinder(d=d_top*sqrt(2),h=h_top,$fn=foot_sides,center=true);
  }
    // threaded rod holes
    translate([0,0,h_hole1])
      rotate([90,0,0])
      cylinder(d=d_hole1,h=2*d_top+0.01,$fn=16,center=true);
    translate([0,0,h_hole2])
      rotate([0,90,0])
      cylinder(d=d_hole2,h=2*d_top+0.01,$fn=16,center=true);

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

module spacer()
{
  difference()
  {
    union()
    {
      // fits inside of kuglager
      cylinder(d=d1_kuglager-spacer_outer_clearance,h=h_kuglager/3+clearance,$fn=32,center=true);
      // spacer rim outside of kuglager
      translate([0,0,clearance/2-(h_kuglager/3+clearance)/2])
        cylinder(d=d1_kuglager+2*clearance,h=clearance,$fn=32,center=true);
    }
    // hole for the rod
    cylinder(d=d_rod+spacer_inner_clearance,h=h_kuglager/3+clearance+0.01,$fn=32,center=true);
  }
}

module four_feet()
{
  for(i=[-1:2:1])
    for(j=[-1:2:1])
    {
      // the feet
      translate([feet_distance/2*i,(spool_h/2+d_top/2+clearance)*j,0])
        rotate([0,0,j*90+90])
        foot();
      // kuglager's
      translate([feet_distance/2*i,(spool_h/2-h_kuglager/2)*j,h_hole1])
        rotate([90,0,0])
        kuglager_assembly();
      // the rods
      // translate([20*i,10*j,0])
      rotate([0,0,45+45*j])
        translate([distance_rod[(j+1)/2]/2*i,0,h_rod[(j+1)/2]])
          rotate([90,0,0])
          %cylinder(d=d_rod,h=l_rod[(j+1)/2],$fn=16,center=true);
      // translate([
    }
}

module kuglager_assembly()
{
  %kuglager();
  translate([0,0,-h_kuglager/2+h_kuglager/6-clearance/2])
    spacer();
  translate([0,0,h_kuglager/2-h_kuglager/6+clearance/2])
    rotate([0,180,0])
    spacer();

}

module all_feet()
{
  for(i=[0:3])
  {
  translate([(i-1.5)*d_bottom*1.5,0,0])
  foot();
  }
}

module all_spacers()
{
  for(i=[0:7])
  {
  translate([(i-3.5)*d_bottom*0.75,d_bottom,(h_kuglager/3+clearance)/2])
    spacer();
  }
}

module full_assembly()
{
  % spool();
  four_feet();
}
