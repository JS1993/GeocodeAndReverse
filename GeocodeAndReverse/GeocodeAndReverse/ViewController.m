//
//  ViewController.m
//  GeocodeAndReverse
//
//  Created by  江苏 on 16/5/16.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextView *detailTV;
@property (strong, nonatomic) IBOutlet UITextField *latitudeTF;
@property (strong, nonatomic) IBOutlet UITextField *longitudeTF;

/*地理编码管理器*/
@property(strong,nonatomic)CLGeocoder* geoCoder;

@end

@implementation ViewController

#pragma mark--懒加载
/*地理编码管理器*/
-(CLGeocoder *)geoCoder
{
    if (_geoCoder==nil) {
        _geoCoder=[[CLGeocoder alloc]init];
    }
    return _geoCoder;
}

/**
 *  地理编码
 */
- (IBAction)geocoder:(UIButton *)sender {
    
    [self.geoCoder geocodeAddressString:self.detailTV.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //安全验证
        if (error!=nil) return ;
        
        //获得地标对象
        CLPlacemark *mark=[placemarks firstObject];
        
        self.latitudeTF.text=@(mark.location.coordinate.latitude).stringValue;
        
        self.longitudeTF.text=@(mark.location.coordinate.longitude).stringValue;
        
    }];
}

/**
 *  反地理编码
 */
- (IBAction)geoReverseCode:(UIButton *)sender {
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:self.latitudeTF.text.doubleValue longitude:self.longitudeTF.text.doubleValue];
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error!=nil) return ;
        
        CLPlacemark *mark=[placemarks firstObject];
        
        self.detailTV.text=mark.name;
        
    }];
    
}



@end
