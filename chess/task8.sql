SELECT chessman.type, COUNT(*) as Nfigures
FROM chessboard JOIN chessman ON chessboard.id = chessman.id 
WHERE color = 'BLACK'
GROUP BY chessman.type