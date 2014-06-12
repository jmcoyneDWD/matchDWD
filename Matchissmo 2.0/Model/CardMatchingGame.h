//
//  CardMatchingGame.h
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/10/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject


//Designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly)NSInteger score;

@end
