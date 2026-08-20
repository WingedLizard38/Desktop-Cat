shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0.0, 20.0) = 1.0;
uniform bool add_margins = true;

void vertex() {
    if (add_margins) {
        VERTEX += (UV * 2.0 - 1.0) * line_thickness;
    }
}

void fragment() {
    vec2 uv = UV;
    
    if (add_margins) {
        vec2 tex_pixel_size = TEXTURE_PIXEL_SIZE;
        vec2 new_pixel_size = vec2(1.0) / (vec2(1.0) / tex_pixel_size + vec2(line_thickness * 2.0));
        uv = (uv - new_pixel_size * line_thickness) * tex_pixel_size / new_pixel_size;
        
        if (any(notEqual(uv, clamp(uv, vec2(0.0), vec2(1.0))))) {
            discard;
        }
    }

    vec4 base_color = texture(TEXTURE, uv);
    
    if (line_thickness < 0.1) {
        COLOR = base_color;
    } else {
        float outline = 0.0;
        
        // 16-sample radial pattern to eliminate lumpy/jagged diagonal artifacts
        for (int i = 0; i < 16; i++) {
            float angle = float(i) * 0.39269908169; // 2 * PI / 16
            vec2 offset = vec2(cos(angle), sin(angle)) * TEXTURE_PIXEL_SIZE * line_thickness;
            outline += texture(TEXTURE, uv + offset).a;
        }
        
        outline = min(outline, 1.0);
        COLOR = mix(base_color, line_color, outline - base_color.a);
    }
}