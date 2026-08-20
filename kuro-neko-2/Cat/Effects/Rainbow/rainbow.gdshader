shader_type canvas_item;

uniform float influence: hint_range(0.0, 1.0, 0.01) = 0.2;
uniform float speed: hint_range(0.0, 10.0, 0.1) = 1.5;
uniform float frequency: hint_range(0.1, 10.0, 0.1) = 2.0; // Controls rainbow band width

// Shimmer settings
uniform bool enable_shimmer = false; // Toggle shimmer on/off in the inspector
uniform float shimmer_speed: hint_range(0.0, 20.0, 0.1) = 8.0;
uniform float shimmer_strength: hint_range(0.0, 0.5, 0.01) = 0.12; // Controls shimmer visibility

// Rotation setting
uniform float rotation_degrees: hint_range(0.0, 360.0, 1.0) = 45.0; // Rotate movement direction

void fragment() {
    // Convert rotation degrees to radians
    float angle_rad = radians(rotation_degrees);
    
    // Rotate the UV coordinates to change color movement direction
    float wave = UV.x * cos(angle_rad) - UV.y * sin(angle_rad);
    
    // Smoothly animate the position over time
    float dynamic_offset = SCREEN_UV.y * 0.5;
    float time_movement = TIME * speed;
    
    // Calculate hue evenly across the surface
    float hue = fract((wave * frequency) + dynamic_offset - time_movement);
    
    // Standard inline HSV to RGB conversion
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(vec3(hue) + K.xyz) * 6.0 - K.www);
    vec3 rainbow = mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), 0.85); // 0.85 saturation
    
    // Optional Shimmer Logic
    if (enable_shimmer) {
        // High-frequency sine wave overlay for a sparkling effect
        float shimmer = sin((UV.x - UV.y) * 20.0 + (TIME * shimmer_speed)) * shimmer_strength;
        rainbow *= clamp(1.0 + shimmer, 0.5, 1.5); // Modulate brightness
    }
    
    COLOR.rgb = mix(COLOR.rgb, COLOR.rgb + rainbow, influence);
}