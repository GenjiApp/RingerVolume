//
//  VolumeManager.h
//  VolumeManager
//
//  Created by Genji on 2020/11/22.
//

#import <Foundation/Foundation.h>

//! Project version number for VolumeManager.
FOUNDATION_EXPORT double VolumeManagerVersionNumber;

//! Project version string for VolumeManager.
FOUNDATION_EXPORT const unsigned char VolumeManagerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <VolumeManager/PublicHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface VolumeManager : NSObject

@property (nonatomic) float ringerVolume;

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
