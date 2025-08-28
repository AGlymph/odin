let humanScore = 0;
let computerScore = 0;
let currentRound = 1;
let maxRound = 5;

const humanScoreText = document.querySelector("#humanScore");
const computerScoreText = document.querySelector("#computerScore");
const roundCounter = document.querySelector("#roundCounter");
const message = document.querySelector("#message");

const buttons = document.querySelectorAll("button");


buttons.forEach((button) => {
    button.addEventListener("click", function (e){
       playRound(button.id);
    });
});

roundCounter.textContent = "round: " + currentRound + "/" + maxRound;

function getComputerChoice(){
    switch(Math.floor(Math.random() *3)){
        case 0:
            return "r";
        case 1:
            return "p";
        case 2:
            return "s";
    }
}

// function getHumanChoice(){
//     return prompt("r,p,s?").toLowerCase();
// }

function playRound(humanChoice){
    let computerChoice = getComputerChoice();
    let humanWon = false; 

    switch (humanChoice){
        case "r":
            if (computerChoice == "p"){
                break;
            } else{
                humanWon = true;
            }
        case "p":
            if (computerChoice == "s"){
                break;
            } else{
                humanWon = true;
            }
        case "s":
            if (computerChoice == "r"){
                console.log("yo");
                break;
            } else{
                console.log("hi");
                humanWon = true;
            }
        default:
            break;
    }

    handleWinner(humanWon);

    if(currentRound < maxRound){
        currentRound++;
        roundCounter.textContent = "round: " + currentRound + "/" + maxRound;
    } else{
        if(humanScore > computerScore) {
            message.textContent = "Game Over! You Won!"
        } else {
            message.textContent = "Game Over! You Lost!"
        }

        currentRound = 1;
        humanScore = 0;
        computerScore = 0;
    }
   
}

function handleWinner(humanWon){
    if (humanWon){
        humanScore ++;
        message.textContent = "you won the round!";
        humanScoreText.textContent = "player score: " + humanScore;
        computerScoreText.textContent = "computer score: " + computerScore;
    } else{
        computerScore++;
        message.textContent = "you lost the round :(";
        humanScoreText.textContent = "player score: " + humanScore;
        computerScoreText.textContent = "computer score: " + computerScore;
    }
}



// for (let round = 1; round <= 5; round++){
//     console.log("Round: " + round);
//     let roundWinner = playRound(getHumanChoice(),getComputerChoice());
//     handleWinner(roundWinner);
// }


// if (humanScore > computerScore){
//     console.log("You won the game!");
// }else{
//     console.log("You lost the game!");
// }
// console.log("Goodbye!!");