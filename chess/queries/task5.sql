SELECT chessman.type, color 
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
WHERE ASCII(col) - 64 = row