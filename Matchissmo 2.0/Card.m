//
//  Card.m
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/6/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score=0;
    
    
    
    for (Card *card in otherCards){
    
        if([card.contents isEqualToString:self.contents]) {
            score=1;
        }
        
        
    }
        
    
    return score;
    
}

@end
