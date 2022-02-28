import sys
import tensorrt as trt
sys.path.append('../')
import common

'''
通过加载onnx文件，构建engine
'''
onnx_file_path = "yolox_s.onnx"  #输入需要转换的onnx文件

G_LOGGER = trt.Logger(trt.Logger.WARNING)

# 1、动态输入第一点必须要写的
explicit_batch = 1 << (int)(trt.NetworkDefinitionCreationFlag.EXPLICIT_BATCH)

batch_size = 1  # trt推理时最大支持的batchsize

with trt.Builder(G_LOGGER) as builder, builder.create_network(explicit_batch) as network, \
        trt.OnnxParser(network, G_LOGGER) as parser:

    builder.max_batch_size = batch_size

    config = builder.create_builder_config()
    config.max_workspace_size = 1<<32  # common文件可以自己去tensorrt官方例程下面找
    config.set_flag(trt.BuilderFlag.TF32)
    print('Loading ONNX file from path {}...'.format(onnx_file_path))

    with open(onnx_file_path, 'rb') as model:
        print('Beginning ONNX file parsing')
        parser.parse(model.read())
    print('Completed parsing of ONNX file')
    print('Building an engine from file {}; this may take a while...'.format(onnx_file_path))

    # 动态输入问题解决方案
    profile = builder.create_optimization_profile()
    profile.set_shape("input_1", (1, 512, 512, 3), (1, 512, 512, 3), (1, 512, 512, 3))
    config.add_optimization_profile(profile)

    engine = builder.build_engine(network, config)
    print("Completed creating Engine")

    # 保存输出的engine文件，并自定义engine文件名称
    engine_file_path = 'yolox_fp323.engine'
    with open(engine_file_path, "wb") as f:
        f.write(engine.serialize())

