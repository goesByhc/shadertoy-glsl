
#define sat(x) clamp(x, 0. , 1.);
float remap01(float a, float b, float t) {
    return sat((t-a)/(b-a));
}

float remap(float a, float b, float c, float d, float t) {
    return ((t-a)/(b-a)) * (d-c) + c;
}

float heart(vec2 p) {
    float x = p.x;
    float y = p.y;
    return x*x*5.0 - 6.0*abs(x)*y + 5.0*y*y;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
	uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;

    vec2 p = vec2(uv.x, uv.y - 0.1);

    vec3 bcol = vec3(1.0, 0.8, 0.7-0.07*p.y) * (1.0 - length(p));

    // float s = sin(iTime);
    // s = s * s * 0.1;

// animate
    float tt = mod(iGlobalTime,1.5)/1.5;
    float ss = pow(tt,.2)*0.5 + 0.5;
    ss = 1.0 + ss*0.5*sin(tt*6.2831*3.0 + p.y*0.5)*exp(-tt*4.0);
    p *= vec2(0.5,1.5) + ss*vec2(0.5,-0.5);


    float r = 0.3;

    vec3 hcol = vec3(1.0, 0.0, 0.0);

    float pheart = heart(p);
    // dis = smoothstep(0.0, 1.0, dis + 0.5);

    float blur = 0.05;

    fragColor = vec4(mix(bcol, hcol, smoothstep(0.0, 1.0, -(1.0/b lur)*(pheart-r)+1.0)), 1.0);

}