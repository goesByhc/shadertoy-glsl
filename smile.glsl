vec3 Circle(vec2 uv, vec2 p, float r, vec3 color, float blur) {
	float d = length(uv - p);
    float c = smoothstep(r, r-blur, d);
    return color * c;
}
    

vec3 Lerp(vec3 v3, vec3 minv3, vec3 maxv3) {
    float x = max(min(maxv3.x, v3.x), minv3.x);
    float y = max(min(maxv3.y, v3.y), minv3.y);
    float z = max(min(maxv3.z, v3.z), minv3.z);
    return vec3(x, y ,z);
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
	uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    //float c = Circle(uv, vec2(0.5, 0.5), 0.3, 0.02);

    vec2 mouthMask = vec2(0.0, 0.1 + sin(iTime) * 0.02);
    vec2 mouthMinus = vec2(mouthMask.x, mouthMask.y - 0.1);
    
    vec3 mouth = Circle(uv, mouthMinus, .3, vec3(1.0, 1.0, 0.0), .02);
    mouth -= Circle(uv, mouthMask, .3, vec3(1.0, 1.0, 0.0), .02);
    mouth = Lerp(mouth, vec3(.0, .0, .0), vec3(1.0, 1.0, 1.0));

	vec2 face = vec2(.0, .0);
    vec2 leftEye = vec2(-.15, .15);
    vec2 rightEye = vec2(.15, .15);
    
	vec3 c = Circle(uv, face, .4, vec3(1.0, 1.0, 0.0), .05);
	c -= Circle(uv, leftEye, .1, vec3(1.0, 1.0, .0), .02);
	c -= Circle(uv, rightEye, .1, vec3(1.0, 1.0, .0), .02);
    c -= mouth;
    
    fragColor = vec4(c, 1.0);

    // gl_fragColor = vec4(c, 1.0);
}
