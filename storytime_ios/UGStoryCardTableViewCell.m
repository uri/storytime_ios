//
//  UGStoryCardTableViewCell.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGStoryCardTableViewCell.h"

@implementation UGStoryCardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13.0f];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.detailTextLabel.numberOfLines = 0;
        self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void) setStoryCard:(UGStoryCardItem *)sc
{
    _storyCard = sc;
    // Set upvotes and downvotes
    self.textLabel.text = [NSString stringWithFormat:@"%@ | %@ R:%@ -- (%@) ", _storyCard.upvotes, _storyCard.downvotes, _storyCard.numReplies, _storyCard.author];
    self.detailTextLabel.text = _storyCard.content;
    [self setNeedsLayout];
}



+ (CGFloat)heightForCellWithStoryCard:(UGStoryCardItem *)sc {
    CGSize sizeToFit = [sc.content sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(220.0f, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    
    return fmaxf(70.0f, sizeToFit.height + 45.0f);
}

#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(10.0f, 10.0f, 300.0f, 20.0f);

    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    detailTextLabelFrame.size.height = [[self class] heightForCellWithStoryCard:_storyCard] - 45.0f;
    self.detailTextLabel.frame = detailTextLabelFrame;
}

#pragma mark -
#pragma mark TIStuff

- (void)buttonWasTapped:(UIButton *)button {
	
    NSString *btnText = [[button titleLabel] text];
    NSLog(@"%@", btnText);

	if ([btnText isEqualToString:@"U"] && [_delegate respondsToSelector:@selector(cellUpvoteWasTapped:)]){
		[_delegate cellUpvoteWasTapped:self];
	} else 	if ([btnText isEqualToString:@"D"] && [_delegate respondsToSelector:@selector(cellDownvoteWasTapped:)]){
        [_delegate cellDownvoteWasTapped:self];
    }
}

- (void)backViewWillAppear:(BOOL)animated {
    
    CGPoint point = CGPointMake(5, 4);
    CGSize size = CGSizeMake((self.backView.frame.size.width - 40) / 4, (self.backView.frame.size.height - 8));
    int spacer = 12;
    
	// Upvote button
	UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[button setTitle:@"U" forState:UIControlStateNormal];
	[button setFrame: CGRectMake(point.x, point.y, size.width, size.height)];
	[self.backView addSubview:button];
    
    point.x += size.width + spacer;
    
    // Downvote button
    UIButton * downvote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[downvote addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[downvote setTitle:@"D" forState:UIControlStateNormal];
	[downvote setFrame: CGRectMake(point.x, point.y, size.width, size.height)];
	[self.backView addSubview:downvote];
    
    point.x += size.width + spacer;
    
    UIButton * profile = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[profile addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
	[profile setTitle:@"Profile" forState:UIControlStateNormal];
	[profile setFrame: CGRectMake(point.x, point.y, size.width * 2, size.height)];
	[self.backView addSubview:profile];
    
    [self.backView setBackgroundColor: [UIColor darkGrayColor]];
}

- (void)backViewDidDisappear:(BOOL)animated {
	// Remove any subviews from the backView.
	[self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)drawContentView:(CGRect)rect {
	
	UIColor * textColour = (self.selected || self.highlighted) ? [UIColor whiteColor] : [UIColor blackColor];
	[textColour set];
	
	UIFont * textFont = [UIFont boldSystemFontOfSize:22];
	
	CGSize textSize = [_text sizeWithFont:textFont constrainedToSize:rect.size];
	[_text drawInRect:CGRectMake((rect.size.width / 2) - (textSize.width / 2),
								(rect.size.height / 2) - (textSize.height / 2),
								textSize.width, textSize.height)
			withFont:textFont];
}

- (void)drawBackView:(CGRect)rect {
	
	[[UIImage imageNamed:@"meshpattern.png"] drawAsPatternInRect:rect];
	[self drawShadowsWithHeight:10 opacity:0.3 InRect:rect forContext:UIGraphicsGetCurrentContext()];
}

- (void)drawShadowsWithHeight:(CGFloat)shadowHeight opacity:(CGFloat)opacity InRect:(CGRect)rect forContext:(CGContextRef)context {
	
	CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
	
	CGFloat topComponents[8] = {0, 0, 0, opacity, 0, 0, 0, 0};
	CGGradientRef topGradient = CGGradientCreateWithColorComponents(space, topComponents, nil, 2);
	CGPoint finishTop = CGPointMake(rect.origin.x, rect.origin.y + shadowHeight);
	CGContextDrawLinearGradient(context, topGradient, rect.origin, finishTop, kCGGradientDrawsAfterEndLocation);
	
	CGFloat bottomComponents[8] = {0, 0, 0, 0, 0, 0, 0, opacity};
	CGGradientRef bottomGradient = CGGradientCreateWithColorComponents(space, bottomComponents, nil, 2);
	CGPoint startBottom = CGPointMake(rect.origin.x, rect.size.height - shadowHeight);
	CGPoint finishBottom = CGPointMake(rect.origin.x, rect.size.height);
	CGContextDrawLinearGradient(context, bottomGradient, startBottom, finishBottom, kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(topGradient);
	CGGradientRelease(bottomGradient);
}


@end
