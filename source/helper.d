module helper;

import bindbc.opengl;
import std;

GLuint createProgram(string vsrc, string fsrc) {
    auto program = glCreateProgram();

    if (vsrc) {
        auto vobj = glCreateShader(GL_VERTEX_SHADER);
        const ptr = vsrc.ptr;

        glShaderSource(vobj, 1, &ptr, null);
        glCompileShader(vobj);

        if (printShaderInfoLog(vobj, "vertex shader")) {
            glAttachShader(program, vobj);
        }
        glDeleteShader(vobj);
    }

    if (fsrc) {
        auto fobj = glCreateShader(GL_FRAGMENT_SHADER);
        const ptr = fsrc.ptr;

        glShaderSource(fobj, 1, &ptr, null);
        glCompileShader(fobj);

        if (printShaderInfoLog(fobj, "fragment shader")) {
            glAttachShader(program, fobj);
        }
        glDeleteShader(fobj);
    }

    glBindAttribLocation(program, 0, "position");
    glBindFragDataLocation(program, 0, "fragment");
    glLinkProgram(program);

    if (printProgramInfoLog(program)) {
        return program;
    }

    glDeleteProgram(program);

    return 0;
}

GLboolean printShaderInfoLog(GLuint shader, string src) {
    GLint status;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &status);
    if (status == GL_FALSE) {
        writeln("Compile error in ", src);
    }

    GLsizei bufSize;
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &bufSize);
    if (bufSize > 1) {
        auto infoLog = new char[bufSize];
        GLsizei length;
        glGetShaderInfoLog(shader, bufSize, &length, infoLog.ptr);

        writeln(infoLog);
    }

    return status.to!GLboolean;
}

GLboolean printProgramInfoLog(GLuint program) {
    GLint status;
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    if (status == GL_FALSE) {
        writeln("Link Error.");
    }

    GLsizei bufSize;
    glGetProgramiv(program, GL_INFO_LOG_LENGTH, &bufSize);

    if (bufSize > 1) {
        auto infoLog = new char[bufSize];
        GLsizei length;
        glGetProgramInfoLog(program, bufSize, &length, infoLog.ptr);

        writeln(infoLog);
    }
    return status.to!GLboolean;
}
