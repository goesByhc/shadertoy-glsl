#define S(a, b, t) smoothstep(a, b, t)
#define sat(x) clamp(x, 0. , 1.);
float remap01(float a, float b, float t) {
    return sat((t-a)/(b-a));
}
float remap(float a, float b, float c, float d, float t) {
    return sat(((t-a)/(b-a)) * (d-c) + c);
}

vec4 Head(vec2 uv)
{
    vec4 col = vec4(.9, .65, 0.1, 1.);

    float d = length(uv);

    col.a = S(0.5, 0.49, d);


    float edgeShade = remap01(.35, .5, d);
    edgeShade *= edgeShade;
    col.rgb *= 1. - edgeShade * 0.5;

    col.rgb = mix(col.rgb, vec3(0.6, 0.3, 0.1), S(.47, .48, d));

    float highlight = S(.41, .405, d);
    highlight *= 0.5;
    highlight *= remap(.41, -.1, .75, 0., uv.y);
    col.rgb = mix(col.rgb, vec3(1.), highlight);

    d = length(uv - vec2(0.2, -0.2));
    float cheek = S(0.15, 0.10, d);
    cheek *= 0.25;
    col.rgb = mix(col.rgb, vec3(1., 0., 0.), cheek);

    d = length(uv - vec2(-0.2, -0.2));
    cheek = S(0.15, 0.10, d);
    cheek *= 0.25;
    col.rgb = mix(col.rgb, vec3(1., 0., 0.), cheek);

    return col;
}

vec4 Smiley(vec2 uv) 
{
    vec4 col = vec4(0.);
    
    vec4 head = Head(uv);

    col = mix(col, head, head.a);

    return col;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
	uv -= 0.5;
    uv.x *= iResolution.x/iResolution.y;

    fragColor = Smiley(uv);
}