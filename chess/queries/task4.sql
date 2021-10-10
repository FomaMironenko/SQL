SELECT chessman.id, chessman.type, color 
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
WHERE chessman.color = 'White' AND chessman.type = 'Pawn'