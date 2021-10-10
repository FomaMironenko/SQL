WITH white_king AS (
	SELECT row, cln, chessman.id
	FROM chessboard JOIN chessman ON chessboard.id = chessman.id
	WHERE chessman.color = 'White' AND chessman.type = 'King'
)

SELECT chessman.id,
	ABS(row - (SELECT row FROM white_king)) + 
	ABS(ASCII(cln) - (SELECT ASCII(cln) FROM white_king)) 
AS dist
FROM chessboard JOIN chessman ON 
chessboard.id = chessman.id
WHERE 	
ABS(row - (SELECT row FROM white_king)) +  
ABS(ASCII(cln) - (SELECT ASCII(cln) FROM white_king)) 
= (SELECT MIN(
		ABS(row - (SELECT row FROM white_king)) + 
		ABS(ASCII(cln) - (SELECT ASCII(cln) FROM white_king))
	)
	FROM chessboard JOIN chessman ON 
	chessboard.id = chessman.id AND 
	NOT(chessman.type = 'King' AND color = 'White')
)
