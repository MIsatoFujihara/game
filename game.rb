# カレントディレクトリにあるファイルをrequire

# maruの状態(trueかfalseか)をtableの状態(int型)にして返す
# ○がおかれていたら表の状態は1,×がおかれていたら表の状態は2
def player_state(player)
  return player ? Maru : Batsu
end

 # 3つそろっていたらtrue,そうでなければfalseを返す関数
 # ClearCheckクラスを扱う
def call_clear(table, player)
  # table[0][0]は縦横斜め方向にそろっているかを調べる
  check = ClearCheck.new(0, 0, table, player)
  if check.naname()||check.yoko()||check.tate()
    return true
  end
  check2 = ClearCheck.new(1, 0, table, player)
  check3 = ClearCheck.new(2, 0, table, player)
  check4 = ClearCheck.new(0, 1, table, player)
  check5 = ClearCheck.new(0, 2 ,table, player)
  # table[1][0],table[2][0]は横方向にそろっているか調べる
  return true  if check2.yoko()
  return true  if check3.yoko()||check3.naname2()
  # table[0][1],tanle[0][2]は縦方向にそろっているか調べる
  return true  if check4.tate()
  return true  if check5.tate()
  # どこもそろっていなかったら0を返す
  return false
end
    
# 出力される表の位置番号をtableの添え字に変換
def number_index(num)
  x = (num - 1) % 3 
  y = (num - 1) / 3 
  return x, y
end

# tableの添え字を出力される表の位置番号に変換
def index_number(x, y)
  x + 1 + y * 3;
end

# 各要素の表示
def output(i, j, mark)
  (j + 1) % 3 == 0 ? third_column = true : third_row = false
  if mark == Maru
    print(" ○")
  elsif mark == Batsu
    print(" ×")
  else
    print(" #{index_number(j, i)} ")
  end
  print third_column ? "" : "｜"
end

# tableの行単位に制御
def output_rows(i, *pos)
  (i + 1) % 3 == 0 ? third_row = true : third_row = false
  print(" ")
  j = 0
  pos.each do |mark|
    output(i, j, mark)
    j += 1
  end
  print("\n")
  print third_row ? "\n" : " ---＋---＋---\n"
end

# tableの出力を列ごとに制御
def output_columns(table) 
  i = 0
  print("\n")
  table.each do |elm1, elm2, elm3|
    output_rows(i, elm1, elm2, elm3) 
    i += 1
  end
end

# Set_positioinクラスのインスタンスを扱う関数
# 入力に関する制御を行う
def call_set(num, table, player)
  x, y = number_index(num)
  pos = SetPosition.new(x, y, table, player)
  if  num > 9||num < 1||pos.check_position == false
    puts("もう一度入力してください")
    input(player, table)
  else
    # ○または×が置かれた新しいtableが帰ってくる
    pos.set_position
  end
end

# 入力を行う
def input(player, table)
  print("今は")
  puts player ? "○の番です\n":"×の番です\n"
  print("入力>")
  num = gets.to_i
  # ○または×が置かれた新しいtableが帰ってくる
  call_set(num, table, player)
end

# gameクリア画面の表示
def is_clear(player)
  print("winner>")
  puts player ? "○\n":"×\n"
end

# gameoverの判定
# 表が埋まっていたらgameover
def is_gameover?(i)
  return i >= 9 ? true :false 
end
# gameoverの表示
def view_gameover
  puts("gameover")
end

# gameを行う関数
def game(player, table)
  i = 0
  loop do
    table=input(player, table)
    output_columns(table)
    i += 1
    # gameclearの判定を行う
    if call_clear(table, player)
      is_clear(player)
      break
    end
    # gameoverの判定を行う
    if is_gameover?(i)
      view_gameover()
      break
    end
    player = !player # 今の手を反転的に変更
  end
end


