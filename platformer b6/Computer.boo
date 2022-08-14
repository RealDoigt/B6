namespace platformer_b6

import System
import ConsolePaint

class Computer(Player):
	
	static r = Random()
	glyph as char
	color as ConsoleColor
	turnAroundCount as byte = r.Next(5)
	refPlayer as Player
	nextAction = {Console.Write("No action found")}
	
	public def constructor(pos as Position, life as byte, glyph as char, color as ConsoleColor, refPlayer as Player):
		super(pos, life)
		
		self.glyph = glyph
		self.color = color
		self.refPlayer = refPlayer
		
	public def Patrol(gameMap as ConsoleImage):
		
		if turnAroundCount != 0 and gameMap[Pos.X + 1, Pos.Y] == ConsoleColor.Black:
			
			ErasePast()
			++Pos.X
			--turnAroundCount
		
		elif turnAroundCount != 5 and Pos.X > 0 and gameMap[Pos.X - 1, Pos.Y] == ConsoleColor.Black:
			
			ErasePast()
			--Pos.X
			++turnAroundCount
			
	public def RunNextAction():
		nextAction()
		
	public def Draw():
		
		Console.CursorTop = Pos.Y
		Console.CursorLeft = Pos.X
		Console.Write(glyph)
