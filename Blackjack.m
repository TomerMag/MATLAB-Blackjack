Money=input('how much money do you have? '); %register the amount of money the user has
Deck=ceil(0.25:0.25:13); %create vector holding all cards
Hand=[];
pchand=[];

%shuffle the deck randomly
for i=1:round(randi(5))
Deck=shuffle(Deck,round(randi(5)));
end

% play rounds untill there are 10 or less cards in deck or player lost all
% money
while length(Deck) > 10 && Money > 0
    [rDeck, earn]=oneround(bet(Money),pchand,Hand,Deck);
    Deck = rDeck;
    Money = Money+earn;
    fprintf('you have %g money \n',Money);
end

%checks why the game stopped and prints accordingly
if Money <= 0
    fprintf('you lost all your money.\n GAME OVER');
else
    fprintf('there are less than 11 cards in the deck.\n GAME OVER');
end

%function of a single round
function [rDeck, earn]=oneround(bet,pchand,Hand,Deck)

    %give player two random cards from deck
    for i=1:2 
        [nDeck, Card]=draw(Deck);
        Hand=push(Hand,Card);
        Deck=nDeck;
    end

    %give pc two random cards from deck
    for i=1:2
        [nDeck, Card]=draw(Deck);
        pchand=push(pchand,Card);
        Deck=nDeck;
    end

    %shows the player his cards and a single card from the pc
    fprintf('your cards: %g , %g \n',Hand(1),Hand(2));
    fprintf('pc cards: %g , ? \n',pchand(1));

    %if player hand value lower than 21 ask him to take another card until
    %surpasses 21 or doesnt want another card
    if hand(Hand) < 21
        answer = input('do you want to take another card? 1 = yes / 0 = no \n');

        %if given unwanted input ask to give wanted input untill given
        while answer ~= 1 && answer ~= 0
            answer=input('please enter 1 or 0 \n');
        end

        %gives player another card from deck and shows it so him
        while answer == 1 && hand(Hand) < 21
            [nDeck, Card]=draw(Deck);
            Hand=push(Hand,Card);
            Deck=nDeck;
            fprintf('your new card is %g \n',Card);
            
            %ask the player if he wants another card
            if hand(Hand) < 21
                answer = input('do you want to take another card? 1 = yes / 0 = no \n');
                while answer ~= 1 && answer ~= 0
                    answer=input('please enter 1 or 0 \n');
                end
            end
        end
    end
    
    rDeck = Deck; %update deck

    %checks if the player won lost or tied and gives money and feedback accordingly
    if hand(pchand) == hand(Hand)
        earn = 0;
        fprintf('tie');
    elseif hand(pchand) < hand(Hand) && hand(Hand) <= 21
        earn = bet;
        fprintf('you earned %g \n',bet);
    else
        earn = bet*-1;
        fprintf('you lost %g \n',bet);
    end
end

%checks if player entered realistic amount of money he wants to bet
function bet=bet(money) 
    bet=input('how much money are you willing to bet? \n');
    while bet > money || bet <= 0
        if bet > money
            fprintf('you have only %g coins. please enter a lower sum of money. \n',money);
            bet=input('how much money are you willing to bet? \n');
        else
            fprintf('you cannot bet 0 or less coins \n');
            bet=input('how much money are you willing to bet? \n');
        end
    end
end

%calculates value of a hand according to game rules
function HandValue=hand(Hand)
    HandValue=0;
    for i=1:length(Hand)
        if Hand(i)>10
            HandValue=HandValue+10;
        elseif Hand(i)==1
            HandValue=HandValue+11;
        else
            HandValue=HandValue+Hand(i);
        end       
    end
end

%shuffles the deck
function vecshuffle=shuffle(vec,n)
    vecshuffle = [];
    for i=1:floor(length(vec)/n)
    
        [vecn,vec] = pop(vec,n);
        vecshuffle = push(vecshuffle,vecn);
    
    end
    vecshuffle = push(vecshuffle,vec);
end

%draws a single random card from deck
function [nDeck, Card]=draw(Deck)
    n = round(randi(length(Deck)));
    [vecn,vec]=pop(Deck,length(Deck)-n);
    Card = vec(end);
    vec(end)=[];
    nDeck=push(vec,vecn);
end

%takes out the last n values out of a given vector and presents the vector
%after the split and the vector that has been taken out
function [vecn, vec]=pop(vec,n)
    isr = isrow(vec);
    if isr==0
       vec=transpose(vec);
    end
    vecn = [];
    if n > length(vec)
        error('n is no good');
    end
    for i=1:n
       vecn=[vec(end),vecn];
       vec(end)=[];
    end
    if isr==0
        vec=transpose(vec);
        vecn=transpose(vecn);
    end
end

%places a given value or vector infront of a given value or vector
function vec=push(vec,x)
    isr=isrow(vec);
    if isr==0
       vec=transpose(vec);
    end
    vec = [vec,x];
    if isr == 0
        vec=transpose(vec);
    end
end


            end
        end
    end
    
    rDeck = Deck;

    if hand(pchand) == hand(Hand)
        earn = 0;
    elseif hand(pchand) < hand(Hand) && hand(Hand) <= 21
        earn = bet;
    else
        earn = bet*-1;
    end
end

function bet=bet(money) 
    bet=input('how much money are you willing to bet? \n');
    while bet > money
        bet=input('you have only %g coins. please enter a lower sum of money. \n',money);
    end
end

function HandValue=hand(Hand)
    HandValue=0;
    for i=1:length(Hand)
        if Hand(i)>10
            HandValue=HandValue+10;
        elseif Hand(i)==1
            HandValue=HandValue+11;
        else
            HandValue=HandValue+Hand(i);
        end       
    end
end

function [nDeck, Card]=draw(Deck)
    n = round(randi(length(Deck)));
    [vecn,vec]=pop(Deck,52-n);
    Card = vec(end);
    vec(end)=[];
    nDeck=push(vec,vecn);
end

function [vecn, vec]=pop(vec,n)
    vecn=[];
    if n>length(vec)
        error('n is no good\n');
    end
    for i=1:n
       vecn=[vec(end),vecn];
       vec(end)=[];
    end
end

function vec=push(vec,x)
    isr=isrow(vec);
    if isr==0
       vec=transpose(vec);
    end
    vec=[vec,x];
    if isr==0
        transpose(vec);
    end
end
