//
//  CardGameViewController.m
//  Matchissmo 2.0
//
//  Created by Joan Coyne on 6/6/14.
//  Copyright (c) 2014 Dorado Web Development. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;




@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game)
    { _game  = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self createDeck]];
        [self touchSegmentedControl:self.modeSelector];
        
    }
    return _game;
}


- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}





- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    //If the mmodeSector is enabled, disable it
    self.modeSelector.enabled = NO;
    [self updateUI] ;
  }
- (IBAction)touchDealButton:(id)sender {
    self.game = nil;
    self.modeSelector.enabled = YES;
   [self updateUI] ;
    
}
- (IBAction)touchSegmentedControl:(UISegmentedControl *)sender {
    self.game.maxMatchingCards = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex].integerValue;
    
    
}

- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        if (self.game) {
            NSString *description = @"";
            if ([self.game.lastChosenCards count]) {
                NSMutableArray *cardContents = [NSMutableArray array];
                for (Card *card in self.game.lastChosenCards) {
                    [cardContents addObject:card.contents];
                }
                description = [cardContents componentsJoinedByString:@" "];
            }
            
            if (self.game.lastScore > 0) {
                description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
            } else if (self.game.lastScore < 0) {
                
                description = [NSString stringWithFormat:@"%@ don’t match! %d point penalty!", description, -self.game.lastScore];
            }
            
             self.resultsLabel.text = description;
        }
       
    }


}
- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
