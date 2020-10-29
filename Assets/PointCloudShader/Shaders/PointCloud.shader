Shader "Unlit/PointCloud"
{
    Properties
    {
        _Pos ("Pos", 2D) = "white" {}
        _Col ("Col", 2D) = "white" {}
        _Size ("Particle size", Range(0, 1)) = 0.05
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma exclude_renderers gles
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 color : TEXCOORD1;
            };
            
            sampler2D _Pos;
            sampler2D _Col;
            float _Size;

            float3 unpack(float2 uv) {
                float texWidth = 2048.0;
                float2 e = float2(-1.0/texWidth/2, 1.0/texWidth/2);
                uint3 v0 = uint3(tex2Dlod(_Pos, float4(uv + e.xy,0,0)).xyz * 255.) << 0;
                uint3 v1 = uint3(tex2Dlod(_Pos, float4(uv + e.yy,0,0)).xyz * 255.) << 8;
                uint3 v2 = uint3(tex2Dlod(_Pos, float4(uv + e.xx,0,0)).xyz * 255.) << 16;
                uint3 v3 = uint3(tex2Dlod(_Pos, float4(uv + e.yx,0,0)).xyz * 255.) << 24;
                uint3 v = v0 + v1 + v2 + v3;
                return asfloat(v);
            }
            
            v2f vert (appdata v)
            {
                v2f o;
                float texWidth = 1024.0;
                float aspectRatio = - UNITY_MATRIX_P[0][0] / UNITY_MATRIX_P[1][1];

                float2 uv = float2((floor(v.vertex.z / texWidth) + 0.5) / texWidth, (fmod(v.vertex.z, texWidth) + 0.5) / texWidth);
                float3 p = unpack(uv).xzy;
                float4 vp1 = UnityObjectToClipPos(float4(p, 1));

                float sz = _Size;
                float3x2 triVert = float3x2(
                    float2(0, 1),
                    float2(0.9, -0.5),
                    float2(-0.9, -0.5));
                o.uv = triVert[round(v.vertex.y)];
                if (abs(UNITY_MATRIX_P[0][2]) < 0.0001) sz *= 2;
                sz *= pow(determinant((float3x3)UNITY_MATRIX_M),1/3.0);
                o.vertex = vp1+float4(o.uv*sz*float2(aspectRatio,1),0,0);
                
                float3 c = tex2Dlod(_Col, float4(uv,0,0)).xyz;
                o.color = c;

                return o;
            }
            
            
            fixed4 frag (v2f i) : SV_Target
            {
                float l = length(i.uv);
                clip(0.5-l);
                return float4(i.color,1);
            }
            ENDCG
        }
    }
}