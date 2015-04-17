#version 300 es


in highp vec3 fN;
in highp vec3 fL;
in highp vec3 fE;

// Ouput data
out highp vec4 color;

uniform highp vec4 mat_ambient;
uniform highp vec4 mat_diffuse;
uniform highp vec4 mat_specular;
uniform highp float mat_shininess;

uniform highp vec4 light_ambient;
uniform highp vec4 light_diffuse;
uniform highp vec4 light_specular;


void main()
{

  
  highp vec4 AmbientProduct = light_ambient * mat_ambient;
  highp vec4 DiffuseProduct = light_diffuse * mat_diffuse;
  highp vec4 SpecularProduct = light_specular * mat_specular;

  //vec4 AmbientProduct = vec4(0.2, 0.2, 0.2, 1.0);
  //vec4 DiffuseProduct = vec4(0.5, 0.5, 0.5, 1.0);
  //vec4 SpecularProduct = vec4(0.5, 0.5, 0.5, 1.0);
  highp vec3 L = normalize(fL);
  highp vec3 E = normalize(fE);
  highp vec3 N = normalize(fN);
  highp vec3 H = normalize( L + E );
  highp vec4 ambient = AmbientProduct;
  color = ambient;
  highp float Kd = max(dot(L, N), 0.0);
  highp vec4 diffuse = Kd*DiffuseProduct;
  highp float Ks = pow(max(dot(N, H), 0.0), 6.0);
  highp vec4 specular = Ks*SpecularProduct;
  if( dot(L, N) < 0.0 )
    {
      specular = vec4(0.0, 0.0, 0.0, 1.0);
    }
  color +=diffuse + specular;
  
  color.a = 1.0f;


}
