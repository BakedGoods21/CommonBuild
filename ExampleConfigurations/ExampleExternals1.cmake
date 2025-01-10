prepare_external_library(GTest git@github.com:google/googletest.git v1.15.2 "" FALSE) 
prepare_external_library(SPIRV-Headers git@github.com:KhronosGroup/SPIRV-Headers.git vulkan-sdk-1.3.290 "" FALSE) 
prepare_external_library(SPIRV-Tools git@github.com:KhronosGroup/SPIRV-Tools.git vulkan-sdk-1.3.290 "-DSPIRV-Headers_SOURCE_DIR=${EXTERNAL_DIR}/packages/SPIRV-Headers/src/SPIRV-Headers" FALSE)
prepare_external_library(glslang git@github.com:KhronosGroup/glslang.git 14.3.0 "-DALLOW_EXTERNAL_SPIRV_TOOLS=True" FALSE)
prepare_external_library(vsg git@github.com:vsg-dev/VulkanSceneGraph.git v1.1.10 "" FALSE)
prepare_external_library(assimp git@github.com:assimp/assimp.git v5.4.3 "-DASSIMP_BUILD_TESTS=OFF" FALSE)
prepare_external_library(vsgXchange git@github.com:vsg-dev/vsgXchange.git v1.1.6 "" FALSE)

ExternalProject_Add_StepDependencies(SPIRV-Tools download SPIRV-Headers)
ExternalProject_Add_StepDependencies(glslang install SPIRV-Tools)
ExternalProject_Add_StepDependencies(vsg install glslang)
ExternalProject_Add_StepDependencies(vsgXchange install vsg assimp)

