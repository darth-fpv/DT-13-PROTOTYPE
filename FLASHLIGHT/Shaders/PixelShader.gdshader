shader_type spatial;
render_mode unshaded;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
/*uniform sampler2D SCREEN_TEXTURE : source_color, hint_normal_roughness_texture, filter_nearest;*/

const int pixel_size = 8;


void vertex() {
	POSITION  = vec4(VERTEX, 1.0);
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);
	
	x = FRAGCOORD.x + floor(float(pixel_size) / 2.0) - x;
	y = FRAGCOORD.y + floor(float(pixel_size) / 2.0) - y;
	
	ALBEDO = texture(SCREEN_TEXTURE, vec2(x,y) / VIEWPORT_SIZE).xyz;
	
	
	
	
	// Called for every pixel the material is visible on.
}