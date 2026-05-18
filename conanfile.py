from conan import ConanFile
from conan.tools.cmake import cmake_layout
from conan.tools.cmake import CMake
from conan.tools.cmake import CMakeDeps
from conan.tools.cmake import CMakeToolchain


class MyPackage(ConanFile):
    settings = "os", "arch", "compiler", "build_type"

    options = {"asan": [True, False],
               "ubsan": [True, False]}
    default_options = {"asan": False,
                       "ubsan": False}

    # Defines the dependencies of the package
    def requirements(self):
        self.requires("boost/1.89.0")
        self.requires("protobuf/3.21.12", force=True)
        self.requires("grpc/1.54.3", force=True)

    def configure(self):
        self.options["openssl"].shared = True

        # turn off some grpc plugins which are not used
        self.options["grpc"].php_plugin = False
        self.options["grpc"].node_plugin = False
        self.options["grpc"].ruby_plugin = False
        self.options["grpc"].csharp_plugin = False
        self.options["grpc"].python_plugin = False
        self.options["grpc"].objective_c_plugin = False

    # Specifies the generators for the build system
    generators = "CMakeDeps", "CMakeToolchain"

    def layout(self):
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

