require 'ekispert'

# Train Station
course_list = Ekispert::Course.get(viaList: '22828:22741', answerCount: 2, addStop: true)

# Local Bus
# course_list = Ekispert::Course.get(viaList: '51003:51487', answerCount: 2, addStop: true)

course_list.each.with_index(1) do |course, i|
  price_list = course.price_list
  route = course.route
  point_list = route.point_list
  line_list = route.line_list

  puts "======= Summary #{i} ======="
  puts "合計所要時間: #{route.total_required_time}分"
  puts "乗り換え回数: #{route.transfer_count}回"
  puts "合計金額: #{course.oneway_price}円"
  puts "出発時刻: #{route.departure_time.strftime("%H:%M")}"
  puts "到着時刻: #{route.arrival_time.strftime("%H:%M")}"
  puts "--- 定期代 ---"
  puts "1ヶ月: #{course.teiki1.oneway}円"
  puts "3ヶ月: #{course.teiki3.oneway}円"
  puts "6ヶ月: #{course.teiki6.oneway}円"
  puts "========================="

  line_list.each_with_index do |line, j|
    puts "#{line.departure_state.datetime.strftime('%H:%M')} #{point_list[j].station.name}"
    if line.line_symbol
      puts " | [#{line.line_symbol.name}] #{line.name} #{line.fare.oneway}円"
    else
      puts " | #{line.name}"
    end
  end
  puts "#{line_list[-1].arrival_state.datetime.strftime('%H:%M')} #{point_list[-1].station.name}"
  print "\n"

  puts "--- 停車駅一覧 ---"

  line_list.each_with_index do |line, s|
    next if ['walk', 'strange'].include?(line.type)
    puts "■ #{line.name}\n"
    line.stop_list[0...-1].each do |stop|
      puts "#{stop.departure_state.datetime.strftime('%H:%M')} #{stop.point.station.name}"
      puts " |"
    end
    puts "#{line.stop_list[-1].departure_state.datetime.strftime('%H:%M')} #{line.stop_list[-1].point.station.name}"
    print "\n"
  end
end

# ======= Summary 1 =======
# 合計所要時間: 14分
# 乗り換え回数: 0回
# 合計金額: 200円
# 出発時刻: 12:00
# 到着時刻: 12:14
# --- 定期代 ---
# 1ヶ月: 5820円
# 3ヶ月: 16580円
# 6ヶ月: 27920円
# =========================
# 12:00 東京
#  | [JC] ＪＲ中央・青梅線快速・青梅行 200円
# 12:14 新宿
#
# --- 停車駅一覧 ---
# ■ ＪＲ中央・青梅線快速・青梅行
# 12:00 東京
#  |
# 12:02 神田(東京都)
#  |
# 12:04 御茶ノ水
#  |
# 12:09 四ツ谷
#  |
# 12:14 新宿
#
# ======= Summary 2 =======
# 合計所要時間: 22分
# 乗り換え回数: 0回
# 合計金額: 200円
# 出発時刻: 12:09
# 到着時刻: 12:31
# --- 定期代 ---
# 1ヶ月: 7320円
# 3ヶ月: 20870円
# 6ヶ月: 39530円
# =========================
# 12:00 東京
#  | [M] 東京メトロ丸ノ内線・荻窪行 200円
# 12:20 新宿(東京メトロ)
#  | 徒歩
# 12:22 新宿
#
# --- 停車駅一覧 ---
# ■ 東京メトロ丸ノ内線・荻窪行
# 12:00 東京
#  |
# 12:02 銀座
#  |
# 12:04 霞ケ関(東京都)
#  |
# 12:06 国会議事堂前
#  |
# 12:09 赤坂見附
#  |
# 12:11 四ツ谷
#  |
# 12:14 四谷三丁目
#  |
# 12:15 新宿御苑前
#  |
# 12:17 新宿三丁目
#  |
# 12:20 新宿(東京メトロ)
