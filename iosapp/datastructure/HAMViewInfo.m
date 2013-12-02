//
//  HAMViewInfo.m
//  iosapp
//
//  Created by daiyue on 13-7-24.
//  Copyright (c) 2013年 Droplings. All rights reserved.
//

#import "HAMViewInfo.h"

@implementation HAMViewInfo

@synthesize xnum_;
@synthesize ynum_;
@synthesize cardHeight;
@synthesize cardWidth;

@synthesize catLableY;
@synthesize cardLableY;
@synthesize fontSize;

@synthesize picOffsetX;
@synthesize picOffsetY;
@synthesize picHeight;
@synthesize picWidth;

-(id)initWithframe:(CGRect)frame xnum:(int)_xnum ynum:(int)_ynum h:(double)_h minspace:(double)_minspace
{
    if (self=[super init]){
        xnum_=_xnum;
        ynum_=_ynum;
        //h=_h;
        
        //CGRect rect=[[UIScreen mainScreen]bounds];
        //CGRect recttab=[[UIApplication sharedApplication] statusBarFrame];
        maxx=frame.size.width;
        maxy=frame.size.height;
        
        minspace=_minspace;
        
        //[self updateInfo];
    }
    return self;
}

-(id)initWithXnum:(int)xnum ynum:(int)ynum
{
    CGRect cardZone;
    if (self = [super init]) {
        switch (xnum) {
            case VIEWINFO_LAYOUT_1x1:
                cardWidth = 632.5;
                cardHeight = 612;
                xnum_ = 1;
                ynum_ = 1;
                cardZone.origin = CGPointMake(70, 250);
                break;
            
            case VIEWINFO_LAYOUT_2x2:
                cardWidth = 351.5;
                cardHeight = 340;
                xnum_ = 2;
                ynum_ = 2;
                cardZone = CGRectMake(40, 220, 688, 684);
                break;
                
            case VIEWINFO_LAYOUT_3x3:
                cardWidth = 239;
                cardHeight = 231;
                xnum_ = 3;
                ynum_ = 3;
                cardZone = CGRectMake(20, 215, 726, 694);
                break;
                
            default:
                break;
        }
    }
    picOffsetX = 70 * cardWidth / 632.5;
    picOffsetY = 40 * cardWidth / 632.5;
    picWidth = cardWidth - 2 * picOffsetX;
    picHeight = cardHeight * 0.6;
    
    fontSize = 49 * cardWidth / 632.5;
    catLableY = 425 * cardWidth / 632.5;
    cardLableY = 252 * cardWidth / 351.5;
    [self getCardPosWithCardZone:cardZone];
    return self;
}

-(void)getCardPosWithCardZone:(CGRect)cardZone
{
    double xSpace = (cardZone.size.width - xnum_ * cardWidth) / (xnum_ - 1);
    double ySpace = (cardZone.size.height - ynum_ * cardHeight) / (ynum_ - 1);
    
    int i,j;
    for (i = 0; i < ynum_; i++) {
        for (j = 0; j < xnum_; j++) {
            double cardX = cardZone.origin.x + j * (cardWidth + xSpace);
            double cardY = cardZone.origin.y + i * (cardHeight + ySpace);
            cardPos[i * xnum_ + j] = CGPointMake(cardX, cardY);
        }
    }

}

-(CGPoint)cardPositionAtIndex:(int)index;
{
    index = index % (xnum_ * ynum_);
    return cardPos[index];
}

+(double)maxx
{
    CGRect rect=[[UIScreen mainScreen]bounds];
    return rect.size.width;
}

+(double)maxy
{
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGRect recttab=[[UIApplication sharedApplication] statusBarFrame];
    return rect.size.height-recttab.size.height;
}

@end