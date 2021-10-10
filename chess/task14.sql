SELECT chessman.id
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
WHERE 
ABS(row - (SELECT row
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'BLACK' AND chessman.type = 'KING'
)) <= 2 
  AND
ABS(ASCII(col) - (SELECT ASCII(col)
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'BLACK' AND chessman.type = 'KING'
)) <= 2 
  AND
NOT(chessman.color = 'BLACK' AND chessman.type = 'KING')