use <MCAD/involute_gears.scad>

function convert_circular_pitch (circular_pitch) = circular_pitch * 180 / PI;

module inner_gear() {
    rotate([0, 0, 22])
    gear(
        number_of_teeth = 7,
        circular_pitch = 11.5 * 180 / 6,
        gear_thickness = 10.1,
        hub_diameter = 0,
        bore_diameter = 7
    );
}

module outer_gear() {
    gear(
        number_of_teeth = 26,
        circular_pitch = 39 * 180 / 26,
        gear_thickness = 4,
        hub_diameter = 18,
        hub_thickness = 8,
        rim_thickness = 8,
        rim_width = 2,
        bore_diameter = 7,
        circles = 8
    );
}

rotate ([0, 45 + 90, 0]) {
    translate([0, 0, 7.9]) inner_gear();
    outer_gear();
}
