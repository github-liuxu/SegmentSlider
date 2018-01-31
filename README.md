# SegmentSlider
可以分段的Slider


    self.view.backgroundColor = [UIColor orangeColor];
    SegmentSlider *slider = [[SegmentSlider alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 35)];
    [self.view addSubview:slider];
    slider.videoSegments = @[@0.2,@0.4,@0.7];
    AudioSegment *a1 = [AudioSegment new];
    a1.percentIn = 0.2;
    a1.percentOut = 0.4;
    slider.audioSegments = @[a1];
    AudioSegment *a2 = [AudioSegment new];
    a2.percentIn = 0.6;
    a2.percentOut = 0.9;
    slider.audioSegments = @[a1,a2];
