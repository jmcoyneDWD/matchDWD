//
//  PlayingCard.m
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/6/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
            
        }
    }
    return score;
}


@synthesize suit = _suit;
+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {return [[self rankStrings] count]-1;}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}
+ (NSArray *)validSuits
{
    return @[@"♥",@"♣",@"♦",@"♠"];
}

- (void) setSuit:(NSString *) suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit ;
        
    }
}

- (NSString *) suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@end
