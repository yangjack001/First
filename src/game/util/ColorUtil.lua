ColorUtil = {}

function ColorUtil.applyGray(node)
    local vertDefaultSource = "\n"..
        "attribute vec4 a_position; \n" ..
        "attribute vec2 a_texCoord; \n" ..
        "attribute vec4 a_color; \n"..                                                    
        "#ifdef GL_ES  \n"..
        "varying lowp vec4 v_fragmentColor;\n"..
        "varying mediump vec2 v_texCoord;\n"..
        "#else                      \n" ..
        "varying vec4 v_fragmentColor; \n" ..
        "varying vec2 v_texCoord;  \n"..
        "#endif    \n"..
        "void main() \n"..
        "{\n" ..
        "gl_Position = CC_PMatrix * a_position; \n"..
        "v_fragmentColor = a_color;\n"..
        "v_texCoord = a_texCoord;\n"..
        "}"

    local pszFragSource = "#ifdef GL_ES \n" ..
        "precision mediump float; \n" ..
        "#endif \n" ..
        "varying vec4 v_fragmentColor; \n" ..
        "varying vec2 v_texCoord; \n" ..
        "void main(void) \n" ..
        "{ \n" ..
        "vec4 c = texture2D(CC_Texture0, v_texCoord); \n" ..
        "gl_FragColor.xyz = vec3(0.4*c.r + 0.4*c.g +0.4*c.b); \n"..
        "gl_FragColor.w = c.w; \n"..
        "}"

    local pProgram = cc.GLProgram:createWithByteArrays(vertDefaultSource,pszFragSource)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:updateUniforms()
    node:setGLProgram(pProgram)
end