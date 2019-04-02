// Defining neccessary variables

let playerHandValues = [];
let playerHandDisplay = [];
let dealerHandValues = [];
let dealerHandDisplay = [];
let dealerHiddenCard = [];

let images = ["2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S",
"6C", "6D", "6H","6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "10C", "10D", "10H", "10S",
"JC", "JD", "JH","JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS", "AC", "AD", "AH", "AS"]
let deck = [2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9,
10, 10, 10, 10, 'J', 'J', 'J', 'J', 'Q', 'Q', 'Q', 'Q', 'K', 'K', 'K', 'K', 'A', 'A', 'A', 'A'];

//Function for starting the game

function gameStart(){
  dealCard(2, 0);
  dealerDeal();
  document.getElementById("play").disabled = true;
}

// Removes the first item of a given value from an array, used for removing card from the deck
function delOneInstance(value, list){
  for (i = 0 ; i <= list.length ; i++){
    if(list[i] == value){
      list.splice(i, 1);
      break;
    }
  }
}

// Adds a given number of cards to the players hand, called at the beginning and when the player hits
function dealCard(numberOfCards){
  count = 0

  while(count < numberOfCards){
    let randomNumber = Math.floor(Math.random() * deck.length);
    playerHandDisplay.push(deck[randomNumber]);

    //Sets card images to appear to the players displayed hand, removes revealed cards from images
    let card = "Cards/" + images[randomNumber] + ".jpg";
    let element = "playerImage" + (playerHandDisplay.length).toString();

    document.getElementById(element).src = card;
    images.splice(randomNumber, 1);

    //Checks if players have Jack/Queen/King, converts them to their score value
    if (deck[randomNumber] == 'J' || deck[randomNumber] == 'Q' || deck[randomNumber] == 'K'){
      playerHandValues.push(10);
    } else if(deck[randomNumber] == 'A'){
      playerHandValues.push(11);
    } else{
      playerHandValues.push(deck[randomNumber]);
    }

    //Deletes the card that was drawn from the deck so it can't be drawn again
    delOneInstance(deck[randomNumber], deck);
    count ++
  }

  //Calls function to check player score, ends the game if it is over 21
  playerScore = scoreTally("player");
  if (playerScore > 21){
    gameOver();
  }

  document.getElementById("hit").disabled = false;
  document.getElementById("stay").disabled = false;
}

//adds cards to the dealers hand, setting one to be revealed, and adds more until dealer score is at least 16
function dealerDeal(){
  let dealerTotal = 0;
  while(dealerTotal < 16){ //Edit this number to make deler a bigger risk taker
    let randomNumber = Math.floor(Math.random() * deck.length);
    dealerHandDisplay.push(deck[randomNumber]);

      //Displays dealer cards on html page as images. First card is face down
      if(dealerHandValues != 0){
        let card = "Cards/" + images[randomNumber] + ".jpg";
        let element = "dealerImage" + (dealerHandValues.length + 1).toString();
        document.getElementById(element).src=card
        images.splice(randomNumber, 1);}

      else{
            dealerHiddenCard = "Cards/" + images[randomNumber] + ".jpg";
            images.splice(randomNumber, 1)
          }
      document.getElementById("dealerImage1").src="Cards/Gray_back.jpg";

    //Checks if dealer has Jack/Queen/King, converts them to their score value
    if (deck[randomNumber] == 'J' || deck[randomNumber] == 'Q' || deck[randomNumber] == 'K'){
      dealerHandValues.push(10);
    } else if(deck[randomNumber] == 'A'){
      dealerHandValues.push(11);
    } else{
      dealerHandValues.push(deck[randomNumber]);
    }

    // Adding up the dealer score
    dealerTotal += dealerHandValues[dealerHandValues.length - 1];
    if (dealerTotal > 21 && dealerHandValues[dealerHandValues.length - 1] == '11'){
      dealerTotal -=10;

    }
    //Deleting drawn card from the deck
    delOneInstance(deck[randomNumber], deck);
  }

}

// Returning player and dealer's score tally
function scoreTally(player){
  var playerScore = 0;
  var dealerScore = 0;
  var count = 0

  if (player == "player"){
    while(count<playerHandValues.length){
      playerScore += playerHandValues[count];

      if(playerScore > 21 && playerHandValues.includes(11)){
        let aceLocation = playerHandValues.indexOf(11)
        playerHandValues[aceLocation] -= 10;
        playerScore -= 10;
      }

      count++
    }
    return playerScore;

  }else{
    while(count < dealerHandValues.length){
      dealerScore += dealerHandValues[count];
      count++
    }
    return dealerScore;
  }
}

//Ending the game and comparing the score
function gameOver(){

  var playerScore = scoreTally("player");
  var dealerScore = scoreTally("dealer");

  if (playerScore > 21){
    document.getElementById("gameOverText").innerHTML =
    ("Your score is " + playerScore + ". That's over 21, you lose :(");

  }else if(dealerScore > 21){
    document.getElementById("gameOverText").innerHTML =
    ("The dealer went over 21, you win!! :)")

  }else if(playerScore > dealerScore){
    document.getElementById("gameOverText").innerHTML =
    ("Your score is " + playerScore + ". The dealers score is " + dealerScore + ". You win!! :)");

  }else if(dealerScore > playerScore){
    document.getElementById("gameOverText").innerHTML =
    ("Your score is " + playerScore + ". The dealers score is " + dealerScore + ". You lose :(");

  }else{
    document.getElementById("gameOverText").innerHTML =
    ("Your score is " + playerScore + ". The dealers score is " + dealerScore + ". You tied :/");
  }
  document.getElementById("dealerImage1").src=dealerHiddenCard;

  for(i=3; i<=8; i++){
    let location = "dealerImage" + i.toString();
    document.getElementById(location).style.display = "inline";
  }

  document.getElementById("hit").disabled = true;
  document.getElementById("stay").disabled = true;
}

//Reset function for restarting game

function gameReset(){
  playerHandValues = [];
  playerHandDisplay = [];
  dealerHandValues = [];
  dealerHandDisplay = [];
  images = ["2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H",
            "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "10C", "10D", "10H", "10S", "JC", "JD", "JH",
            "JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS", "AC", "AD", "AH", "AS"]
  deck = [2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9,
  10, 10, 10, 10, 'J', 'J', 'J', 'J', 'Q', 'Q', 'Q', 'Q', 'K', 'K', 'K', 'K', 'A', 'A', 'A', 'A'];

  document.getElementById("gameOverText").innerHTML = ("")
  document.getElementById("dealerHand").innerHTML = ("");
  document.getElementById('playerHand').innerHTML = ("");
  document.getElementById("play").disabled = false;

  for(i = 1; i <= 6; i++){
    let location = "playerImage" + i.toString();
    console.log(location);
    document.getElementById(location).src = "";
  }

  for(i = 1; i <= 6; i++){
    let location = "dealerImage" + i.toString();
    console.log(location);
    document.getElementById(location).src = "";
  }

  for(i = 3; i <= 6; i++){
    let location = "dealerImage" + i.toString();
    document.getElementById(location).style.display = "none";
  }
}
