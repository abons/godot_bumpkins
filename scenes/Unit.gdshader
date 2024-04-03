shader_type canvas_item;

uniform bool active = false;

void vertex() {
	
	if(active){
		// Called for every vertex the material is visible on.
		COLOR = vec4(0.4, 0.6, 0.9, 1.0);
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
	
}

	// Called for every pixel for every light affecting the CanvasItem.
//void light() {
	// Uncomment to replace the default light processing function with this one.
//}
