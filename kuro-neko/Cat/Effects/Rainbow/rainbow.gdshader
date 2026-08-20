shader_type canvas_item;

uniform float influence: hint_range(0.0, 1.0, 0.01) = 0.2;
uniform float speed: hint_range(0.0, 10.0, 0.1) = 1.5;
uniform float frequency: hint_range(0.1, 10.0, 0.1) = 2.0; // Controls rainbow band width

void fragment() {
    // Smooth diagonal wave for even color distribution
    float wave = UV.x + UV.y;

    // Smoothly animate the position over time
    float dynamic_offset = SCREEN_UV.y * 0.5;
    float time_movement = TIME * speed;

    // Calculate hue evenly across the surface
    float hue = fract((wave * frequency) + dynamic_offset - time_movement);

    // Standard inline HSV to RGB conversion
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(vec3(hue) + K.xyz) * 6.0 - K.www);

    // Pure, stable rainbow color
    vec3 rainbow = mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), 0.85); // 0.85 saturation

    COLOR.rgb = mix(COLOR.rgb, COLOR.rgb + rainbow, influence);
}