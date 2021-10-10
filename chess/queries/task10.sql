SELECT color
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
GROUP BY color
HAVING count(*) = (SELECT MAX(cnt)
	FROM (SELECT COUNT(*) as cnt 
		  FROM chessboard JOIN chessman ON chessboard.id = chessman.id
		  GROUP BY color
		 ) AS tab1
)