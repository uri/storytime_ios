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
@end
