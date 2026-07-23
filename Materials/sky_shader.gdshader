shader_type spatial;

uniform vec3 colour = vec3(0.0, 0.0, 1.0);
uniform float shadowiness = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALBEDO = colour;
	ALPHA = 0.5;
}

void light() {
    // Used for all other light types (directional, omni, spot).
	float dotprod = dot(NORMAL, LIGHT) + shadowiness;
    DIFFUSE_LIGHT += clamp(1.0 - dotprod, 0.0, 1.0) * ATTENUATION * LIGHT_COLOR / PI;
}
