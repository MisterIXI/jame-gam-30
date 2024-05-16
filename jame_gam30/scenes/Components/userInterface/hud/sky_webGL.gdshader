shader_type sky;
render_mode use_half_res_pass;
uniform vec3 schrott_color :source_color = vec3(0.2,0.6,1.0);
void sky() {
    COLOR = schrott_color;
}