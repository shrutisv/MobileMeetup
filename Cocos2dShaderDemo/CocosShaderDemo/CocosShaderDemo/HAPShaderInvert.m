//
//  HAPShaderInvert.m
//  CocosShaderDemo
//
//  Created by Joseph Kim on 10/12/12.
//  Copyright (c) 2012 Happy Dojo. All rights reserved.
//

#import "HAPShaderInvert.h"
#import "cocos2d.h"
#import "HAPMacros.h"

@implementation HAPShaderInvert

+ (CCGLProgram *)loadShader;
{

    HAPShaderInvert *shaderLoader = [[HAPShaderInvert alloc] init];
    NSString *shaderName = [shaderLoader shaderName];
    CCGLProgram *shader = [[CCShaderCache sharedShaderCache] programForKey:shaderName];
    if (shader == nil){
        NSString *vertexShader = [shaderLoader vertexShader];
        NSString *fragmentShader = [shaderLoader fragmentShader];

        shader = [[CCGLProgram alloc] initWithVertexShaderByteArray:[vertexShader UTF8String] fragmentShaderByteArray:[fragmentShader UTF8String]];
        
        [shader addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
        [shader addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
        [shader link];
        [shader updateUniforms];
        
        [[CCShaderCache sharedShaderCache] addProgram:shader forKey:@"HDJGrayscaleShader"];
    }
    return shader;
    
}

- (NSString *)shaderName;
{
    return @"Invert";
}

- (NSString *)fragmentShader;
{
    return String(
        precision highp float;

        varying highp vec2 v_texCoord;
        uniform sampler2D u_texture;
        const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);

        void main()
        {
            vec4 color = texture2D(u_texture, v_texCoord);
            gl_FragColor = vec4((1.0 - color.rgb), color.a);
        }
    );
}
@end
