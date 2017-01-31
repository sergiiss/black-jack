require 'test_helper'

class TestPrinterNew < Minitest::Test
  def test_get_print
    printer = PrinterNew.new(21, 20).report_on_completion_of_the_game
    
    assert_equal "\nИгра окончена! У меня 21 очко, а у тебя 20 очков.\n\n" , printer
  end  
  
  def test_get_print
    printer = PrinterNew.new(21, 20).result_games
    
    assert_equal "Сегодня победа за мной!" , printer
  end  
end