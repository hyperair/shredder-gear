use <MCAD/involute_gears.scad>

$fs = 0.2;

pin_diameter = 1.1;
pin_distance_from_center = 5;

upper_gear_teeth = 7;
upper_gear_cp = 6;
upper_gear_thickness = 10;
upper_gear_rim_thickness = 10;
upper_gear_hub_diameter = 0;
upper_gear_circles = 0;

lower_gear_teeth = 26;
lower_gear_cp = 4.7;
lower_gear_thickness = 4;
lower_gear_hub_thickness = 8;
lower_gear_hub_diameter = 18;
lower_gear_rim_thickness = 8;
lower_gear_rim_width = 2;
lower_gear_circles = 8;

bore_diameter = 7;

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
            circles = upper_gear_circles,
            bore_diameter = bore_diameter
        );

        gear (
            number_of_teeth = lower_gear_teeth,
            circular_pitch = convert_circular_pitch (lower_gear_cp),
            gear_thickness = lower_gear_thickness + 0.1,
            hub_diameter = lower_gear_hub_diameter,
            hub_thickness = lower_gear_hub_thickness,
            rim_thickness = lower_gear_rim_thickness,
            rim_width = lower_gear_rim_width,
            bore_diameter = bore_diameter,
            circles = lower_gear_circles
        );
    }

    translate ([0, -0.1])
    for (tooth = [0:upper_gear_teeth]) {
        rotate ([0, 0, 360 / upper_gear_teeth * tooth])
        translate ([pin_distance_from_center, 0, -0.1])
        cylinder (d=pin_diameter, h=1000);
    }
}
