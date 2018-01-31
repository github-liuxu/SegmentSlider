//
//  SegmentSlider.m
//  SegmentSlider
//
//  Created by Meicam on 2018/1/31.
//  Copyright © 2018年 刘东旭. All rights reserved.
//

#import "SegmentSlider.h"

@implementation AudioSegment

@end

@interface SegmentSlider() {
    BOOL isInRect;
    CGFloat padding;
}

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SegmentSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        padding = 15;
        self.backgroundColor = [UIColor colorWithRed:25.0/255 green:25.0/255 blue:25.0/255 alpha:1];
        [self addSubview:self.line];
        [self addSubview:self.imageView];
    }
    return self;
}


- (void)setVideoSegments:(NSArray<NSNumber *> *)videoSegments {
    _videoSegments = videoSegments;
    [self setNeedsLayout];
}

- (void)setAudioSegments:(NSArray<AudioSegment *> *)audioSegments {
    _audioSegments = audioSegments;
    [self setNeedsLayout];
}

- (void)setValue:(CGFloat)value {
    _value = value;
    [self setNeedsLayout];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.imageView.frame, point)) {
        isInRect = YES;
    } else {
        isInRect = NO;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    point.y = self.frame.size.height/2;
    if (point.x<padding) {
        point.x = padding;
    }
    if (point.x>self.frame.size.width-padding) {
        point.x = self.frame.size.width-padding;
    }
    if (isInRect) {
        self.imageView.center = point;
        self.value = 1.0*(point.x-padding)/(self.frame.size.width-2*padding);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.line.frame = CGRectMake(padding, (self.frame.size.height-4)/2, self.frame.size.width-2*padding, 4);
    //移除间隔并重新添加
    for (UIView *view in [self.line subviews]) {
        [view removeFromSuperview];
    }
    for (NSNumber *number in self.videoSegments) {
        CGFloat x = [number floatValue]*(self.frame.size.width-2*padding);
        UIView *view = [UIView new];
        view.backgroundColor = self.backgroundColor;
        view.frame = CGRectMake(x-1, 0, 2, 4);
        [self.line addSubview:view];
    }
    //移除音乐片段控件并重新添加
    for (UIView *view in [self subviews]) {
        //除了原点和底线全部移除
        if ([view isEqual:self.imageView] || [view isEqual:self.line]) {
            continue;
        } else {
            [view removeFromSuperview];
        }
    }
    for (AudioSegment *audioSegment in self.audioSegments) {
        CGFloat x1 = audioSegment.percentIn*(self.frame.size.width-2*padding)+padding;
        CGFloat x2 = audioSegment.percentOut*(self.frame.size.width-2*padding)+padding;
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithRed:240/255.0 green:255/255.0 blue:5/255.0 alpha:0.7];
        view.frame = CGRectMake(x1, self.line.frame.origin.y, x2-x1, 4);
        [self addSubview:view];
    }
    self.imageView.frame = CGRectMake(0, 0, 30, 30);
    self.imageView.layer.cornerRadius = 15;
    self.imageView.center = CGPointMake(self.value*(self.frame.size.width-2*padding)+padding, self.frame.size.height/2);
    [self bringSubviewToFront:self.imageView];
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    }
    return _line;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

@end
