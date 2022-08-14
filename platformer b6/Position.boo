namespace platformer_b6

import System
import ConsolePaint

class PositionNotFoundException(Exception):
	pass

struct Position:
	
	X as byte
	Y as byte
	
	public def constructor(x as byte, y as byte):
		
		X = x
		Y = y
		
	static public def DetectPosition(gameMap as ConsoleImage, index as ConsoleColor):
		
		for y in range(gameMap.Height):
			for x in range(gameMap.Width):
				if gameMap[x, y] == index:
					return Position(x, y)
					
		raise PositionNotFoundException()
		
	static public def Distance(pointA as Position, pointB as Position):
		return Math.Sqrt(Math.Pow(pointB.X - pointA.X, 2) + Math.Pow(pointB.Y - pointA.Y, 2))