var toggleTurn = function()  {
    if (turn.innerHTML == "X") { turn.innerHTML = "O"; }
    else { turn.innerHTML = "X"; }
}

function playPiece(piece)
{
    if (piece.className == "piece-empty" && turn.innerHTML == "X") {
    	piece.className = "piece-x";
    }
    else if (piece.className == "piece-empty" && turn.innerHTML == "O") {
    	piece.className = "piece-o";
    }
    toggleTurn(); 
}


window.onload = function()
{
    var cells = document.getElementsByClassName("piece-empty");

    var turn = document.getElementById("turn"); 
    //alert(turn); 

    for (var i = 0; i < cells.length; i++)  {
        cells[i].onmouseover = function() { this.style.border = "2px solid lime"; }
        cells[i].onmouseout = function() { this.style.border = "2px solid black"; }
        cells[i].onclick = function() { playPiece(this); }
    }
}
