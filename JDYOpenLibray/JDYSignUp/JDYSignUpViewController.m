//
//  JDYSignUpViewController.m
//  kdweibo
//
//  Created by Jacy Lee on 2021/12/13.
//  Copyright © 2021 www.kingdee.com. All rights reserved.
//

#import "JDYSignUpViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "UIColor+JDY.h"
#import "UIImage+JDY.h"
#import "JDYGradualButton.h"

#define ScreenFullHeight [[UIScreen mainScreen] bounds].size.height //屏幕高度
#define ScreenFullWidth [[UIScreen mainScreen] bounds].size.width   //屏幕宽度

#define HISUNPLUGIN_BUNDLE_NAME @"JDYOpenLibrayBundle.bundle"

#define HISUNPLUGIN_BUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: HISUNPLUGIN_BUNDLE_NAME]

#define HISUNPLUGIN_MYBUNDLE [NSBundle bundleWithPath: HISUNPLUGIN_BUNDLE_PATH]

@interface JDYSignUpViewController ()<MAMapViewDelegate>

@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UIView *contentView;
// 有多少个打卡范围(可拓展不同地方打卡)
@property (nonatomic, copy)NSArray *circles;
// 高德地图
@property (nonatomic, strong)MAMapView *mapView;
@property (nonatomic,strong)JDYGradualButton *signInBtn;
// 经纬度
@property (nonatomic,strong)NSString *userLongitude;
@property (nonatomic,strong)NSString *userLatitude;
@property (nonatomic,strong)CLLocation *nowLocation;

@property (nonatomic,strong)NSString *titleName;
@property (nonatomic,assign)double companyLongitude;
@property (nonatomic,assign)double companyLatitude;
@property (nonatomic,assign)double distance;
@property (nonatomic,assign)double nowDistance;
@property (nonatomic,copy) void (^callBack)(BOOL isSignIn,JDYLocation *location);
@end

@implementation JDYSignUpViewController{
    double _zoomLevel;
}
-(void)dealloc{
    NSLog(@"---打卡界面销毁---");
}
//distance为0时候表示打卡范围不限
-(instancetype)initWithLongitude:(double)longitude
                        latitude:(double)latitude
                           title:(NSString*)title
                        distance:(double)distance
                        callBack:(void(^)(BOOL isSignIn,JDYLocation *location))callBack{
    self = [super init];
    if (self) {
        self.companyLongitude = longitude;
        self.companyLatitude = latitude;
        self.titleName = title;
        self.distance = distance;
        self.callBack = callBack;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    [self setupView];
    [self initMapView];
}

-(void)setupView{
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.contentView];
    
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.signInBtn];
    // 定位按钮
    UIButton *locBtn = [[UIButton alloc ] initWithFrame:CGRectMake(ScreenFullWidth - 16 - 36,  self.signInBtn.center.y-18, 36, 36)];
    
    UIImage *img = [UIImage imageNamed:@"JDYOpenLibray.bundle/images/jdy_signIn_local"];
    NSLog(@"img is %@",img);
    //加载自定义名称为Resources.bundle中对应images文件夹中的图片
    //从mainbundle中获取resources.bundle
//    NSString *strPath = [[NSBundle bundleForClass:NSClassFromString(@"JDYOpenLibray")] pathForResource:@"JDYOpenLibray" ofType:@"bundle"];
//    NSString *strImage = [[NSBundle bundleWithPath:strPath] pathForResource:@"jdy_signIn_local@2x" ofType:@"png" inDirectory:@"images"];
//    strImage =strImage.length ? strImage: [[NSBundle bundleWithPath:strPath] pathForResource:@"jdy_signIn_local" ofType:@"png" inDirectory:@"images"];
//    UIImage *ima = [UIImage imageWithContentsOfFile:strImage];
//    img = img? img :ima;
    
    [locBtn setImage:img forState:UIControlStateNormal];
    [locBtn addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:locBtn];
}
-(void)locationClick{
    // 设置地图中心位置
    [self.mapView setZoomLevel:_zoomLevel animated:YES];
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([self.userLatitude floatValue], [self.userLongitude floatValue]) animated:YES];
    
}

- (void)setAddress {
    NSMutableArray *arr = [NSMutableArray array];
    MACircle *circle1 = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(self.companyLatitude,self.companyLongitude) radius:self.distance];//公司范围
    [arr addObject:circle1];
    self.circles = [NSArray arrayWithArray:arr];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.mapView addOverlays:self.circles];
    
}
- (void)initMapView {
    // https配置
    [AMapServices sharedServices].enableHTTPS = YES;
    // 初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), ScreenFullWidth, self.contentView.frame.size.height-self.headerView.frame.size.height)];
    self.mapView.delegate = self;
    // 显示定位小蓝点
    self.mapView.showsUserLocation = YES;
    self.mapView.showsScale = NO;
    // 显示指南针
    self.mapView.showsCompass = NO;
    // 追踪用户的location更新
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    // 放大等级
    _zoomLevel = 16.5 - 0.002 * self.distance;
    
    [self.mapView setZoomLevel:_zoomLevel animated:YES];//zoomLevel越大地图范围约小
    [self.contentView insertSubview:self.mapView atIndex:0];
    
    [self initUserLocationRepresentation];
    [self setAddress];
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.companyLatitude,self.companyLongitude);
//    pointAnnotation.title = self.companyName.length ? self.companyName : @"目的地";
    //    pointAnnotation.subtitle = @"地址";
    [self.mapView addAnnotation:pointAnnotation];
}
- (void)initUserLocationRepresentation {//测试后：2D没效果,3D才生效[AMap3DMap 8.1.0地图空白，因为需要同意隐私合规接口说明 ？用6.1.0正常]
    // 初始化小蓝点
    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
    r.showsAccuracyRing = NO;// 精度圈是否显示，默认YES
    r.lineWidth = 2;// 精度圈 边线宽度，默认0
    [self.mapView updateUserLocationRepresentation:r];
}

// 计算两个经纬度点的距离
- (double)distanceBetweenCenterLatitude:(double)centerLatitude centerLongitude:(double)centerLongitude userLatitude:(double)userLatitude  userLongitude:(double)userLongitude{
    
    double dd = M_PI/180;
    double x1=centerLatitude*dd,x2=userLatitude*dd;
    double y1=centerLongitude*dd,y2=userLongitude*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //返回 m
    return  distance;
}

// 高德地图delegate
#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    
    if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:(MACircle*)overlay];
        //        circleRenderer.lineWidth    = 1.f;
        //        circleRenderer.strokeColor = [UIColor colorWithRGB:0x2386EE];
        
        NSInteger index = [self.circles indexOfObject:overlay];
        if(index == 0) {
            circleRenderer.fillColor    = [UIColor colorWithRGB:0x2386EE alpha:0.2];
        } else if(index == 1) {
            circleRenderer.fillColor   = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        } else if(index == 2) {
            circleRenderer.fillColor   = [[UIColor blueColor] colorWithAlphaComponent:0.3];
        } else {
            circleRenderer.fillColor   = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
        }
        return circleRenderer;
    }
    
    return nil;
}
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        MAPinAnnotationView *annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"dddddd"];
        annotationView.canShowCallout= YES;    //设置气泡可以弹出，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
//        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:NSClassFromString(@"JDYOpenLibray")] pathForResource:@"JDYOpenLibray" ofType:@"bundle"]];
//        UIImage *img = [UIImage imageForResourcePath:@"images/jdy_signIn_point@2x" ofType:@"png" inBundle:bundle];
        UIImage *img = [UIImage imageNamed:@"JDYOpenLibray.bundle/images/jdy_signIn_point"];
        
        annotationView.image = img;
        NSLog(@"name==%@",annotation.title);
        return annotationView;
    }
    return nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    // 获取用户位置的经纬度
    self.userLongitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    self.userLatitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    self.nowLocation = userLocation.location;    double distance = [self distanceBetweenCenterLatitude:self.companyLatitude centerLongitude:self.companyLongitude userLatitude:[self.userLatitude doubleValue]  userLongitude:[self.userLongitude doubleValue]];
    _nowDistance = distance;
    if (distance <= _distance || _distance <=0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSString *time = [formatter stringFromDate:[NSDate date]];
        _signInBtn.backgroundColor = [UIColor greenColor];
        [_signInBtn setTitle:[NSString stringWithFormat:@"到店打卡 %@",time] forState:UIControlStateNormal];
        [self.signInBtn setStartColor:[UIColor colorWithRGB:0x4DA7FA] endColor:[UIColor colorWithRGB:0x2386EE]];
    }else {
        [self.signInBtn setTitle:@"未进入打卡范围" forState:UIControlStateNormal];
        [self.signInBtn setStartColor:[UIColor colorWithRGB:0x05C8C8] endColor:[UIColor colorWithRGB:0x2DBE91]];
        
    }
}
// 获取当前所在的城市名、街道
-(void)getAddress{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:self.nowLocation completionHandler:^(NSArray *array, NSError *error){

        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSString *nation = placemark.country;//中国
            NSString *province = placemark.administrativeArea.length>0 ?placemark.administrativeArea :city; //广东省或者北京市（直辖市administrativeArea取值为nil）
            NSString *district = placemark.subLocality;//南山区
            NSString *address = placemark.thoroughfare.length >0 ?placemark.thoroughfare :placemark.name;//某个街道某个号----经过测试thoroughfare可能为空
            
//            NSMutableDictionary *retDic = [[NSMutableDictionary alloc] init];
//            [retDic setObject:[NSString stringWithFormat:@"%.0f",self->_nowDistance] forKey:@"offset"];
//            [retDic setObject:self.userLongitude forKey:@"longitude"];
//            [retDic setObject:self.userLatitude forKey:@"latitude"];
//            [retDic setObject:nation forKey:@"nation"];
//            [retDic setObject:province forKey:@"province"];
//            [retDic setObject:city forKey:@"city"];
//            [retDic setObject:district forKey:@"district"];
//            [retDic setObject:address forKey:@"address"];
            
            JDYLocation *loc = [[JDYLocation alloc]init];
            loc.offset =[NSNumber numberWithInt:self->_nowDistance];
            loc.longitude =self.userLongitude;
            loc.userLatitude = self.userLatitude;
            loc.nation =nation;
            loc.province =province;
            loc.city =city;
            loc.district =district;
            loc.address =address;
            if (self.callBack) {
                self.callBack(YES,loc);
            }
            //               [self removeSignInView];
        }else if (error == nil && [array count] == 0){
            //               [KDPopup showHUDToast:@"位置信息为空"];
        }else if (error != nil){
            //               [KDPopup showHUDToast:[NSString stringWithFormat:@"位置获取异常 %@",error]];
        }
    }];
}

-(void)signInAction{
    double distance = [self distanceBetweenCenterLatitude:self.companyLatitude centerLongitude:self.companyLongitude userLatitude:[self.userLatitude doubleValue]  userLongitude:[self.userLongitude doubleValue]];
    if (distance <= _distance || _distance <=0) {
        [self getAddress];
    }else {
        //        [KDPopup showHUDToast:@"打卡失败" inView:self.contentView];
    }
}

- (JDYGradualButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn = [JDYGradualButton buttonWithType:UIButtonTypeSystem startColor:[UIColor colorWithRGB:0x05C8C8] endColor:[UIColor colorWithRGB:0x2DBE91] colorType:JDYGradualButtonColorTypeH];
        [_signInBtn setFrame:CGRectMake(self.contentView.frame.size.width/2-92, self.contentView.frame.size.height-66, 184, 50)];
        [_signInBtn setTitle:@"未进入打卡范围" forState:UIControlStateNormal];
        [_signInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _signInBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _signInBtn.layer.cornerRadius = 25.0f;
        _signInBtn.clipsToBounds = YES;
        [_signInBtn addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signInBtn;
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.view.frame];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 48)];
        _headerView.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width/2-50, 0, 100, 48)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = self.titleName ? self.titleName :@"打卡";
        label.textAlignment = NSTextAlignmentCenter;
        [label setTextColor: [UIColor blackColor]];
        [_headerView addSubview:label];
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(self.contentView.frame.size.width-16-12, 16, 16, 16);
        
        NSBundle *bundle1 =[NSBundle bundleForClass:NSClassFromString(@"JDYSignUpManager")];
        NSString *path =[bundle1 pathForResource:@"JDYOpenLibray" ofType:@"bundle"];
        NSLog(@"bundle = %@,path = %@",bundle1,path);
        NSBundle *bundle = [NSBundle bundleWithPath:path];
        
        UIImage *img1 = [UIImage imageForResourcePath:@"images/jdy_signIn_cancel" ofType:@"png" inBundle:bundle];
        UIImage *img2 =  [UIImage imageForResourcePath:@"JDYOpenLibray.bundle/jdy_signIn_cancel" ofType:@"png" inBundle:[NSBundle bundleForClass:[self class]]];
        NSLog(@"img1 = %@,img2 = %@",img1,img2);
        
        UIImage *img = [UIImage imageNamed:@"JDYOpenLibray.bundle/images/jdy_signIn_cancel"];
        [cancelBtn setImage:img forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:cancelBtn];
    }
    return _headerView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenFullHeight/3, ScreenFullWidth, ScreenFullHeight/3*2)];
    }
    return _contentView;
}
- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    self.view.alpha = 0;
    self.contentView.frame = CGRectMake(0, self.view.frame.size.height, self.contentView.frame.size.width , self.contentView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    self.view.alpha = 1;
    self.contentView.frame = CGRectMake(0, ScreenFullHeight/3, self.contentView.frame.size.width , self.contentView.frame.size.height);
    [UIView commitAnimations];
}
- (void)showInView:(UIView*)view{
    [view addSubview:self.view];
    self.view.alpha = 0;
    self.contentView.frame = CGRectMake(0, self.view.frame.size.height, self.contentView.frame.size.width , self.contentView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    self.view.alpha = 1;
    self.contentView.frame = CGRectMake(0, ScreenFullHeight/3, self.contentView.frame.size.width , self.contentView.frame.size.height);
    [UIView commitAnimations];
}
- (void)hide{
    [self removeSignInView];
    if (self.callBack) {
        self.callBack(NO,nil);
    }
}
- (void)hideWithOutCallback{
    [self removeSignInView];
}
-(void)removeSignInView{
    [UIView animateWithDuration:0.3
                     animations:^{
        self.view.alpha = 0;
        self.contentView.frame = CGRectMake(0, self.view.frame.size.height, self.contentView.frame.size.width , self.contentView.frame.size.height);
    }completion:^(BOOL finished){
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
  
}

@end


