//
//  VolumeManager.m
//  RingerVolume
//
//  Created by Genji on 2020/11/20.
//

#import "VolumeManager.h"

// For supressing undeclared selector warnnings.
@interface AVSystemController

+ (instancetype)sharedAVSystemController;
- (BOOL)setVolumeTo:(float)arg1 forCategory:(id)arg2;
- (BOOL)getVolume:(float *)arg1 forCategory:(id)arg2;

@end

@interface VolumeManager ()

@property (nonatomic, retain) NSInvocation *setVolumeInvocation;
@property (nonatomic, retain) NSInvocation *getVolumeInvocation;

@end

@implementation VolumeManager

+ (instancetype)sharedManager {
  static VolumeManager *sharedManager = nil;
  if(sharedManager == nil) {
    sharedManager = [[VolumeManager alloc] init];
  }
  return sharedManager;
}

- (instancetype)init {
  self = [super init];
  if(self) {
    NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/Celestial.framework"];
    [bundle load];

    Class avSystemControllerClass = NSClassFromString(@"AVSystemController");
    id avSystemControllerInstance = [avSystemControllerClass performSelector:@selector(sharedAVSystemController)];

    NSString *soundCategory = @"Ringtone";

    SEL setVolumeSelector = @selector(setVolumeTo:forCategory:);
    NSMethodSignature *setVolumeSignature = [avSystemControllerClass instanceMethodSignatureForSelector: setVolumeSelector];
    self.setVolumeInvocation = [NSInvocation invocationWithMethodSignature: setVolumeSignature];
    [self.setVolumeInvocation setTarget:avSystemControllerInstance];
    [self.setVolumeInvocation setSelector:setVolumeSelector];
    [self.setVolumeInvocation setArgument:&soundCategory atIndex:3];

    SEL getVolumeSelector = @selector(getVolume:forCategory:);
    NSMethodSignature *getVolumeSignature = [avSystemControllerClass instanceMethodSignatureForSelector: getVolumeSelector];
    self.getVolumeInvocation = [NSInvocation invocationWithMethodSignature: getVolumeSignature];
    [self.getVolumeInvocation setTarget:avSystemControllerInstance];
    [self.getVolumeInvocation setSelector:getVolumeSelector];
    [self.getVolumeInvocation setArgument:&soundCategory atIndex:3];
  }

  return self;
}

- (float)ringerVolume {
  float volume = 1.0;
  float *result = &volume;
  [self.getVolumeInvocation setArgument:&result atIndex:2];
  [self.getVolumeInvocation invoke];
  return volume;
}

- (void)setRingerVolume:(float)newVolume {
  if(newVolume > 1.0) {
    newVolume = 1.0;
  }
  else if(newVolume < 0.0) {
    newVolume = 0.0;
  }
  [self.setVolumeInvocation setArgument:&newVolume atIndex:2];
  [self.setVolumeInvocation invoke];
}

@end
