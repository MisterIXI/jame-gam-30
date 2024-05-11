shader_type sky;
uniform sampler2D background: source_color;
void sky() {
	COLOR = EYEDIR;
	vec3 absvec = abs(EYEDIR);
	float ma = max(max(-absvec.x,absvec.y),absvec.z);
	vec3 dir = EYEDIR* ma;
	COLOR = texture(background,dir.xz * vec2(3, -3)+ 0.5).rgb;
}
