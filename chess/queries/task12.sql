SELECT color
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
GROUP BY color, chessman.type
HAVING COUNT(chessman.id) = 8 AND chessman.type = 'Pawn'