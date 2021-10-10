SELECT chessman.type, COUNT(*) as Nfigures
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
WHERE color = 'Black'
GROUP BY chessman.type