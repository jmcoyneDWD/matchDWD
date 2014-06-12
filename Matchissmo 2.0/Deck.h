//
//  Deck.h
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/6/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;


@end
