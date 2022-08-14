namespace platformer_b6

import System
import System.Text

class Player:
	
	protected pos as Position
	private life as byte
	private gravity as sbyte = 5 
	
	public Pos as Position:
		
		get:
			return pos
			
		set:
			pos = value
			
	public LifePoints as byte:
		
		get:
			return life
			
		set:
			if value >= 0:
				life = value
				
	public Gravity as sbyte:
		
		get:
			return gravity
	
	public def constructor(pos as Position, life as byte):
		
		self.pos = pos
		self.life = life
		
	public def constructor(pos as Position, life as byte, gravity as byte):
		
		self.pos = pos
		self.life = life
		self.gravity = gravity
		
	public def ErasePast():
		
		buffer = Encoding.UTF8.GetBytes(" ".ToCharArray())
		Console.CursorLeft = pos.X
		Console.CursorTop = pos.Y
		
		using writer = Console.OpenStandardOutput():
			writer.Write(buffer, 0, buffer.Length)