namespace platformer_b6

import System
import ConsolePaint
import System.Threading

gameMap = ConsoleImage(Drawing.Bitmap("modules/native/main/map.png"))
player = Player(Position.DetectPosition(gameMap, ConsoleColor.Green), 5)
PLAYER_JUMP as byte = 4
gameMap[player.Pos.X, player.Pos.Y] = ConsoleColor.Black
gameMap.Paint()
#fallDelay as byte = 5
tickCount as byte = 0
enemies = Collections.Generic.List[of Computer]()


def FindEnemies():
	
	try:
		
		while true:
			
			enemyPos = Position.DetectPosition(gameMap, ConsoleColor.Red)
			enemies.Add(Computer(enemyPos, 1, char('X'), ConsoleColor.Red, player))
			gameMap[enemyPos.X, enemyPos.Y] = ConsoleColor.Black
			
	except:
		pass
		

def DetectCollision(x as byte, y as byte):
	
	if x < gameMap.Width and y < gameMap.Height:
		return gameMap[x, y] != ConsoleColor.Black
	
	return true
	
def GetInput():
	
	while true:
		
		input = Console.ReadKey(true).Key
		
		# Jumping
		if input == ConsoleKey.W and DetectCollision(player.Pos.X, player.Pos.Y + 1):
			for count in range(PLAYER_JUMP):
				if not DetectCollision(player.Pos.X, player.Pos.Y - 1):
					player.ErasePast()
					--player.Pos.Y
		
		# Dropping	
		elif input == ConsoleKey.S and not DetectCollision(player.Pos.X, player.Pos.Y + 1):
			player.ErasePast()
			++player.Pos.Y
				
		# Move left
		elif input == ConsoleKey.A and not DetectCollision(player.Pos.X - 1, player.Pos.Y):
			player.ErasePast()
			--player.Pos.X
		
		# Move right
		elif input == ConsoleKey.D and not DetectCollision(player.Pos.X + 1, player.Pos.Y):
			player.ErasePast()
			++player.Pos.X

FindEnemies()
Thread(GetInput).Start()

playerBuffer = Text.Encoding.UTF8.GetBytes("X".ToCharArray())

using writer = Console.OpenStandardOutput():
	
	while true:
		
		Thread.Sleep(75)
		++tickCount
		
		Console.CursorLeft = player.Pos.X
		Console.CursorTop = player.Pos.Y
		writer.Write(playerBuffer, 0, playerBuffer.Length)
		
		if tickCount == player.Gravity:
			
			if not DetectCollision(player.Pos.X, player.Pos.Y + 1):
				player.ErasePast()
				++player.Pos.Y
			
			tickCount = 0