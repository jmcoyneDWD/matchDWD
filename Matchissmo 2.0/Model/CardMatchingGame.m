//
//  CardMatchingGame.m
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/10/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite ) NSInteger lastScore;


@end


@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards  = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i=0; i< count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self=nil;
                break;
            }
        }
        
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return self.cards[index] ? self.cards[index] : nil;
}

- (NSInteger)maxMatchingCards
{
    if (_maxMatchingCards < 2) {
        _maxMatchingCards = 2;
    }
    return _maxMatchingCards;
}



static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match agains other cards
            //Get an array of all the matched cards, otherCards
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            
            self.lastScore = 0;
            self.lastChosenCards = [otherCards arrayByAddingObject:card];
            
            if ([otherCards count] + 1 == self.maxMatchingCards) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    self.lastScore += matchScore * MATCH_BONUS;
                    
                    card.matched = YES;
                    
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.lastScore -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}
@end
