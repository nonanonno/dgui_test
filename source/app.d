import std;
import bindbc.glfw;
import bindbc.opengl;

int main(string[] args) {
    GLFWSupport ret = loadGLFW();
    enforce(ret == glfwSupport);

    enforce(glfwInit() != 0);

    GLFWwindow* window = glfwCreateWindow(640, 480, "Hello World", null, null);
    if (!window) {
        glfwTerminate();
        return -1;
    }
    glfwMakeContextCurrent(window);

    enforce(loadOpenGL() == glSupport);

    while (!glfwWindowShouldClose(window)) {
        glClear(GL_COLOR_BUFFER_BIT);
        glfwSwapBuffers(window);

        glfwPollEvents();
    }

    glfwTerminate();
    return 0;
}
