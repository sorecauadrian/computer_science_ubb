% using prolog to solve puzzles similar to eistein's 5 houses problem (or zebra puzzles).

% https://www.brainzilla.com/logic/zebra/new-years-resolutions/
% five women are side by side talking about their new year's resolutions. 
% follow the clues to find out what stacy is planning to do next year.


% 1. the woman wearing the White shirt is somewhere between the woman drinking cranberry juice and the 30-year-old woman, in that order.
% 2. karen is at the second position.
% 3. the woman who wants to write a Book is somewhere to the left of the woman wearing the red shirt.
% 4. monique is drinking Orange juice.
% 5. todd's girlfriend is somewhere between austin's girlfriend and jeffery's girlfriend, in that order.
% 6. the 34-year-old woman is next to the 32-year-old woman.
% 7. brandy is somewhere to the right of the woman wearing the white shirt.
% 8. at the fourth position is cory's girlfriend.
% 9. the woman drinking pineapple juice is somewhere between austin's girlfriend and the woman drinking lemon juice, in that order.
% 10. alexis is somewhere to the right of the woman wearing the white shirt.
% 11. the lady wearing the red shirt is somewhere to the left of evan's girlfriend.
% 12. at the fourth position is the 28-year-old woman.
% 13. brandy is next to the woman who is drinking lemon juice.
% 14. the woman who wants to earn more money is exactly to the left of the woman who wants to lose weight.
% 15. the woman drinking mango juice is exactly to the left of the woman that wants to travel more.
% 16. the lady wearing the green shirt is somewhere between todd's girlfriend and the lady wearing the red shirt, in that order.
% 17. at the first position is the woman who wants to learn a new language.
% 18. the woman drinking orange juice is somewhere to the right of the woman wearing the red shirt.
% 19. the woman wearing the purple shirt is next to the oldest woman.
% 20. the 32-year-old lady wants to earn more money.

:- use_rendering(table, [header(woman('shirt', 'name', 'resolution', 'boyfriend', 'age', 'juice'))]).

somewhereToTheLeft(Woman1, Woman2, List):- append(_, [Woman1, Woman2|_], List).
somewhereToTheLeft(Woman1, Woman2, List):- append(_, [Woman1, _, Woman2|_], List).
somewhereToTheLeft(Woman1, Woman2, List):- append(_, [Woman1, _, _, Woman2|_], List).
somewhereToTheLeft(Woman1, Woman2, List):- append(_, [Woman1, _, _, _, Woman2|_], List).
somewhereToTheLeft(Woman1, Woman2, List):- append(_, [Woman1, _, _, _, _, Woman2|_], List).

somewhereToTheRight(Woman1, Woman2, List):- append(_, [Woman2, Woman1|_], List).
somewhereToTheRight(Woman1, Woman2, List):- append(_, [Woman2, _, Woman1|_], List).
somewhereToTheRight(Woman1, Woman2, List):- append(_, [Woman2, _, _, Woman1|_], List).
somewhereToTheRight(Woman1, Woman2, List):- append(_, [Woman2, _, _, _, Woman1|_], List).
somewhereToTheRight(Woman1, Woman2, List):- append(_, [Woman2, _, _, _, _, Woman1|_], List).

exactlyToTheLeft(Woman1, Woman2, List):- append(_, [Woman1, Woman2|_], List).
exactlyToTheRight(Woman1, Woman2, List):- append(_, [Woman2, Woman1|_], List).

nextTo(Woman1, Woman2, List):- append(_, [Woman1, Woman2|_], List).
nextTo(Woman1, Woman2, List):- append(_, [Woman2, Woman1|_], List).

somewhereBetween(Woman1, Woman2, Woman3, List):- append(_, [Woman2, Woman1, Woman3|_], List).
somewhereBetween(Woman1, Woman2, Woman3, List):- append(_, [Woman2, _, Woman1, Woman3|_], List).
somewhereBetween(Woman1, Woman2, Woman3, List):- append(_, [Woman2, Woman1, _, Woman3|_], List).
somewhereBetween(Woman1, Woman2, Woman3, List):- append(_, [Woman2, _, _, Woman1, Woman3|_], List).
somewhereBetween(Woman1, Woman2, Woman3, List):- append(_, [Woman2, Woman1, _, _, Woman3|_], List).
somewhereBetween(Woman1, Woman2, Woman3, List):- append(_, [Woman2, _, Woman1, _, Woman3|_], List).

women(Women):-  length(Women, 5),
    			Women = [woman(_, _, language, _, _, _), woman(_, karen, _, _, _, _), woman(_, _, _, _, _, _), woman(_, _, _, cory, 28, _), woman(_, _, _, _, _, _)], % 2, 8, 12, 17
                somewhereBetween(woman(white, _, _, _, _, _), woman(_, _, _, _, _, cranberry), woman(_, _, _, _, 30, _), Women), % 1
                somewhereToTheLeft(woman(_, _, book, _, _, _), woman(red, _, _, _, _, _), Women), % 3
                member(woman(_, monique, _, _, _, orange), Women), % 4
                somewhereBetween(woman(_, _, _, todd, _, _), woman(_, _, _, austin, _, _), woman(_, _, _, jeffery, _, _), Women), % 5
                nextTo(woman(_, _, _, _, 34, _), woman(_, _, _, _, 32, _), Women), % 6
                somewhereToTheRight(woman(_, brandy, _, _, _, _), woman(white, _, _, _, _, _), Women), % 7
                somewhereBetween(woman(_, _, _, _, _, pineapple), woman(_, _, _, austin, _, _), woman(_, _, _, _, _, lemon), Women), % 9
                somewhereToTheRight(woman(_, alexis, _, _, _, _), woman(white, _, _, _, _, _), Women), % 10   
                somewhereToTheLeft(woman(red, _, _, _, _, _), woman(_, _, _, evan, _, _), Women), % 11
                nextTo(woman(_, brandy, _, _, _, _), woman(_, _, _, _, _, lemon), Women), % 13
                exactlyToTheLeft(woman(_, _, money, _, _, _), woman(_, _, weight, _, _, _), Women), % 14
                exactlyToTheLeft(woman(_, _, _, _, _, mango), woman(_, _, travel, _, _, _), Women), % 15
                somewhereBetween(woman(green, _, _, _, _, _), woman(_, _, _, todd, _, _), woman(red, _, _, _, _, _), Women), % 16 
                somewhereToTheRight(woman(_, _, _, _, _, orange), woman(red, _, _, _, _, _), Women), % 18
                nextTo(woman(purple, _, _, _, _, _), woman(_, _, _, _, 34, _), Women), % 19
                member(woman(_, _, money, _, 32, _), Women), % 20
                member(woman(yellow, _, _, _, _, _), Women),
                member(woman(_, stacy, _, _, _, _), Women),
                member(woman(_, _, _, _, 26, _), Women), !.
    
stacys_resolution(Resolution):- women(Women),
    							member(woman(_, stacy, Resolution, _, _, _), Women), !.
    							
% woman(Women) => 

% shirt: 		purple, 	white, 		green, 		red, 		yellow
% name: 		stacy, 		karen, 		alexis, 	brandy, 	monique
% resolution: 	language, 	book, 		money, 		weight, 	travel
% boyfriend: 	austin, 	todd, 		jeffery, 	cory, 		evan
% age: 			26, 		34, 		32, 		28, 		30
% juice: 		cranberry, 	pineapple, 	lemon, 		mango, 		orange

  
% stacys_resolution(Resolution) =>

% Resolution = language
    
    
    
    