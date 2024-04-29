shader_type canvas_item;

uniform float multiplier = 0.2;
uniform float softness = 1;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	float value = distance(UV, vec2(0.5));
	COLOR = vec4(vec3(0), smoothstep(multiplier, softness, value));
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
