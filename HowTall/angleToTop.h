//
//  angleToTop.h
//  HowTall
//
//  Created by Kyle on 3/23/15.
//  Copyright (c) 2015 USU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface angleToTop : NSObject

+(angleToTop*)sharedInstance;

@property (nonatomic, assign) float value;
//@property (nonatomic, assign) float calibrationAdjustment;

@end
