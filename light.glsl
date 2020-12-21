
// float rand(vec2 n) {
//     return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
// }

float rand(vec2 n) { 
	return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
	vec2 ip = floor(p);
	vec2 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(
		mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
		mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
	return res*res;
}

float fbm(vec2 n) {
    float total = 0.0, amplitude = 1.0;
    for(int i = 0; i < 7; i++ ) {
        total += noise(n) * amplitude;
        n += n;
        amplitude *= 0.5;
    }
    return total;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
	uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;

    vec2 t = uv - iTime * 3.0;

    float ycenter = (fbm(t) - 0.5) * 0.25;

    float diff = abs((uv.y - ycenter)*20.0);
    float h = 1.0 - smoothstep(0.0, 1.0, diff);

    fragColor = vec4(h, h, h, 1.0);
}