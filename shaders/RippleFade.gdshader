shader_type canvas_item;

uniform vec2 ripple_center = vec2(0.5, 0.5); // normalized 0..1
uniform float ripple_radius = 0.0;          // expand from 0..1
uniform float ripple_feather = 0.1;         // softness of the edge

void fragment() {
    vec2 uv = FRAGCOORD.xy / vec2(textureSize(TEXTURE,0));
    float dist = distance(uv, ripple_center);

    float mask = smoothstep(ripple_radius, ripple_radius - ripple_feather, dist);

    vec4 top_color = texture(TEXTURE, UV);
    vec4 bottom_color = vec4(0.0); // will be blended in script
    COLOR = mix(bottom_color, top_color, mask);
}
