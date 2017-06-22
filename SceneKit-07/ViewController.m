//
//  ViewController.m
//  SceneKit-07
//
//  Created by ShiWen on 2017/6/21.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property (nonatomic,strong) SCNView *mScnView;
@property (nonatomic,strong) SCNScene *mScene;
@property (nonatomic,strong) SCNNode *lightNode;
@property (nonatomic,strong) SCNNode *sunNode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
    //添加相机
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 50);
    [self.mScene.rootNode addChildNode:cameraNode];
    
    SCNNode *lightNode = [SCNNode node];
    lightNode.light = [SCNLight light];
    lightNode.light.type = SCNLightTypeOmni;
    lightNode.light.color = [UIColor whiteColor];
    lightNode.position = SCNVector3Make(50, 10, 30);
    [self.mScene.rootNode addChildNode:lightNode];
    
    //添加球
    SCNSphere *sphere = [SCNSphere sphereWithRadius:10];
    sphere.firstMaterial.diffuse.contents = [UIImage imageNamed:@"earth-diffuse.jpg"];
    //法线 可以让其更加有立体感
    sphere.firstMaterial.normal.contents = [UIImage imageNamed:@"earth-bump.png"];
    //    镜面颜色
    sphere.firstMaterial.specular.contents = [UIImage imageNamed:@"earth-specular.jpg"];
    //    自身发亮，但不照射其他
    sphere.firstMaterial.emission.contents = [UIImage imageNamed:@"earth-emissive-mini2.jpg"];
    //    是否渲染每个顶点每个属性 提高渲染质量
    sphere.firstMaterial.litPerPixel = YES;
    
    sphere.firstMaterial.blendMode = SCNBlendModeAlpha;
    //    是否锁定漫反射
    sphere.firstMaterial.locksAmbientWithDiffuse = YES;
//    设置材质透明性
//    sphere.firstMaterial.transparent.contents = [UIImage imageNamed:@"cloudsTransparency.png"];
//    sphere.firstMaterial.transparencyMode = SCNTransparencyModeRGBZero;
////    设置透明度 默认是1 透明属性的颜色乘以此属性。 然后使用结果根据transparentMode属性定义的规则生成最终的透明度
//    sphere.firstMaterial.transparency = 2;
    
    
//    设置表面光滑度
//    sphere.firstMaterial.shininess = 1000;
    
//    是否两边都渲染
//    sphere.firstMaterial.doubleSided = YES;
////    确定接收器的剔除模式。 默认为SCNCullBack。动画。
//    sphere.firstMaterial.cullMode = SCNCullFront;

    SCNNode *sphereNode = [SCNNode nodeWithGeometry:sphere];
    

    [self.mScene.rootNode addChildNode:sphereNode];
    //    自转
    SCNAction *rotion = [SCNAction rotateByAngle:2*M_PI aroundAxis:SCNVector3Make(0, 30, 0) duration:4];
    [sphereNode runAction:[SCNAction repeatActionForever:rotion]];
    
    
    
    
    

    
}

-(SCNScene*)mScene{
    if (!_mScene) {
        _mScene = [SCNScene scene];
    }
    return _mScene;
}
-(SCNView*)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.allowsCameraControl = YES;
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.scene = self.mScene;
        
    }
    return _mScnView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
