/// 二生一的随机函数
float hash(vec2 uv)
{
    return fract(sin(dot(uv, vec2(154.45, 64.548))) * 124.54)  ;
}
 
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // 归一化纹理坐标 [-1, 1]
    vec2 uv = (2.*fragCoord - iResolution.xy) / iResolution.y;
    vec2 uvPos = vec2(uv.x, uv.y);
    // 通过随机函数生成星空，通过幂函数放大对比度
    float stars = pow(hash(uvPos), 200.0);
    // 从上到下的渐变，并着色
    vec3 night = vec3(uv.y * 0.5 + 0.5) * vec3(stars) + vec3(0.06, 0.02, 0.18);
    fragColor = vec4(night, 1.0);
}