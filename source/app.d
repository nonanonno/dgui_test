import std;
import bindbc.glfw;
import bindbc.opengl;
import helper;

int main(string[] args) {
    GLFWSupport glfwRet = loadGLFW();
    enforce(glfwRet == glfwSupport);
    writeln(glfwRet);

    enforce(glfwInit() == GL_TRUE);
    scope (exit)
        glfwTerminate();

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    GLFWwindow* window = glfwCreateWindow(640, 480, "Hello World", null, null);
    if (!window) {
        return -1;
    }
    glfwMakeContextCurrent(window);

    auto openglRet = loadOpenGL();
    enforce(openglRet == glSupport);
    writeln(openglRet);

    glfwSwapInterval(1);

    glClearColor(0.2, 0.5, 0.7, 0.5);

    auto program = createProgram(import("shader/point.vert"), import("shader/point.frag"));
    writeln(program);

    while (!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);
        glUseProgram(program);

        glfwSwapBuffers(window);

        glfwPollEvents();
    }
    return 0;
}
