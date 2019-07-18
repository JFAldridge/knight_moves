class Chess
    def initialize(knight_placement, knight_destination)
      @board = create_board
      create_pieces(knight_placement, knight_destination)
    end
      attr_accessor :board
  
    def create_board
      Array.new(8) { Array.new(8, "o") }
    end
  
    def create_pieces(k_p, k_d)
      b_knight = Knight.new('b' , self, k_p, k_d)
      set_pieces(b_knight, k_p)
    end
  
    def set_pieces(b_knight, k_p)
      @board[k_p[0]][k_p[1]] = b_knight
    end
  
    def print_board
      @board.each{|arr| arr.each{|i| puts i}}
    end
  end
  
  class Knight
    KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    
    def initialize(b_or_w, game, position, k_d)
      @b_or_w = b_or_w
      @game = game
      @root = MoveNode.new(position)
      @destination = k_d
      build_move_tree
    end
  
    def build_move_tree(node=@root, i=0)
      return if i == 6
  
      move_positions = KNIGHT_MOVES.map {|move_arr| move_arr.map.with_index {|move, i| move + node.pos[i]}}.select {|move_arr| (0..7).include?(move_arr[0]) && (0..7).include?(move_arr[1]) }
      
      move_positions.each {|moved_arr| node.children << MoveNode.new(moved_arr, node) } 
  
      node.children.each {|child| @game.board[child.pos[0]][child.pos[1]] = child}
  
      node.children.each {|child| build_move_tree(child, i + 1) }
    end
  
  end
  
  class MoveNode
    def initialize(pos, parent=nil)
      @pos = pos
      @parent = parent
      @children = []
    end
    attr_accessor :pos, :parent, :children
  end
  
  new_game = Chess.new([0, 0])
  new_game.print_board
  