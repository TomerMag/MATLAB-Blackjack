Money=input('how much money do you have? ');
Deck=ceil(0.25:0.25:13);
Hand=[];
pchand=[];

while length(Deck) > 10 && Money > 0
    [rDeck, earn]=oneround(bet(Money),pchand,Hand,Deck);
    disp(earn);
    disp(rDeck);
    Deck = rDeck;
    Money = Money+earn;
end

function [rDeck, earn]=oneround(bet,pchand,Hand,Deck)
    for i=1:2
        [nDeck, Card]=draw(Deck);
        Hand=push(Hand,Card);
        Deck=nDeck;
    end
    for i=1:2
        [nDeck, Card]=draw(Deck);
        pchand=push(pchand,Card);
        Deck=nDeck;
    end
    fprintf('your cards: %g , %g \n',Hand(1),Hand(2));
    fprintf('pc cards: %g , ? \n',pchand(1));
    if hand(Hand) < 21
        answer = input('do you want to take another card? 1 = yes / 0 = no \n');
        while answer ~= 1 && answer ~= 0
            answer=input('please enter 1 or 0 \n');
        end
        while answer == 1 && hand(Hand) < 21
            [nDeck, Card]=draw(Deck);
            Hand=push(Hand,Card);
            Deck=nDeck;
            fprintf('your new card is %g \n',Card);
            
            if hand(Hand) < 21
                answer = input('do you want to take another card? 1 = yes / 0 = no \n');
                while answer ~= 1 && answer ~= 0
                    answer=input('please enter 1 or 0 \n');
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
