vec3 Circle(vec2 uv, vec2 p, float r, vec3 color, float blur) {
	float d = length(uv - p);
    float c = smoothstep(r, r-blur, d);
    return color * c;
}
    

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
	uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;
    
    //float c = Circle(uv, vec2(0.5, 0.5), 0.3, 0.02);

    vec2 mouthMask = vec2(0.2, 0.2);
    vec2 mouth = vec2(mouthMask.x-0.1, mouthMask.y);
    
    
	vec2 face = vec2(.0, .0);
    vec2 leftEye = vec2(-.15, .15);
    vec2 rightEye = vec2(.15, .15);
    
    
	vec3 c = Circle(uv, face, .4, vec3(1.0, 1.0, .0), .05);
	c -= Circle(uv, leftEye, .1, vec3(1.0, 1.0, .0), .02);
	c -= Circle(uv, rightEye, .1, vec3(1.0, 1.0, .0), .02);

    
    fragColor = vec4(c, 1.0);

}
