let squareCount = 16;
let gridSize = 500;
let squareColor = "blue";

let useRandomColors = false;

const container = document.querySelector("#grid-container");
const gridResolutionButton = document.querySelector("#resolution-button");
const gridResetButton = document.querySelector("#reset-button");
const colorButton = document.querySelector("#color-button");
    
gridResolutionButton.addEventListener("click", updateSquareCount);
gridResetButton.addEventListener("click", resetGrid);
colorButton.addEventListener("click", () => {
    useRandomColors = !useRandomColors;
});

function createGrid(gridContainer, gridSize, squareCount){
    console.log(squareCount);

    gridContainer.style.height = gridSize + "px";
    gridContainer.style.width = gridSize + "px";

    let squareSize = gridSize / squareCount;

    for (let i = 1; i <= squareCount**2; i++){
        let gridSquare = document.createElement("div");
        gridSquare.style.height = squareSize + "px";
        gridSquare.style.width = squareSize + "px";
        gridSquare.classList.add("grid-square");
        gridSquare.addEventListener("mouseenter", () => {
            setSquareColor(gridSquare);
        });
        gridContainer.appendChild(gridSquare);
    }
}

function removeSquaresFromGrid(gridContainer){
    while(gridContainer.firstChild){
        gridContainer.removeChild(gridContainer.firstChild);
    }
}

function resetGrid(){
    for (const square of container.children){
        square.style.opacity = 0.0;
    }
}

function updateSquareCount(){
    let newCount = 0
    do {
        newCount = Number(prompt("How many squares? (2 to 100)", squareCount))
    } while (newCount < 2 || 100 < newCount || !Number.isInteger(newCount));
    removeSquaresFromGrid(container);
    createGrid(container,gridSize,newCount);
}

function setSquareColor(square){
    if(useRandomColors){
        let r = Math.floor(Math.random() * 256);
        let g = Math.floor(Math.random() * 256);
        let b = Math.floor(Math.random() * 256);
        square.style.backgroundColor = `rgb(${r}, ${g}, ${b})`;
    }else{
        square.style.backgroundColor = squareColor;
    }
    
    square.style.opacity = Number(square.style.opacity) + 0.1;
}

createGrid(container,gridSize,squareCount);
