SELECT chessman.type, color 
FROM chessboard JOIN chessman ON chessboard.id = chessman.id
WHERE ASCII(cln) - 64 = row