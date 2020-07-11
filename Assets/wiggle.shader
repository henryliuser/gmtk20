shader_type canvas_item;

uniform float time_factor = 1;
uniform vec2 amplitude = vec2(3.0, 3.0);

void vertex() {
	VERTEX.x += cos(TIME*time_factor + VERTEX.x+VERTEX.y) * amplitude.x;
	VERTEX.y += sin(TIME*time_factor + VERTEX.x+VERTEX.y) * amplitude.y;
}