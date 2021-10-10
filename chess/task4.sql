SELECT chessman.id, chessman.type, color 
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
WHERE color = 'WHITE' AND chessman.type = 'PAWN'