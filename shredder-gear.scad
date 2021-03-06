use <MCAD/gears/involute_gears.scad>
use <MCAD/shapes/polyhole.scad>

$fs = 0.4;
$fa = 1;

pin_diameter = 1.1;
pin_distance_from_center = 5;

upper_gear_teeth = 7;
upper_gear_cp = 6;
upper_gear_thickness = 12;
upper_gear_rim_thickness = upper_gear_thickness;
upper_gear_hub_thickness = upper_gear_thickness + 2.5;
upper_gear_hub_diameter = 18;
upper_gear_circles = 0;

lower_gear_teeth = 26;
lower_gear_cp = 4.95;
lower_gear_thickness = 4;
lower_gear_hub_thickness = lower_gear_thickness + 2;
lower_gear_hub_diameter = 18;
lower_gear_rim_thickness = 8;
lower_gear_rim_width = 2.5;
lower_gear_circles = 8;

bore_diameter = 6.3;
stepped_bore_diameter = 7.3;

function convert_circular_pitch (circular_pitch) = circular_pitch * 180 / PI;

difference () {
    union () {
        // upper gear
        translate ([0, 0, lower_gear_hub_thickness - 0.1])
        gear (
            number_of_teeth = upper_gear_teeth,
            circular_pitch = convert_circular_pitch (upper_gear_cp),
            gear_thickness = upper_gear_thickness + 0.1,
            rim_thickness = upper_gear_rim_thickness + 0.1,
            hub_diameter = upper_gear_hub_diameter,
            hub_thickness = upper_gear_hub_thickness,
            circles = upper_gear_circles,
            bore_diameter = bore_diameter
        );

        gear (
            number_of_teeth = lower_gear_teeth,
            circular_pitch = convert_circular_pitch (lower_gear_cp),
            gear_thickness = lower_gear_thickness,
            hub_diameter = lower_gear_hub_diameter,
            hub_thickness = lower_gear_hub_thickness,
            rim_thickness = lower_gear_rim_thickness,
            rim_width = lower_gear_rim_width,
            bore_diameter = bore_diameter,
            circles = lower_gear_circles
        );

        // stress relief
        translate ([0, 0, lower_gear_hub_thickness])
        cylinder (d1 = lower_gear_hub_diameter, d2 = 0,
            h = 3 + lower_gear_rim_thickness - lower_gear_hub_thickness);
    }

    *translate ([0, -0.1])
    for (tooth = [0:upper_gear_teeth]) {
        rotate ([0, 0, 360 / upper_gear_teeth * tooth])
        translate ([pin_distance_from_center, 0, -0.1])
        mcad_polyhole (d=pin_diameter, h=1000);
    }

    translate ([0, 0, -0.1])
    mcad_polyhole (d=bore_diameter,
        h=upper_gear_hub_thickness + lower_gear_hub_thickness + 0.2);

    translate ([0, 0, upper_gear_rim_thickness + lower_gear_hub_thickness])
    mcad_polyhole (d=stepped_bore_diameter,
        h=upper_gear_hub_thickness);
}
