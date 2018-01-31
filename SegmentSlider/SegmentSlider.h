//
//  SegmentSlider.h
//  SegmentSlider
//
//  Created by Meicam on 2018/1/31.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioSegment : NSObject

@property (nonatomic, assign) CGFloat percentIn;
@property (nonatomic, assign) CGFloat percentOut;

@end

@interface SegmentSlider : UIView
//当前值（0～1）
@property (nonatomic, assign) CGFloat value;
//每一段起始位置在总长度的百分比
@property (nonatomic, strong) NSArray<NSNumber *> *videoSegments;
//每一段音乐在整个timeline上的trimIn和trimOut所占的百分比
@property (nonatomic, strong) NSArray<AudioSegment *> *audioSegments;

@end

