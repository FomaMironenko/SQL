SELECT chessman.id, 
ABS(row - (SELECT row
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'WHITE' AND chessman.type = 'KING'
)) + 
ABS(ASCII(col) - (SELECT ASCII(col)
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'WHITE' AND chessman.type = 'KING'
)) AS dist

FROM chessboard JOIN chessman ON 
chessboard.id = chessman.id

WHERE ABS(row - (SELECT row
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'WHITE' AND chessman.type = 'KING'
)) +  ABS(ASCII(col) - (SELECT ASCII(col)
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'WHITE' AND chessman.type = 'KING'
)) 
= 
(SELECT MIN(ABS(row - (SELECT row
		FROM chessboard JOIN chessman ON chessboard.id = chessman.id
		WHERE chessman.color = 'WHITE' AND chessman.type = 'KING'
	)) +  ABS(ASCII(col) - (SELECT ASCII(col)
		FROM chessboard JOIN chessman ON chessboard.id = chessman.id
		WHERE chessman.color = 'WHITE' AND chessman.type = 'KING'
	))) 
	FROM chessboard JOIN chessman ON 
	chessboard.id = chessman.id AND 
	NOT(chessman.type = 'KING' and color = 'WHITE')
)
